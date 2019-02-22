# AWS Terraform Templates for InSpec Testing

terraform {
  required_version = "~> 0.11.10"
}

# Configure variables

variable "aws_region" {}
variable "aws_availability_zone" {}

variable "aws_auto_scaling_group" {}
variable "aws_bucket_acl_policy_name" {}
variable "aws_bucket_auth_name" {}
variable "aws_bucket_encryption_disabled" {}
variable "aws_bucket_encryption_enabled" {}
variable "aws_bucket_log_delivery_name" {}
variable "aws_bucket_log_sender_name" {}
variable "aws_bucket_logging_disabled" {}
variable "aws_bucket_private_name" {}
variable "aws_bucket_public_name" {}
variable "aws_bucket_public_objects_name" {}
variable "aws_cloud_trail_bucket_name" {}
variable "aws_cloud_trail_key_description" {}
variable "aws_cloud_trail_log_group" {}
variable "aws_cloud_trail_name" {}
variable "aws_cloud_trail_open_name" {}
variable "aws_cloud_watch_alarm_metric_name" {}
variable "aws_cloud_watch_alarm_name" {}
variable "aws_cloud_watch_log_metric_filter_log_group_name" {}
variable "aws_cloud_watch_log_metric_filter_metric_name" {}
variable "aws_cloud_watch_log_metric_filter_name" {}
variable "aws_cloud_watch_log_metric_filter_namespace" {}
variable "aws_cloud_watch_log_metric_filter_pattern" {}
variable "aws_cloud_watch_log_metric_filter_two_log_group_name" {}
variable "aws_cloud_watch_log_metric_filter_two_metric_name" {}
variable "aws_cloud_watch_log_metric_filter_two_name" {}
variable "aws_cloud_watch_log_metric_filter_two_namespace" {}
variable "aws_cloud_watch_log_metric_filter_two_pattern" {}
variable "aws_cloud_watch_logs_role_name" {}
variable "aws_cloud_watch_logs_role_policy_name" {}
variable "aws_configuration_recorder_name" {}
variable "aws_configuration_recorder_role" {}
variable "aws_create_configuration_recorder" {}
variable "aws_delivery_channel_bucket_name" {}
variable "aws_delivery_channel_frequency" {}
variable "aws_delivery_channel_name" {}
variable "aws_delivery_channel_sns_topic_name" {}
variable "aws_ebs_volume_name" {}
variable "aws_ecs_cluster_name" {}
variable "aws_eks_cluster_name" {}
variable "aws_eks_role_name" {}
variable "aws_eks_subnet_name_1" {}
variable "aws_eks_subnet_name_2" {}
variable "aws_eks_vpc_name" {}
variable "aws_elb_access_log_name" {}
variable "aws_elb_access_log_prefix" {}
variable "aws_elb_name" {}
variable "aws_enable_creation" {}
variable "aws_flow_log_bucket_name" {}
variable "aws_iam_group_name" {}
variable "aws_iam_role_generic_name" {}
variable "aws_iam_user_name" {}
variable "aws_iam_user_policy_name" {}
variable "aws_internet_gateway_name" {}
variable "aws_iam_policy_name" {}
variable "aws_key_description_disabled" {}
variable "aws_key_description_enabled" {}
variable "aws_launch_configuration_name" {}
variable "aws_rds_db_engine" {}
variable "aws_rds_db_engine_version" {}
variable "aws_rds_db_identifier" {}
variable "aws_rds_db_master_user" {}
variable "aws_rds_db_name" {}
variable "aws_rds_db_storage_type" {}
variable "aws_security_group_alpha" {}
variable "aws_security_group_beta" {}
variable "aws_security_group_gamma" {}
variable "aws_security_group_omega" {}
variable "aws_sqs_queue_name" {}
variable "aws_sns_topic_no_subscription" {}
variable "aws_sns_topic_subscription_sqs" {}
variable "aws_sns_topic_with_subscription" {}
variable "aws_subnet_name" {}
variable "aws_vm_image_filter" {}
variable "aws_vm_name" {}
variable "aws_vm_size" {}
variable "aws_vpc_cidr_block" {}
variable "aws_vpc_instance_tenancy" {}
variable "aws_vpc_name" {}

provider "aws" {
  version = "= 1.48.0"
  region = "${var.aws_region}"
}

data "aws_caller_identity" "creds" {}
data "aws_region" "current" {}

# default VPC always exists for every AWS region
data "aws_vpc" "default" {
  default = "true"
}

resource "aws_vpc" "inspec_vpc" {
  count = "${var.aws_enable_creation}"
  cidr_block = "${var.aws_vpc_cidr_block}"
  instance_tenancy = "${var.aws_vpc_instance_tenancy}"

  tags {
    Name = "${var.aws_vpc_name}"
  }
}

resource "aws_subnet" "inspec_subnet" {
  count = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"
  availability_zone = "${var.aws_availability_zone}"
  cidr_block = "${cidrsubnet(aws_vpc.inspec_vpc.cidr_block, 1, 1)}"
  # will result in /28 (or 16) IP addresses

  tags {
    Name = "${var.aws_subnet_name}"
  }
}


data "aws_ami" "linux_ubuntu" {

  most_recent = true

  filter {
    name = "name"
    values = [
      "${var.aws_vm_image_filter}"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  owners = [
    "099720109477"]
  # Canonical
}

resource "aws_instance" "linux_ubuntu_vm" {
  count = "${var.aws_enable_creation}"
  ami = "${data.aws_ami.linux_ubuntu.id}"
  instance_type = "${var.aws_vm_size}"

  tags {
    Name = "${var.aws_vm_name}"
  }
}

resource "aws_ebs_volume" "inspec_ebs_volume" {
  count = "${var.aws_enable_creation}"
  availability_zone = "${var.aws_availability_zone}"
  size = 1

  tags {
    Name = "${var.aws_ebs_volume_name}"
  }
}

# KMS Keys
resource "aws_kms_key" "kms_key_enabled_rotating" {
  count = "${var.aws_enable_creation}"
  description = "${var.aws_key_description_enabled}"
  deletion_window_in_days = 10
  key_usage = "ENCRYPT_DECRYPT"
  is_enabled = true
  enable_key_rotation = true
}

resource "aws_kms_key" "kms_key_disabled_non_rotating" {
  count = "${var.aws_enable_creation}"
  description = "${var.aws_key_description_disabled}"
  deletion_window_in_days = 10
  key_usage = "ENCRYPT_DECRYPT"
  is_enabled = false
  enable_key_rotation = false
}


# Route tables
resource "aws_internet_gateway" "inspec_internet_gateway" {
  count = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"

  tags {
    Name = "${var.aws_internet_gateway_name}"
  }
}

resource "aws_route_table" "route_table_first" {
  count = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"

  route {
    cidr_block = "10.0.0.0/25"
    gateway_id = "${aws_internet_gateway.inspec_internet_gateway.id}"
  }
}

resource "aws_route_table" "route_table_second" {
  count = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.inspec_vpc.id}"

  route {
    cidr_block = "10.0.0.0/25"
    gateway_id = "${aws_internet_gateway.inspec_internet_gateway.id}"
  }
}

# S3
resource "aws_s3_bucket" "bucket_public" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_public_name}"
  acl = "public-read"
}

resource "aws_s3_bucket" "bucket_private" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_private_name}"
  acl = "private"
}

resource "aws_s3_bucket" "bucket_public_for_objects" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_public_objects_name}"
  acl = "public-read"
}

resource "aws_s3_bucket" "bucket_auth" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_auth_name}"
  acl = "authenticated-read"
}

resource "aws_s3_bucket" "bucket_private_acl_public_policy" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_acl_policy_name}"
  acl = "private"
}

resource "aws_s3_bucket" "bucket_log_delivery" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_log_delivery_name}"
  force_destroy = true
  acl = "log-delivery-write"
}

resource "aws_s3_bucket" "bucket_access_logging_enabled" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_log_sender_name}"
  acl = "private"

  logging {
    target_bucket = "${aws_s3_bucket.bucket_log_delivery.id}"
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "bucket_access_logging_not_enabled" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_logging_disabled}"
  acl = "private"
}


resource "aws_s3_bucket" "bucket_default_encryption_enabled" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_encryption_enabled}"
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket_default_encryption_disabled" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_bucket_encryption_disabled}"
  acl = "private"
}


resource "aws_s3_bucket_policy" "allow_public" {
  count = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_public.id}"
  policy = <<POLICY
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
  count = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_private.id}"
  policy = <<POLICY
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
  count = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_private_acl_public_policy.id}"
  policy = <<POLICY
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
  count = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_public_for_objects.id}"
  key = "inspec-logo-public"
  source = "inspec-logo.png"
  acl = "public-read"
}

resource "aws_s3_bucket_object" "inspec_logo_private" {
  count = "${var.aws_enable_creation}"
  bucket = "${aws_s3_bucket.bucket_public_for_objects.id}"
  key = "inspec-logo-private"
  source = "inspec-logo.png"
  acl = "private"
}


# SNS resources
resource "aws_sns_topic" "sns_topic_subscription" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_sns_topic_with_subscription}"
}

resource "aws_sqs_queue" "sns_sqs_queue" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_sns_topic_subscription_sqs}"
}

resource "aws_sns_topic_subscription" "sqs_test_queue_subscription" {
  count = "${var.aws_enable_creation}"
  topic_arn = "${aws_sns_topic.sns_topic_subscription.arn}"
  protocol = "sqs"
  endpoint = "${aws_sqs_queue.sns_sqs_queue.arn}"
}

resource "aws_sns_topic" "sns_topic_no_subscription" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_sns_topic_no_subscription}"
}

# Security Groups and Rules
data "aws_security_group" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
  name = "default"
}

resource "aws_security_group" "alpha" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_security_group_alpha}"
  description = "SG alpha"
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_security_group" "beta" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_security_group_beta}"
  description = "SG beta"
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_security_group" "gamma" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_security_group_gamma}"
  description = "SG gamma"
  vpc_id = "${data.aws_vpc.default.id}"
}

// Note this gets created in a new VPC and with no rules defined
resource "aws_security_group" "omega" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_security_group_omega}"
  description = "SG omega"
  vpc_id = "${aws_vpc.inspec_vpc.id}"
}

resource "aws_security_group_rule" "alpha_http_world" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "80"
  to_port = "80"
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"]
  security_group_id = "${aws_security_group.alpha.id}"
}

resource "aws_security_group_rule" "alpha_ssh_in" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = [
    "10.1.2.0/24"]
  security_group_id = "${aws_security_group.alpha.id}"
}

resource "aws_security_group_rule" "alpha_x11" {
  count = "${var.aws_enable_creation}"
  description = "Only allow X11 out for some reason"
  type = "egress"
  from_port = "6000"
  to_port = "6007"
  protocol = "tcp"
  cidr_blocks = [
    "10.1.2.0/24",
    "10.3.2.0/24"]
  ipv6_cidr_blocks = [
    "2001:db8::/122"]
  security_group_id = "${aws_security_group.alpha.id}"
}

resource "aws_security_group_rule" "alpha_all_ports" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "0"
  to_port = "65535"
  protocol = "tcp"
  cidr_blocks = [
    "10.1.2.0/24"]
  security_group_id = "${aws_security_group.alpha.id}"
}

resource "aws_security_group_rule" "alpha_piv6_all_ports" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "0"
  to_port = "65535"
  protocol = "tcp"
  ipv6_cidr_blocks = [
    "2001:db8::/122"]
  security_group_id = "${aws_security_group.alpha.id}"
}

resource "aws_security_group_rule" "beta_http_world" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "80"
  to_port = "80"
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"]
  security_group_id = "${aws_security_group.beta.id}"
}

resource "aws_security_group_rule" "beta_ssh_in_alfa" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.alpha.id}"
  security_group_id = "${aws_security_group.beta.id}"
}

resource "aws_security_group_rule" "beta_all_ports_in_gamma" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "0"
  to_port = "65535"
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.gamma.id}"
  security_group_id = "${aws_security_group.beta.id}"
}

resource "aws_security_group_rule" "gamma_ssh_in_alfa" {
  count = "${var.aws_enable_creation}"
  type = "ingress"
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  source_security_group_id = "${aws_security_group.alpha.id}"
  security_group_id = "${aws_security_group.gamma.id}"
}

resource "aws_db_instance" "db_rds" {
  count = "${var.aws_enable_creation}"
  allocated_storage = 10
  storage_type = "${var.aws_rds_db_storage_type}"
  engine = "${var.aws_rds_db_engine}"
  engine_version = "${var.aws_rds_db_engine_version}"
  instance_class = "db.t2.micro"
  identifier = "${var.aws_rds_db_identifier}"
  name = "${var.aws_rds_db_name}"
  username = "${var.aws_rds_db_master_user}"
  password = "testpassword"
  parameter_group_name = "default.mysql5.6"
  skip_final_snapshot = true
}

# Cloudtrail

resource "aws_s3_bucket" "trail_1_bucket" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_cloud_trail_bucket_name}"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.aws_cloud_trail_bucket_name}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.aws_cloud_trail_bucket_name}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

resource "aws_iam_role" "cloud_watch_logs_role" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_watch_logs_role_name}"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy" "cloud_watch_logs_role_policy" {
  count = "${var.aws_enable_creation}"
  depends_on = [
    "aws_iam_role.cloud_watch_logs_role"]

  name = "${var.aws_cloud_watch_logs_role_policy_name}"
  role = "${var.aws_cloud_watch_logs_role_name}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailCreateLogStream",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream"
            ],
            "Resource": [
                "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.creds.account_id}:log-group:${aws_cloudwatch_log_group.trail_1_log_group.name}:log-stream:${data.aws_caller_identity.creds.account_id}_CloudTrail_${data.aws_region.current.name}*"
            ]
        },
        {
            "Sid": "AWSCloudTrailPutLogEvents",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.creds.account_id}:log-group:${aws_cloudwatch_log_group.trail_1_log_group.name}:log-stream:${data.aws_caller_identity.creds.account_id}_CloudTrail_${data.aws_region.current.name}*"
            ]
        }
    ]
}
POLICY
}

resource "aws_cloudwatch_log_group" "trail_1_log_group" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_trail_log_group}"
}

resource "aws_kms_key" "trail_1_key" {
  count = "${var.aws_enable_creation}"
  description = "${var.aws_cloud_trail_key_description}"
  deletion_window_in_days = 10

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "Key policy created by CloudTrail",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.creds.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow CloudTrail to encrypt logs",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "kms:GenerateDataKey*",
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.creds.account_id}:trail/*"
        }
      }
    },
    {
      "Sid": "Allow CloudTrail to describe key",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "kms:DescribeKey",
      "Resource": "*"
    },
    {
      "Sid": "Allow principals in the account to decrypt log files",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:Decrypt",
        "kms:ReEncryptFrom"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:CallerAccount": "${data.aws_caller_identity.creds.account_id}"
        },
        "StringLike": {
          "kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${data.aws_caller_identity.creds.account_id}:trail/*"
        }
      }
    },
    {
      "Sid": "Allow alias creation during setup",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "kms:CreateAlias",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "ec2.${data.aws_region.current.name}.amazonaws.com",
          "kms:CallerAccount": "${data.aws_caller_identity.creds.account_id}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_cloudtrail" "trail_1" {
  count = "${var.aws_enable_creation}"
  depends_on = [
    "aws_iam_role_policy.cloud_watch_logs_role_policy"]
  name = "${var.aws_cloud_trail_name}"
  s3_bucket_name = "${aws_s3_bucket.trail_1_bucket.id}"
  include_global_service_events = true
  enable_logging = true
  is_multi_region_trail = true
  enable_log_file_validation = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.trail_1_log_group.arn}"
  cloud_watch_logs_role_arn = "${aws_iam_role.cloud_watch_logs_role.arn}"
  kms_key_id = "${aws_kms_key.trail_1_key.arn}"
}

resource "aws_cloudtrail" "trail_2" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_trail_open_name}"
  s3_bucket_name = "${aws_s3_bucket.trail_1_bucket.id}"
}

# Cloudwatch

resource "aws_cloudwatch_log_metric_filter" "log_metric_filter" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_watch_log_metric_filter_name}"
  pattern = "${var.aws_cloud_watch_log_metric_filter_pattern}"
  log_group_name = "${aws_cloudwatch_log_group.log_metric_filter_log_group.name}"

  metric_transformation {
    name = "${var.aws_cloud_watch_log_metric_filter_metric_name}"
    namespace = "${var.aws_cloud_watch_log_metric_filter_namespace}"
    value = "1"
  }
}

resource "aws_cloudwatch_log_group" "log_metric_filter_log_group" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_watch_log_metric_filter_log_group_name}"
}

resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_pattern" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_watch_log_metric_filter_two_name}"
  pattern = "${var.aws_cloud_watch_log_metric_filter_two_pattern}"
  log_group_name = "${aws_cloudwatch_log_group.log_metric_filter_pattern_log_group.name}"

  metric_transformation {
    name = "${var.aws_cloud_watch_log_metric_filter_two_metric_name}"
    namespace = "${var.aws_cloud_watch_log_metric_filter_two_namespace}"
    value = "1"
  }
}

resource "aws_cloudwatch_log_group" "log_metric_filter_pattern_log_group" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_cloud_watch_log_metric_filter_two_log_group_name}"
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
  count = "${var.aws_enable_creation}"
  alarm_name = "${var.aws_cloud_watch_alarm_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "${var.aws_cloud_watch_alarm_metric_name}"
  namespace = "${var.aws_cloud_watch_log_metric_filter_namespace}"
  period = "120"
  statistic = "Average"
  threshold = "80"
  alarm_description = "This metric is a test metric"
  insufficient_data_actions = []
}

# AWS Config - note can only have one config recorder per region

resource "aws_config_configuration_recorder" "config_recorder" {
  count = "${var.aws_create_configuration_recorder}"
  name = "${var.aws_configuration_recorder_name}"
  role_arn = "${aws_iam_role.role_for_config_recorder.arn}"
}

resource "aws_iam_role" "role_for_config_recorder" {
  count = "${var.aws_create_configuration_recorder}"
  name = "${var.aws_configuration_recorder_role}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "bucket_for_delivery_channel" {
  count = "${var.aws_create_configuration_recorder}"
  bucket = "${var.aws_delivery_channel_bucket_name}"
  acl = "public-read"
  force_destroy = true
}

resource "aws_iam_role_policy" "policy_for_delivery_channel" {
  count = "${var.aws_create_configuration_recorder}"
  name = "policy_for_delivery_channel"
  role = "${aws_iam_role.role_for_config_recorder.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket_for_delivery_channel.arn}",
        "${aws_s3_bucket.bucket_for_delivery_channel.arn}/*"
      ]
    }
  ]
}
POLICY
}

resource "aws_sns_topic" "sns_topic_for_delivery_channel" {
  count = "${var.aws_create_configuration_recorder}"
  name = "${var.aws_delivery_channel_sns_topic_name}"
}

resource "aws_config_delivery_channel" "delivery_channel" {
  count = "${var.aws_create_configuration_recorder}"
  name = "${var.aws_delivery_channel_name}"
  s3_bucket_name = "${aws_s3_bucket.bucket_for_delivery_channel.bucket}"
  depends_on = [
    "aws_config_configuration_recorder.config_recorder"]
  sns_topic_arn = "${aws_sns_topic.sns_topic_for_delivery_channel.arn}"

  snapshot_delivery_properties = {
    delivery_frequency = "${var.aws_delivery_channel_frequency}"
  }
}

# AWS Flow Log

resource "aws_vpc" "inspec_vpc_flow_log" {
  count = "${var.aws_enable_creation}"
  cidr_block = "${var.aws_vpc_cidr_block}"
  instance_tenancy = "${var.aws_vpc_instance_tenancy}"
}

resource "aws_flow_log" "flow_log_vpc" {
  count = "${var.aws_enable_creation}"
  log_destination = "${aws_s3_bucket.flow_log_bucket.arn}"
  log_destination_type = "s3"
  traffic_type = "ALL"
  vpc_id = "${aws_vpc.inspec_vpc_flow_log.id}"
}

resource "aws_s3_bucket" "flow_log_bucket" {
  count = "${var.aws_enable_creation}"
  bucket = "${var.aws_flow_log_bucket_name}"
  force_destroy = true
}

resource "aws_ecs_cluster" "ecs_cluster" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_ecs_cluster_name}"
}

# Create a new load balancer
resource "aws_elb" "aws_elb_1" {
  count = "${var.aws_enable_creation}"
  name               = "${var.aws_elb_name}"
  availability_zones = ["${var.aws_availability_zone}"]


  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  instances                   = ["${aws_instance.linux_ubuntu_vm.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

resource "aws_iam_user" "iam_user" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_iam_user_name}"
}

resource "aws_iam_access_key" "iam_user_access_key" {
  count = "${var.aws_enable_creation}"
  user = "${aws_iam_user.iam_user.name}"
}

resource "aws_iam_user_policy" "iam_user_policy" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_iam_user_policy_name}"
  user = "${aws_iam_user.iam_user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group" "aws_iam_group_1" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_iam_group_name}"
}

resource "aws_iam_user_group_membership" "aws_iam_user_group_membership_1" {
  count = "${var.aws_enable_creation}"
  user = "${aws_iam_user.iam_user.name}"

  groups = [
    "${var.aws_iam_group_name}"
  ]
}

resource "aws_iam_policy" "aws_policy_1" {
  count = "${var.aws_enable_creation}"
  name        = "${var.aws_iam_policy_name}"
  path        = "/"
  description = "Test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


resource "aws_sqs_queue" "aws_sqs_queue_1" {
  count = "${var.aws_enable_creation}"
  name                      = "${var.aws_sqs_queue_name}"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_vpc" "eks_vpc" {
  count = "${var.aws_enable_creation}"
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "${var.aws_eks_vpc_name}"
  }
}

resource "aws_iam_role" "aws_eks_role" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_eks_role_name}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSClusterPolicy" {
  count = "${var.aws_enable_creation}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.aws_eks_role.name}"
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSServicePolicy" {
  count = "${var.aws_enable_creation}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.aws_eks_role.name}"
}


resource "aws_subnet" "eks_subnet" {
  count = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.eks_vpc.id}"
  availability_zone = "${var.aws_availability_zone}"
  cidr_block = "10.0.16.0/20"
  tags {
    Name = "${var.aws_eks_subnet_name_1}"
  }
}

resource "aws_subnet" "eks_subnet-2" {
  count = "${var.aws_enable_creation}"
  vpc_id = "${aws_vpc.eks_vpc.id}"
  availability_zone = "${var.aws_region}b"
  cidr_block = "10.0.32.0/20"
  tags {
    Name = "${var.aws_eks_subnet_name_1}"
  }
}

resource "aws_eks_cluster" "aws_eks_cluster" {
  count = "${var.aws_enable_creation}"
  name     = "${var.aws_eks_cluster_name}"
  role_arn = "${aws_iam_role.aws_eks_role.arn}"

  vpc_config {
    subnet_ids = ["${aws_subnet.eks_subnet-2.*.id}", "${aws_subnet.eks_subnet.*.id}"]
  }
}

resource "aws_iam_role" "aws_role_generic" {
  count = "${var.aws_enable_creation}"
  name = "${var.aws_iam_role_generic_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_ami" "aws_vm_config" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_launch_configuration" "as_conf" {
  count         = "${var.aws_enable_creation}"
  name          = "${var.aws_launch_configuration_name}"
  image_id      = "${data.aws_ami.aws_vm_config.id}"
  instance_type = "t2.micro"
  spot_price    = "0.1"
  user_data     = "#!/bin/bash"
}

resource "aws_autoscaling_group" "aws_auto_scaling_group" {
  count                = "${var.aws_enable_creation}"
  name                 = "${var.aws_auto_scaling_group}"
  min_size             = 1
  max_size             = 2
  desired_capacity     = 1
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier  = ["${aws_subnet.inspec_subnet.id}"]
}
