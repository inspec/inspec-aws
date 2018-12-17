# AWS Terraform Templates for InSpec Testing

terraform {
  required_version = "~> 0.11.10"
}

# Configure variables

variable "aws_region" {}
variable "aws_vpc_name" {}
variable "aws_vpc_instance_tenancy" {}
variable "aws_vpc_cidr_block" {}
variable "aws_subnet_name" {}
variable "aws_availability_zone" {}
variable "aws_vm_name" {}
variable "aws_vm_size" {}
variable "aws_vm_image_filter" {}
variable "aws_enable_creation" {}
variable "aws_ebs_volume_name" {}
variable "aws_key_description_enabled" {}
variable "aws_key_description_disabled" {}
variable "aws_internet_gateway_name" {}
variable "aws_bucket_public_name" {}
variable "aws_bucket_private_name" {}
variable "aws_bucket_public_objects_name" {}
variable "aws_bucket_auth_name" {}
variable "aws_bucket_acl_policy_name" {}
variable "aws_bucket_log_delivery_name" {}
variable "aws_bucket_log_sender_name" {}
variable "aws_bucket_logging_disabled" {}
variable "aws_bucket_encryption_enabled" {}
variable "aws_bucket_encryption_disabled" {}
variable "aws_sns_topic_with_subscription" {}
variable "aws_sns_topic_no_subscription" {}
variable "aws_sns_topic_subscription_sqs" {}

provider "aws" {
  version = "= 1.48.0"
  region     = "${var.aws_region}"
}

data "aws_caller_identity" "creds" {}

# default VPC always exists for every AWS region
data "aws_vpc" "default" {
  default = "true"
}

resource "aws_vpc" "inspec_vpc" {
  count            = "${var.aws_enable_creation}"
  cidr_block       = "${var.aws_vpc_cidr_block}"
  instance_tenancy = "${var.aws_vpc_instance_tenancy}"

  tags {
    Name = "${var.aws_vpc_name}"
  }
}

resource "aws_subnet" "inspec_subnet" {
  count             = "${var.aws_enable_creation}"
  vpc_id            = "${aws_vpc.inspec_vpc.id}"
  availability_zone = "${var.aws_availability_zone}"
  cidr_block        = "${cidrsubnet(aws_vpc.inspec_vpc.cidr_block, 1, 1)}" # will result in /28 (or 16) IP addresses

  tags {
    Name = "${var.aws_subnet_name}"
  }
}


data "aws_ami" "linux_ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["${var.aws_vm_image_filter}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "linux_ubuntu_vm" {
  count         = "${var.aws_enable_creation}"
  ami           = "${data.aws_ami.linux_ubuntu.id}"
  instance_type = "${var.aws_vm_size}"

  tags {
    Name = "${var.aws_vm_name}"
  }
}

resource "aws_ebs_volume" "inspec_ebs_volume" {
  count             = "${var.aws_enable_creation}"
  availability_zone = "${var.aws_availability_zone}"
  size              = 1

  tags {
    Name = "${var.aws_ebs_volume_name}"
  }
}

resource "aws_kms_key" "kms_key_enabled_rotating" {
  count                   = "${var.aws_enable_creation}"
  description             = "${var.aws_key_description_enabled}"
  deletion_window_in_days = 10
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = true
  enable_key_rotation     = true
}

resource "aws_kms_key" "kms_key_disabled_non_rotating" {
  count                   = "${var.aws_enable_creation}"
  description             = "${var.aws_key_description_disabled}"
  deletion_window_in_days = 10
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = false
  enable_key_rotation     = false
}

resource "aws_internet_gateway" "inspec_internet_gateway" {
  count  = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"

  tags {
    Name = "${var.aws_internet_gateway_name}"
  }
}

resource "aws_route_table" "route_table_first" {
  count  = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"

  route {
    cidr_block = "10.0.0.0/25"
    gateway_id = "${aws_internet_gateway.inspec_internet_gateway.id}"
  }
}

resource "aws_route_table" "route_table_second" {
  count  = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"

  route {
    cidr_block = "10.0.0.0/25"
    gateway_id = "${aws_internet_gateway.inspec_internet_gateway.id}"
  }
}

resource "aws_s3_bucket" "bucket_public" {
  count         = "${var.aws_enable_creation}"
  bucket        = "${var.aws_bucket_public_name}"
  acl           = "public-read"
}

resource "aws_s3_bucket" "bucket_private" {
  count         = "${var.aws_enable_creation}"
  bucket        = "${var.aws_bucket_private_name}"
  acl           = "private"
}

resource "aws_s3_bucket" "bucket_public_for_objects" {
  count         = "${var.aws_enable_creation}"
  bucket        = "${var.aws_bucket_public_objects_name}"
  acl           = "public-read"
}

resource "aws_s3_bucket" "bucket_auth" {
  count         = "${var.aws_enable_creation}"
  bucket        = "${var.aws_bucket_auth_name}"
  acl           = "authenticated-read"
}

resource "aws_s3_bucket" "bucket_private_acl_public_policy" {
  count         = "${var.aws_enable_creation}"
  bucket        = "${var.aws_bucket_acl_policy_name}"
  acl           = "private"
}

resource "aws_s3_bucket" "bucket_log_delivery" {
  count         = "${var.aws_enable_creation}"
  bucket        = "${var.aws_bucket_log_delivery_name}"
  force_destroy = true
  acl           = "log-delivery-write"
}

resource "aws_s3_bucket" "bucket_access_logging_enabled" {
  count  = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_log_sender_name}"
  acl    = "private"

  logging {
    target_bucket = "${aws_s3_bucket.bucket_log_delivery.id}"
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "bucket_access_logging_not_enabled" {
  count         = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_logging_disabled}"
  acl    = "private"
}


resource "aws_s3_bucket" "bucket_default_encryption_enabled" {
  count  = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_encryption_enabled}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket_default_encryption_disabled" {
  count  = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_encryption_disabled}"
  acl    = "private"
}


resource "aws_s3_bucket_policy" "allow_public" {
  count  = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_public.id}"
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_public.id}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "deny_private" {
  count  = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_private.id}"
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyGetObject",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_private.id}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_policy" "allow-private-acl-public-policy" {
  count  = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_private_acl_public_policy.id}"
  policy =<<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_private_acl_public_policy.id}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_object" "inspec_logo_public" {
  count  = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_public_for_objects.id}"
  key    = "inspec-logo-public"
  source = "inspec-logo.png"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "inspec_logo_private" {
  count  = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_public_for_objects.id}"
  key    = "inspec-logo-private"
  source = "inspec-logo.png"
  acl    = "private"
}

resource "aws_sns_topic" "sns_topic_subscription" {
  //  count = "${var.aws_enable_creation}"
  name  = "${var.aws_sns_topic_with_subscription}"
}

resource "aws_sqs_queue" "sns_sqs_queue" {
  //  count = "${var.aws_enable_creation}"
  name = "${var.aws_sns_topic_subscription_sqs}"
}

resource "aws_sns_topic_subscription" "sqs_test_queue_subscription" {
  //  count = "${var.aws_enable_creation}"
  topic_arn = "${aws_sns_topic.sns_topic_subscription.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.sns_sqs_queue.arn}"
}

resource "aws_sns_topic" "sns_topic_no_subscription" {
  //  count = "${var.aws_enable_creation}"
  name = "${var.aws_sns_topic_no_subscription}"
}