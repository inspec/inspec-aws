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
  availability_zone = "${var.aws_availability_zone}"
  size              = 1

  tags {
    Name = "${var.aws_ebs_volume_name}"
  }
}
