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

provider "aws" {
  version = "= 1.48.0"
  region     = "${var.aws_region}"
}

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