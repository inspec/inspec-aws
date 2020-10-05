# AWS Terraform Templates for InSpec Testing

terraform {
  required_version = ">= 0.12"
}

# Configure variables
variable "aws_region" {}
variable "aws_availability_zone" {}

variable "aws_alb_name" {}
variable "aws_auto_scaling_group" {}
variable "aws_bucket_acl_policy_name" {}
variable "aws_bucket_auth_name" {}
variable "aws_bucket_encryption_disabled" {}
variable "aws_bucket_encryption_enabled" {}
variable "aws_bucket_versioning_disabled" {}
variable "aws_bucket_versioning_enabled" {}
variable "aws_bucket_log_delivery_name" {}
variable "aws_bucket_log_sender_name" {}
variable "aws_bucket_logging_disabled" {}
variable "aws_bucket_private_name" {}
variable "aws_bucket_public_name" {}
variable "aws_bucket_public_objects_name" {}
variable "aws_cloudformation_stack_name" {}
variable "aws_cloudformation_stack_ecr_name" {}
variable "aws_cloud_trail_bucket_name" {}
variable "aws_cloud_trail_key_description" {}
variable "aws_cloud_trail_log_group" {}
variable "aws_cloud_trail_name" {}
variable "aws_cloud_trail_open_name" {}
variable "aws_cloud_watch_alarm_metric_name" {}
variable "aws_cloud_watch_alarm_name" {}
variable "aws_cloud_watch_alarm_name_with_dimensions" {}
variable "aws_cloud_watch_alarm_metric_name_with_dimensions" {}
variable "aws_cloud_watch_log_group_name" {}
variable "aws_cloud_watch_log_metric_filter_namespace_with_dimensions" {}
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
variable "aws_dynamodb_table_name" {}
variable "aws_delivery_channel_bucket_name" {}
variable "aws_delivery_channel_frequency" {}
variable "aws_delivery_channel_name" {}
variable "aws_delivery_channel_sns_topic_name" {}
variable "aws_ebs_volume_name" {}
variable "aws_ecr_name" {}
variable "aws_ecr_repository_name" {}
variable "aws_ecr_repository_image_tag_mutability" {}
variable "aws_ecr_repository_scan_on_push_enabled" {}
variable "aws_ecs_cluster_name" {}
variable "aws_efs_creation_token" {}
variable "aws_efs_encrypted" {}
variable "aws_efs_performance_mode" {}
variable "aws_efs_throughput_mode" {}
variable "aws_efs_name" {}
variable "aws_efs_company_name" {}
variable "aws_efs_count" {}
variable "aws_eks_cluster_name" {}
variable "aws_eks_role_name" {}
variable "aws_eks_subnet_name_1" {}
variable "aws_eks_subnet_name_2" {}
variable "aws_eks_vpc_name" {}
variable "aws_elasticache_cluster_id" {}
variable "aws_elasticache_cluster_engine" {}
variable "aws_elasticache_cluster_node_type" {}
variable "aws_elasticache_cluster_num_cache_nodes" {}
variable "aws_elasticache_cluster_parameter_group_name" {}
variable "aws_elasticache_cluster_engine_version" {}
variable "aws_elasticache_cluster_port" {}
variable "aws_elb_access_log_name" {}
variable "aws_elb_access_log_prefix" {}
variable "aws_elb_name" {}
variable "aws_enable_cli_calls" {}
variable "aws_enable_creation" {}
variable "aws_enable_privileged_resources" {}
variable "aws_flow_log_bucket_name" {}
variable "aws_iam_group_name" {}
variable "aws_iam_group_policy_name" {}
variable "aws_iam_policy_arn" {}
variable "aws_iam_role_generic_name" {}
variable "aws_iam_role_generic_policy_name" {}
variable "aws_iam_user_name" {}
variable "aws_iam_user_policy_name" {}
variable "aws_iam_profile_name_for_ec2" {}
variable "aws_iam_role_name_for_ec2" {}
variable "aws_iam_policy_name_for_lambda" {}
variable "aws_iam_role_name_for_lambda" {}
variable "aws_internet_gateway_name" {}
variable "aws_internet_gateway_name_tag" {}
variable "aws_internet_gateway_vpc_name" {}
variable "aws_iam_policy_name" {}
variable "aws_iam_attached_policy_name" {}
variable "aws_key_description_disabled" {}
variable "aws_key_description_enabled" {}
variable "aws_launch_configuration_name" {}
variable "aws_nat_gateway_name" {}
variable "aws_nat_gateway_eip_name" {}
variable "aws_nat_gateway_subnet_name" {}
variable "aws_rds_db_engine" {}
variable "aws_rds_db_engine_version" {}
variable "aws_rds_db_identifier" {}
variable "aws_rds_db_master_user" {}
variable "aws_rds_db_name" {}
variable "aws_rds_db_storage_type" {}
variable "aws_rds_db_subnet_group_name" {}
variable "aws_rds_db_subnet_group_description" {}
variable "rds_subnet_name_1" {}
variable "aws_rds_cluster_identifier" {}
variable "aws_rds_cluster_instance_1_identifier" {}
variable "aws_rds_cluster_instance_2_identifier" {}
variable "aws_rds_cluster_database_name" {}
variable "aws_rds_cluster_engine" {}
variable "aws_rds_cluster_master_user" {}
variable "aws_security_group_alpha" {}
variable "aws_security_group_beta" {}
variable "aws_security_group_gamma" {}
variable "aws_security_group_zeta" {}
variable "aws_security_group_omega" {}
variable "aws_security_group_lb" {}
variable "aws_ssm_parameter_name" {}
variable "aws_ssm_document_name" {}
variable "aws_sqs_queue_name" {}
variable "aws_subnet_ip_address_count" {}
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
variable "aws_vpc_dhcp_options_name" {}
variable "aws_vpc_endpoint_name" {}
variable "aws_route_53_zone" {}

provider "aws" {
  version = ">= 2.0.0"
  region  = var.aws_region
}

data "aws_caller_identity" "creds" {}

data "aws_region" "current" {}

# default VPC always exists for every AWS region
data "aws_vpc" "default" {
  default = "true"
}

resource "aws_vpc" "inspec_vpc" {
  count            = var.aws_enable_creation
  cidr_block       = var.aws_vpc_cidr_block
  instance_tenancy = var.aws_vpc_instance_tenancy

  tags = {
    Name = var.aws_vpc_name
  }
}

resource "aws_vpc_dhcp_options" "inspec_dopt" {
  count               = var.aws_enable_creation
  domain_name_servers = ["AmazonProvidedDNS"]
  ntp_servers         = ["127.0.0.1"]

  tags = {
    Name = var.aws_vpc_dhcp_options_name
  }
}

resource "aws_vpc_dhcp_options_association" "inspec_vpc_dopt_assoc" {
  count           = var.aws_enable_creation
  vpc_id          = aws_vpc.inspec_vpc[0].id
  dhcp_options_id = aws_vpc_dhcp_options.inspec_dopt[0].id
}

resource "aws_subnet" "inspec_subnet" {
  count             = var.aws_enable_creation
  vpc_id            = aws_vpc.inspec_vpc[0].id
  availability_zone = var.aws_availability_zone
  cidr_block        = cidrsubnet(aws_vpc.inspec_vpc[0].cidr_block, 1, 1)

  # will result in /28 (or 16) IP addresses

  tags = {
    Name = var.aws_subnet_name
  }
}


resource "aws_iam_role" "for_ec2" {
  count = var.aws_enable_creation
  name  = var.aws_iam_role_name_for_ec2

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

resource "aws_iam_instance_profile" "for_ec2" {
  count = var.aws_enable_creation
  name  = var.aws_iam_profile_name_for_ec2
  role  = aws_iam_role.for_ec2[0].name
}

data "aws_ami" "linux_ubuntu" {
  most_recent = true

  filter {
    name = "name"

    values = [
      var.aws_vm_image_filter,
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm",
    ]
  }

  owners = [
    "099720109477",
  ]
  # Canonical
}

resource "aws_instance" "linux_ubuntu_vm" {
  count                = var.aws_enable_creation
  ami                  = data.aws_ami.linux_ubuntu.id
  instance_type        = var.aws_vm_size
  iam_instance_profile = aws_iam_instance_profile.for_ec2[0].name

  tags = {
    Name = var.aws_vm_name
  }
}

resource "aws_ebs_volume" "inspec_ebs_volume" {
  count             = var.aws_enable_creation
  availability_zone = var.aws_availability_zone
  size              = 1

  tags = {
    Name = var.aws_ebs_volume_name
  }
}

resource "aws_efs_file_system" "inspec_efs_file_system" {
  count            = var.aws_enable_creation
  creation_token   = var.aws_efs_creation_token
  encrypted        = var.aws_efs_encrypted
  throughput_mode  = var.aws_efs_throughput_mode
  performance_mode = var.aws_efs_performance_mode

  tags = {
    Name        = var.aws_efs_name
    companyName = var.aws_efs_company_name
  }
}

resource "aws_efs_file_system" "inspec_efs_file_systems" {
  count            = var.aws_enable_creation * var.aws_efs_count
  encrypted        = var.aws_efs_encrypted
  throughput_mode  = var.aws_efs_throughput_mode
  performance_mode = var.aws_efs_performance_mode

  tags = {
    companyName = var.aws_efs_company_name
  }
}

# KMS Keys
resource "aws_kms_key" "kms_key_enabled_rotating" {
  count                   = var.aws_enable_creation
  description             = var.aws_key_description_enabled
  deletion_window_in_days = 10
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = true
  enable_key_rotation     = true
}

resource "aws_kms_key" "kms_key_disabled_non_rotating" {
  count                   = var.aws_enable_creation
  description             = var.aws_key_description_disabled
  deletion_window_in_days = 10
  key_usage               = "ENCRYPT_DECRYPT"
  is_enabled              = false
  enable_key_rotation     = false
}

# KMS Alias
resource "aws_kms_alias" "kms_key_disabled_non_rotating_alias" {
  count         = var.aws_enable_creation
  name          = "alias/${aws_kms_key.kms_key_disabled_non_rotating[0].key_id}"
  target_key_id = aws_kms_key.kms_key_disabled_non_rotating[0].key_id
}

# Route tables
resource "aws_internet_gateway" "inspec_internet_gateway" {
  count  = var.aws_enable_creation
  vpc_id = aws_vpc.inspec_vpc[0].id

  tags = {
    Name = var.aws_internet_gateway_name
  }
}

resource "aws_route_table" "route_table_first" {
  count  = var.aws_enable_creation
  vpc_id = aws_vpc.inspec_vpc[0].id

  route {
    cidr_block = "10.0.0.0/25"
    gateway_id = aws_internet_gateway.inspec_internet_gateway[0].id
  }
}

resource "aws_route_table" "route_table_second" {
  count  = var.aws_enable_creation
  vpc_id = aws_vpc.inspec_vpc[0].id

  route {
    cidr_block = "10.0.0.0/25"
    gateway_id = aws_internet_gateway.inspec_internet_gateway[0].id
  }
}

# S3
resource "aws_s3_bucket" "bucket_public" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_public_name
  acl    = "public-read"

  tags = {
    Name        = var.aws_bucket_public_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "bucket_private" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_private_name
  acl    = "private"

  lifecycle_rule {
    id      = "expiration"
    enabled = true

    prefix = ""

    expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket" "bucket_public_for_objects" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_public_objects_name
  acl    = "public-read"

  tags = {
    Name        = var.aws_bucket_public_objects_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "bucket_auth" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_auth_name
  acl    = "authenticated-read"
}

resource "aws_s3_bucket" "bucket_private_acl_public_policy" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_acl_policy_name
  acl    = "private"
}

resource "aws_s3_bucket" "bucket_log_delivery" {
  count         = var.aws_enable_creation
  bucket        = var.aws_bucket_log_delivery_name
  force_destroy = true
  acl           = "log-delivery-write"
}

resource "aws_s3_bucket" "bucket_access_logging_enabled" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_log_sender_name
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.bucket_log_delivery[0].id
    target_prefix = "log/"
  }
}

resource "aws_s3_bucket" "bucket_access_logging_not_enabled" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_logging_disabled
  acl    = "private"
}

resource "aws_s3_bucket" "bucket_default_encryption_enabled" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_encryption_enabled
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket_default_encryption_disabled" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_encryption_disabled
  acl    = "private"
}

resource "aws_s3_bucket" "bucket_versioning_enabled" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_versioning_enabled
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "bucket_versioning_disabled" {
  count  = var.aws_enable_creation
  bucket = var.aws_bucket_versioning_disabled
  acl    = "private"

  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_policy" "allow_public" {
  count  = var.aws_enable_creation
  bucket = aws_s3_bucket.bucket_public[0].id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_public[0].id}/*"
    },
    {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:*",
        "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_public[0].id}/*",
        "Condition": {
            "Bool": {
                "aws:SecureTransport": "false"
            }
        }
    }
  ]
}
POLICY

}

resource "aws_s3_bucket_policy" "deny_private" {
  count  = var.aws_enable_creation
  bucket = aws_s3_bucket.bucket_private[0].id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyGetObject",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_private[0].id}/*"
    }
  ]
}
POLICY

}

resource "aws_s3_bucket_policy" "allow-private-acl-public-policy" {
  count  = var.aws_enable_creation
  bucket = aws_s3_bucket.bucket_private_acl_public_policy[0].id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket_private_acl_public_policy[0].id}/*"
    }
  ]
}
POLICY

}

resource "aws_s3_bucket_object" "inspec_logo_public" {
  count  = var.aws_enable_creation
  bucket = aws_s3_bucket.bucket_public_for_objects[0].id
  key    = "inspec-logo-public"
  source = "inspec-logo.png"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "inspec_logo_private" {
  count  = var.aws_enable_creation
  bucket = aws_s3_bucket.bucket_public_for_objects[0].id
  key    = "inspec-logo-private"
  source = "inspec-logo.png"
  acl    = "private"
}

# SNS resources
resource "aws_sns_topic" "sns_topic_subscription" {
  count = var.aws_enable_creation
  name  = var.aws_sns_topic_with_subscription
}

resource "aws_sqs_queue" "sns_sqs_queue" {
  count = var.aws_enable_creation
  name  = var.aws_sns_topic_subscription_sqs
}

resource "aws_sns_topic_subscription" "sqs_test_queue_subscription" {
  count     = var.aws_enable_creation
  topic_arn = aws_sns_topic.sns_topic_subscription[0].arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sns_sqs_queue[0].arn
}

resource "aws_sns_topic" "sns_topic_no_subscription" {
  count = var.aws_enable_creation
  name  = var.aws_sns_topic_no_subscription
}

# Security Groups and Rules
data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

resource "aws_security_group" "alpha" {
  count       = var.aws_enable_creation
  name        = var.aws_security_group_alpha
  description = "SG alpha"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name        = var.aws_security_group_alpha
    Environment = "Dev"
  }
}

resource "aws_security_group" "beta" {
  count       = var.aws_enable_creation
  name        = var.aws_security_group_beta
  description = "SG beta"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group" "gamma" {
  count       = var.aws_enable_creation
  name        = var.aws_security_group_gamma
  description = "SG gamma"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group" "zeta" {
  count       = var.aws_enable_creation
  name        = var.aws_security_group_zeta
  description = "SG zeta"
  vpc_id      = data.aws_vpc.default.id
}

// Note this gets created in a new VPC and with no rules defined
resource "aws_security_group" "omega" {
  count       = var.aws_enable_creation
  name        = var.aws_security_group_omega
  description = "SG omega"
  vpc_id      = aws_vpc.inspec_vpc[0].id
}

resource "aws_security_group_rule" "alpha_http_world" {
  count     = var.aws_enable_creation
  type      = "ingress"
  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.alpha[0].id
}

resource "aws_security_group_rule" "alpha_ssh_in" {
  count     = var.aws_enable_creation
  type      = "ingress"
  from_port = "22"
  to_port   = "22"
  protocol  = "tcp"

  cidr_blocks = [
    "10.1.2.0/24",
  ]

  security_group_id = aws_security_group.alpha[0].id
}

resource "aws_security_group_rule" "alpha_x11" {
  count       = var.aws_enable_creation
  description = "Only allow X11 out for some reason"
  type        = "egress"
  from_port   = "6000"
  to_port     = "6007"
  protocol    = "tcp"

  cidr_blocks = [
    "10.1.2.0/24",
    "10.3.2.0/24",
  ]

  ipv6_cidr_blocks = [
    "2001:db8::/122",
  ]

  security_group_id = aws_security_group.alpha[0].id
}

resource "aws_security_group_rule" "alpha_all_ports" {
  count     = var.aws_enable_creation
  type      = "ingress"
  from_port = "0"
  to_port   = "65535"
  protocol  = "tcp"

  cidr_blocks = [
    "10.1.2.0/24",
  ]

  security_group_id = aws_security_group.alpha[0].id
}

resource "aws_security_group_rule" "alpha_piv6_all_ports" {
  count     = var.aws_enable_creation
  type      = "ingress"
  from_port = "0"
  to_port   = "65535"
  protocol  = "tcp"

  ipv6_cidr_blocks = [
    "2001:db8::/122",
  ]

  security_group_id = aws_security_group.alpha[0].id
}

resource "aws_security_group_rule" "beta_http_world" {
  count     = var.aws_enable_creation
  type      = "ingress"
  from_port = "80"
  to_port   = "80"
  protocol  = "tcp"

  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.beta[0].id
}

resource "aws_security_group_rule" "beta_ssh_in_alfa" {
  count                    = var.aws_enable_creation
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alpha[0].id
  security_group_id        = aws_security_group.beta[0].id
}

resource "aws_security_group_rule" "beta_all_ports_in_gamma" {
  count                    = var.aws_enable_creation
  type                     = "ingress"
  from_port                = "0"
  to_port                  = "65535"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.gamma[0].id
  security_group_id        = aws_security_group.beta[0].id
}

resource "aws_security_group_rule" "gamma_ssh_in_alfa" {
  count                    = var.aws_enable_creation
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alpha[0].id
  security_group_id        = aws_security_group.gamma[0].id
}

resource "aws_security_group_rule" "zeta_all_ports_in" {
  count     = var.aws_enable_creation
  type      = "ingress"
  from_port = "0"
  to_port   = "65535"
  protocol  = "all"
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.zeta[0].id
}

resource "aws_security_group_rule" "zeta_all_ports_out" {
  count     = var.aws_enable_creation
  type      = "egress"
  from_port = "0"
  to_port   = "65535"
  protocol  = "all"
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  security_group_id = aws_security_group.zeta[0].id
}

resource "aws_db_instance" "db_rds" {
  count                = var.aws_enable_creation
  allocated_storage    = 10
  storage_type         = var.aws_rds_db_storage_type
  engine               = var.aws_rds_db_engine
  engine_version       = var.aws_rds_db_engine_version
  instance_class       = "db.t3.small"
  identifier           = var.aws_rds_db_identifier
  name                 = var.aws_rds_db_name
  username             = var.aws_rds_db_master_user
  password             = "testpassword"
  parameter_group_name = "default.mysql5.6"
  skip_final_snapshot  = true
  storage_encrypted    = true

  tags = {
    Name        = var.aws_rds_db_name
    Environment = "Dev"
  }
}

# Cloudtrail
resource "aws_s3_bucket" "trail_1_bucket" {
  count         = var.aws_enable_creation
  bucket        = var.aws_cloud_trail_bucket_name
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
  count = var.aws_enable_creation
  name  = var.aws_cloud_watch_logs_role_name

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
  count = var.aws_enable_creation

  depends_on = [aws_iam_role.cloud_watch_logs_role]

  name = var.aws_cloud_watch_logs_role_policy_name
  role = var.aws_cloud_watch_logs_role_name

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
                "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.creds.account_id}:log-group:${aws_cloudwatch_log_group.trail_1_log_group[0].name}:log-stream:${data.aws_caller_identity.creds.account_id}_CloudTrail_${data.aws_region.current.name}*"
            ]
        },
        {
            "Sid": "AWSCloudTrailPutLogEvents",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.creds.account_id}:log-group:${aws_cloudwatch_log_group.trail_1_log_group[0].name}:log-stream:${data.aws_caller_identity.creds.account_id}_CloudTrail_${data.aws_region.current.name}*"
            ]
        }
    ]
}
POLICY

}

resource "aws_cloudwatch_log_group" "trail_1_log_group" {
  count = var.aws_enable_creation
  name  = var.aws_cloud_trail_log_group
}

resource "aws_kms_key" "trail_1_key" {
  count                   = var.aws_enable_creation
  description             = var.aws_cloud_trail_key_description
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
  count = var.aws_enable_creation

  depends_on = [aws_iam_role_policy.cloud_watch_logs_role_policy]

  name                          = var.aws_cloud_trail_name
  s3_bucket_name                = aws_s3_bucket.trail_1_bucket[0].id
  include_global_service_events = true
  enable_logging                = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${aws_cloudwatch_log_group.trail_1_log_group[0].arn}:*" # CloudTrail requires the Log Stream wildcard
  cloud_watch_logs_role_arn  = aws_iam_role.cloud_watch_logs_role[0].arn
  kms_key_id                 = aws_kms_key.trail_1_key[0].arn
}

resource "aws_cloudtrail" "trail_2" {
  count          = var.aws_enable_creation
  name           = var.aws_cloud_trail_open_name
  s3_bucket_name = aws_s3_bucket.trail_1_bucket[0].id
}

# Cloudwatch
resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.aws_enable_creation
  name              = var.aws_cloud_watch_log_group_name
  retention_in_days = 7

  tags = {
    Name = var.aws_cloud_watch_log_group_name
  }
}

resource "aws_cloudwatch_log_metric_filter" "log_metric_filter" {
  count          = var.aws_enable_creation
  name           = var.aws_cloud_watch_log_metric_filter_name
  pattern        = var.aws_cloud_watch_log_metric_filter_pattern
  log_group_name = aws_cloudwatch_log_group.log_metric_filter_log_group[0].name

  metric_transformation {
    name      = var.aws_cloud_watch_log_metric_filter_metric_name
    namespace = var.aws_cloud_watch_log_metric_filter_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_group" "log_metric_filter_log_group" {
  count = var.aws_enable_creation
  name  = var.aws_cloud_watch_log_metric_filter_log_group_name
}

resource "aws_cloudwatch_log_metric_filter" "log_metric_filter_pattern" {
  count          = var.aws_enable_creation
  name           = var.aws_cloud_watch_log_metric_filter_two_name
  pattern        = var.aws_cloud_watch_log_metric_filter_two_pattern
  log_group_name = aws_cloudwatch_log_group.log_metric_filter_pattern_log_group[0].name

  metric_transformation {
    name      = var.aws_cloud_watch_log_metric_filter_two_metric_name
    namespace = var.aws_cloud_watch_log_metric_filter_two_namespace
    value     = "1"
  }
}

resource "aws_cloudwatch_log_group" "log_metric_filter_pattern_log_group" {
  count = var.aws_enable_creation
  name  = var.aws_cloud_watch_log_metric_filter_two_log_group_name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
  count                     = var.aws_enable_creation
  alarm_name                = var.aws_cloud_watch_alarm_name
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = var.aws_cloud_watch_alarm_metric_name
  namespace                 = var.aws_cloud_watch_log_metric_filter_namespace
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric is a test metric"
  insufficient_data_actions = []
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm_with_dimensions" {
  count               = var.aws_enable_creation
  alarm_name          = var.aws_cloud_watch_alarm_name_with_dimensions
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = var.aws_cloud_watch_alarm_metric_name_with_dimensions
  namespace           = var.aws_cloud_watch_log_metric_filter_namespace_with_dimensions
  period              = "120"
  statistic           = "Average"
  dimensions = {
    aws_dimension_name1 = "aws_dimension_value1"
    aws_dimension_name2 = "aws_dimension_value2"
  }
  threshold                 = "80"
  alarm_description         = "This metric is a test metric"
  insufficient_data_actions = []
}

# AWS Config - note can only have one config recorder per region
resource "aws_config_configuration_recorder" "config_recorder" {
  count    = var.aws_create_configuration_recorder
  name     = var.aws_configuration_recorder_name
  role_arn = aws_iam_role.role_for_config_recorder[0].arn
}

resource "aws_iam_role" "role_for_config_recorder" {
  count = var.aws_create_configuration_recorder
  name  = var.aws_configuration_recorder_role

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
  count         = var.aws_create_configuration_recorder
  bucket        = var.aws_delivery_channel_bucket_name
  acl           = "public-read"
  force_destroy = true
}

resource "aws_iam_role_policy" "policy_for_delivery_channel" {
  count = var.aws_create_configuration_recorder
  name  = "policy_for_delivery_channel"
  role  = aws_iam_role.role_for_config_recorder[0].id

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
        "${aws_s3_bucket.bucket_for_delivery_channel[0].arn}",
        "${aws_s3_bucket.bucket_for_delivery_channel[0].arn}/*"
      ]
    }
  ]
}
POLICY

}

resource "aws_sns_topic" "sns_topic_for_delivery_channel" {
  count = var.aws_create_configuration_recorder
  name  = var.aws_delivery_channel_sns_topic_name
}

resource "aws_config_delivery_channel" "delivery_channel" {
  count          = var.aws_create_configuration_recorder
  name           = var.aws_delivery_channel_name
  s3_bucket_name = aws_s3_bucket.bucket_for_delivery_channel[0].bucket

  depends_on = [aws_config_configuration_recorder.config_recorder]

  sns_topic_arn = aws_sns_topic.sns_topic_for_delivery_channel[0].arn

  snapshot_delivery_properties {
    delivery_frequency = var.aws_delivery_channel_frequency
  }
}

# AWS Flow Log
resource "aws_vpc" "inspec_vpc_flow_log" {
  count            = var.aws_enable_creation
  cidr_block       = var.aws_vpc_cidr_block
  instance_tenancy = var.aws_vpc_instance_tenancy
}

resource "aws_flow_log" "flow_log_vpc" {
  count                = var.aws_enable_creation
  log_destination      = aws_s3_bucket.flow_log_bucket[0].arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.inspec_vpc_flow_log[0].id
}

resource "aws_s3_bucket" "flow_log_bucket" {
  count         = var.aws_enable_creation
  bucket        = var.aws_flow_log_bucket_name
  force_destroy = true
}

resource "aws_ecs_cluster" "ecs_cluster" {
  count = var.aws_enable_creation
  name  = var.aws_ecs_cluster_name
}

resource "aws_elb" "aws_elb_1" {
  count              = var.aws_enable_creation
  name               = var.aws_elb_name
  availability_zones = [var.aws_availability_zone]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  instances                   = [aws_instance.linux_ubuntu_vm[0].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

resource "aws_iam_user" "iam_user" {
  count = var.aws_enable_creation
  name  = var.aws_iam_user_name
}

resource "aws_iam_access_key" "iam_user_access_key" {
  count = var.aws_enable_creation
  user  = aws_iam_user.iam_user[0].name
}

resource "aws_iam_user_policy" "iam_user_policy" {
  count = var.aws_enable_creation
  name  = var.aws_iam_user_policy_name
  user  = aws_iam_user.iam_user[0].name

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
  count = var.aws_enable_creation
  name  = var.aws_iam_group_name
}

resource "aws_iam_user_group_membership" "aws_iam_user_group_membership_1" {
  count = var.aws_enable_creation
  user  = aws_iam_user.iam_user[0].name

  groups = [
    var.aws_iam_group_name,
  ]
}

resource "aws_iam_group_policy" "iam_group_policy" {
  count = var.aws_enable_creation
  name  = var.aws_iam_group_policy_name
  group = aws_iam_group.aws_iam_group_1[0].name

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

resource "aws_iam_policy" "aws_policy_1" {
  count       = var.aws_enable_creation
  name        = var.aws_iam_policy_name
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
    },
    {
      "NotAction": "s3:DeleteBucket",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
EOF

}

resource "aws_iam_policy" "aws_attached_policy_1" {
  count       = var.aws_enable_creation
  name        = var.aws_iam_attached_policy_name
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
    },
    {
      "NotAction": "s3:DeleteBucket",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_generic_policy_to_role_1" {
  count      = var.aws_enable_creation
  role       = aws_iam_role.aws_role_generic[0].name
  policy_arn = aws_iam_policy.aws_attached_policy_1[0].arn
}

resource "aws_iam_user_policy_attachment" "attach_generic_policy_to_user_1" {
  count      = var.aws_enable_creation
  user       = aws_iam_user.iam_user[0].name
  policy_arn = aws_iam_policy.aws_attached_policy_1[0].arn
}

resource "aws_sqs_queue" "aws_sqs_queue_1" {
  count                     = var.aws_enable_creation
  name                      = var.aws_sqs_queue_name
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  kms_master_key_id         = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
}

resource "aws_vpc" "eks_vpc" {
  count            = var.aws_enable_creation
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = var.aws_eks_vpc_name
  }
}

resource "aws_iam_role" "aws_eks_role" {
  count = var.aws_enable_creation
  name  = var.aws_eks_role_name

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
  count      = var.aws_enable_creation
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.aws_eks_role[0].name
}

resource "aws_iam_role_policy_attachment" "demo-cluster-AmazonEKSServicePolicy" {
  count      = var.aws_enable_creation
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.aws_eks_role[0].name
}

resource "aws_internet_gateway" "igw" {
  count  = var.aws_enable_creation
  vpc_id = aws_vpc.eks_vpc[0].id
  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "eks_subnet" {
  count             = var.aws_enable_creation
  vpc_id            = aws_vpc.eks_vpc[0].id
  availability_zone = var.aws_availability_zone
  cidr_block        = "10.0.16.0/20"

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = var.aws_eks_subnet_name_1
  }
}

resource "aws_subnet" "eks_subnet-2" {
  count             = var.aws_enable_creation
  vpc_id            = aws_vpc.eks_vpc[0].id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "10.0.32.0/20"

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = var.aws_eks_subnet_name_1
  }
}

resource "aws_eks_cluster" "aws_eks_cluster" {
  count    = var.aws_enable_creation
  name     = var.aws_eks_cluster_name
  role_arn = aws_iam_role.aws_eks_role[0].arn

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet-2[0].id, aws_subnet.eks_subnet[0].id]
  }
}

resource "aws_subnet" "rds_subnet_1" {
  count             = var.aws_enable_creation
  vpc_id            = aws_vpc.eks_vpc[0].id
  availability_zone = "${var.aws_region}b"
  cidr_block        = "10.0.48.0/20"

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = var.rds_subnet_name_1
  }
}

resource "aws_db_subnet_group" "rds_subnet_group_1" {
  count       = var.aws_enable_creation
  name        = var.aws_rds_db_subnet_group_name
  description = var.aws_rds_db_subnet_group_description

  subnet_ids = [aws_subnet.rds_subnet_1[0].id, aws_subnet.eks_subnet[0].id]

  depends_on = [aws_subnet.rds_subnet_1, aws_subnet.eks_subnet]

  tags = {
    Name = var.aws_rds_db_subnet_group_name
  }
}

resource "aws_iam_role" "aws_role_generic" {
  count = var.aws_enable_creation
  name  = var.aws_iam_role_generic_name

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

resource "aws_iam_role_policy" "generic_policy" {
  count = var.aws_enable_creation
  name  = var.aws_iam_role_generic_policy_name
  role  = aws_iam_role.aws_role_generic[0].id

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
  count         = var.aws_enable_creation
  name          = var.aws_launch_configuration_name
  image_id      = data.aws_ami.aws_vm_config.id
  instance_type = "t3.micro"
  spot_price    = "0.1"
  user_data     = "#!/bin/bash"
}

resource "aws_autoscaling_group" "aws_auto_scaling_group" {
  count                = var.aws_enable_creation
  name                 = var.aws_auto_scaling_group
  min_size             = 0
  max_size             = 2
  desired_capacity     = 0
  launch_configuration = aws_launch_configuration.as_conf[0].name
  vpc_zone_identifier  = [aws_subnet.inspec_subnet[0].id]
}

resource "aws_ecr_repository" "aws_ecr" {
  count = var.aws_enable_creation
  name  = var.aws_ecr_name
}

resource "aws_dynamodb_table" "aws-dynamodb-table" {
  count          = var.aws_enable_creation
  name           = var.aws_dynamodb_table_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "Title"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Title"
    type = "S"
  }

  attribute {
    name = "Score"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "TitleIndex"
    hash_key           = "Title"
    range_key          = "Score"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }
}

# Aws_lb
resource "aws_security_group" "lb_sg" {
  count       = var.aws_enable_creation
  name        = var.aws_security_group_lb
  description = "SG lb"
  vpc_id      = aws_vpc.eks_vpc[0].id

  tags = {
    Name        = var.aws_security_group_lb
    Environment = "Dev"
  }
}

resource "aws_lb" "aws-alb" {
  count              = var.aws_enable_creation
  name               = var.aws_alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg[0].id]
  subnets            = [aws_subnet.eks_subnet[0].id, aws_subnet.eks_subnet-2[0].id]

  tags = {
    Environment = "inspec-aws"
  }
}

resource "aws_cloudformation_stack" "ecr" {
  count = var.aws_enable_creation
  name  = var.aws_cloudformation_stack_name

  template_body = <<STACK
{
  "Parameters" : {
    "ECRrepo" : {
      "Type" : "String",
      "Default" : "${var.aws_cloudformation_stack_ecr_name}",
      "Description" : "ECR repo created by cloud formation."
    }
  },
  "Resources" : {
    "myEcrRepo": {
      "Type" : "AWS::ECR::Repository",
      "Properties" : {
        "RepositoryName" : { "Ref" : "ECRrepo" }
      }
    }
  }
}
STACK

}


resource "aws_route53_zone" "test_zone" {
  count = var.aws_enable_creation
  name  = var.aws_route_53_zone

  vpc {
    vpc_id = aws_vpc.inspec_vpc.0.id
  }
}

resource "aws_route53_record" "test_record" {
  count   = var.aws_enable_creation
  zone_id = aws_route53_zone.test_zone.0.id
  name    = "www.carry-on-films.com"
  type    = "A"
  ttl     = "300"
  records = ["127.0.0.1"]
}

resource "aws_rds_cluster" "rds_cluster" {
  count               = var.aws_enable_creation
  cluster_identifier  = var.aws_rds_cluster_identifier
  engine              = var.aws_rds_cluster_engine
  database_name       = var.aws_rds_cluster_database_name
  master_username     = var.aws_rds_cluster_master_user
  master_password     = "testpassword"
  storage_encrypted   = true
  skip_final_snapshot = true

  tags = {
    Name        = var.aws_rds_cluster_database_name
    Environment = "Dev"
  }
}

resource "aws_rds_cluster_instance" "instance1" {
  count              = var.aws_enable_creation
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.rds_cluster.0.cluster_identifier
  identifier         = var.aws_rds_cluster_instance_1_identifier
  instance_class     = "db.t3.small"
}

resource "aws_rds_cluster_instance" "instance2" {
  count              = var.aws_enable_creation
  apply_immediately  = true
  cluster_identifier = aws_rds_cluster.rds_cluster.0.cluster_identifier
  identifier         = var.aws_rds_cluster_instance_2_identifier
  instance_class     = "db.t3.small"
}

resource "aws_ec2_transit_gateway" "gateway" {
  count       = var.aws_enable_creation
  description = "transitgateway1"
}

data "aws_iam_policy_document" "lambda_test_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda_test_policy" {
  count       = var.aws_enable_creation
  name        = var.aws_iam_policy_name_for_lambda
  path        = "/"
  description = "Policy that allows access to cloudwatch metrics"
  policy      = data.aws_iam_policy_document.lambda_test_policy_document.json
}

resource "aws_iam_role" "lambda_test_role" {
  count              = var.aws_enable_creation
  name               = var.aws_iam_role_name_for_lambda
  description        = "Used by the test lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

data "aws_iam_policy" "lambda_execute" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_test_policy_attach" {
  count      = var.aws_enable_creation
  role       = aws_iam_role.lambda_test_role[0].name
  policy_arn = aws_iam_policy.lambda_test_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "lambda_test_execute_attached" {
  count      = var.aws_enable_creation
  role       = aws_iam_role.lambda_test_role[0].name
  policy_arn = data.aws_iam_policy.lambda_execute.arn
}

resource "aws_cloudwatch_log_group" "lambda_test_logs" {
  count             = var.aws_enable_creation
  name              = "/aws/lambda/test_lambda"
  retention_in_days = 14
}

locals {
  test_lambda_zip_file_name = "${path.module}/files/lambda.zip"
}
resource "aws_lambda_function" "lambda_test" {
  count            = var.aws_enable_creation
  filename         = local.test_lambda_zip_file_name
  description      = "Test Lambda"
  function_name    = "test_Lambda"
  role             = aws_iam_role.lambda_test_role[0].arn
  handler          = "main.on_event"
  source_code_hash = filebase64sha256(local.test_lambda_zip_file_name)
  runtime          = "python3.7"
  publish          = true
  timeout          = 10
}

resource "aws_elasticache_cluster" "inspec_test_elasticache" {
  count                = var.aws_enable_creation
  cluster_id           = var.aws_elasticache_cluster_id
  engine               = var.aws_elasticache_cluster_engine
  node_type            = var.aws_elasticache_cluster_node_type
  num_cache_nodes      = var.aws_elasticache_cluster_num_cache_nodes
  parameter_group_name = var.aws_elasticache_cluster_parameter_group_name
  engine_version       = var.aws_elasticache_cluster_engine_version
  port                 = var.aws_elasticache_cluster_port
}

resource "aws_ecr_repository" "inspec_test_ecr_repository" {
  count                = var.aws_enable_creation
  name                 = var.aws_ecr_repository_name
  image_tag_mutability = var.aws_ecr_repository_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.aws_ecr_repository_scan_on_push_enabled
  }
  tags = {
    Name = var.aws_ecr_repository_name
  }
}

resource "aws_vpc" "for_igw" {
  count      = var.aws_enable_creation
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.aws_internet_gateway_vpc_name
  }
}

resource "aws_internet_gateway" "inspec_test" {
  count  = var.aws_enable_creation
  vpc_id = aws_vpc.for_igw[0].id

  tags = {
    Name = var.aws_internet_gateway_name_tag
  }
}

resource "aws_subnet" "for_nat_gateway" {
  count      = var.aws_enable_creation
  vpc_id     = aws_vpc.for_igw[0].id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = var.aws_nat_gateway_subnet_name
  }
}

resource "aws_eip" "for_nat_gateway" {
  count            = var.aws_enable_creation
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = {
    Name = var.aws_nat_gateway_eip_name
  }
}

resource "aws_nat_gateway" "inspec_test" {
  count         = var.aws_enable_creation
  allocation_id = aws_eip.for_nat_gateway[0].id
  subnet_id     = aws_subnet.for_nat_gateway[0].id
  depends_on    = ["aws_internet_gateway.inspec_test[0]"]

  tags = {
    Name = var.aws_nat_gateway_name
  }
}

resource "aws_ssm_parameter" "ssm_param_secret" {
  count       = var.aws_enable_creation
  name        = var.aws_ssm_parameter_name
  description = "The parameter description"
  type        = "SecureString"
  value       = "testpassword"

  tags = {
    Environment = "Dev"
  }
}

resource "aws_ssm_document" "ssm_document_1" {
  count         = var.aws_enable_creation
  name          = var.aws_ssm_document_name
  document_type = "Command"

  content = <<DOC
  {
    "schemaVersion": "1.2",
    "description": "Check ip configuration of a Linux instance.",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["ifconfig"]
          }
        ]
      }
    }
  }
DOC
}

resource "aws_vpc_endpoint" "vpc_endpoint_1" {
  count           = var.aws_enable_creation
  vpc_id          = aws_vpc.inspec_vpc[0].id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [aws_route_table.route_table_first[0].id]
  tags = {
    Name = var.aws_vpc_endpoint_name
  }
}

resource "aws_guardduty_detector" "detector_1" {
  count  = var.aws_enable_creation
  enable = true
  finding_publishing_frequency = "SIX_HOURS"
}
