output "aws_account_id" {
  value = data.aws_caller_identity.creds.account_id
}

output "aws_vpc_id" {
  value = aws_vpc.inspec_vpc.0.id
}

output "aws_default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "aws_instance_id" {
  value = aws_instance.linux_ubuntu_vm.0.id
}

output "aws_ec2_ami_id" {
  value = data.aws_ami.linux_ubuntu.id
}

output "aws_vpc_dhcp_options_id" {
  value = aws_vpc_dhcp_options.inspec_dopt.0.id
}

output "aws_subnet_id" {
  value = aws_subnet.inspec_subnet.0.id
}

output "aws_subnet_cidr_block" {
  value = aws_subnet.inspec_subnet.0.cidr_block
}

output "aws_ebs_volume_arn" {
  value = aws_ebs_volume.inspec_ebs_volume.0.arn
}

output "aws_ebs_volume_id" {
  value = aws_ebs_volume.inspec_ebs_volume.0.id
}

output "aws_kms_key_enabled_id" {
  value = aws_kms_key.kms_key_enabled_rotating.0.key_id
}

output "aws_kms_key_disabled_id" {
  value = aws_kms_key.kms_key_disabled_non_rotating.0.key_id
}

output "aws_kms_key_enabled_arn" {
  value = aws_kms_key.kms_key_enabled_rotating.0.arn
}

output "aws_kms_key_disabled_arn" {
  value = aws_kms_key.kms_key_disabled_non_rotating.0.arn
}

output "aws_route_table_first_id" {
  value = aws_route_table.route_table_first.0.id
}

output "aws_route_table_second_id" {
  value = aws_route_table.route_table_second.0.id
}

output "aws_s3_bucket_public_region" {
  value = aws_s3_bucket.bucket_public.0.region
}

output "aws_s3_bucket_object_public" {
  value = aws_s3_bucket_object.inspec_logo_public.0.id
}

output "aws_s3_bucket_object_private" {
  value = aws_s3_bucket_object.inspec_logo_private.0.id
}

output "aws_sns_subscription_arn" {
  value = aws_sns_topic_subscription.sqs_test_queue_subscription.0.arn
}

output "aws_sns_topic_with_subscription_arn" {
  value = aws_sns_topic.sns_topic_subscription.0.arn
}

output "aws_sns_topic_no_subscription_arn" {
  value = aws_sns_topic.sns_topic_no_subscription.0.arn
}

output "sns_sqs_queue_arn" {
  value = aws_sqs_queue.sns_sqs_queue.0.arn
}

output "aws_security_group_default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "aws_security_group_default_id" {
  value = data.aws_security_group.default.id
}

output "aws_security_group_alpha_id" {
  value = aws_security_group.alpha.0.id
}

output "aws_security_group_beta_id" {
  value = aws_security_group.beta.0.id
}

output "aws_security_group_gamma_id" {
  value = aws_security_group.gamma.0.id
}

output "aws_security_group_zeta_id" {
  value = aws_security_group.zeta.0.id
}

output "aws_security_group_omega_id" {
  value = aws_security_group.omega.0.id
}

output "aws_rds_instance_id" {
  value = aws_db_instance.db_rds.0.id
}

output "aws_cloud_trail_arn" {
  value = aws_cloudtrail.trail_1.0.arn
}

output "aws_cloud_trail_bucket_id" {
  value = aws_s3_bucket.trail_1_bucket.0.id
}

output "aws_cloud_trail_key_arn" {
  value = aws_kms_key.trail_1_key.0.arn
}

output "aws_cloud_watch_log_group_name" {
  value = aws_cloudwatch_log_group.log_group.0.name
}

output "aws_cloud_trail_cloud_watch_logs_group_arn" {
  value = aws_cloudtrail.trail_1.0.cloud_watch_logs_group_arn
}

output "aws_cloud_trail_cloud_watch_logs_role_arn" {
  value = aws_iam_role.cloud_watch_logs_role.0.arn
}

output "aws_cloud_trail_open_s3_bucket_id" {
  value = aws_s3_bucket.trail_1_bucket.0.id
}

output "aws_cloud_trail_open_arn" {
  value = aws_cloudtrail.trail_2.0.arn
}

output "aws_config_recorder_role_arn" {
  value = aws_iam_role.role_for_config_recorder.*.arn
}

output "aws_delivery_channel_sns_topic_arn" {
  value = aws_sns_topic.sns_topic_for_delivery_channel.*.arn
}

output "aws_vpc_flow_log_id" {
  value = aws_vpc.inspec_vpc_flow_log.0.id
}

output "aws_flow_log_id" {
  value = aws_flow_log.flow_log_vpc.0.id
}

output "aws_iam_policy_arn" {
  value = aws_iam_policy.aws_policy_1.0.arn
}

output "aws_iam_attached_policy_arn" {
  value = aws_iam_policy.aws_attached_policy_1.0.arn
}

output "aws_sqs_queue_arn" {
  value = aws_sqs_queue.aws_sqs_queue_1.0.arn
}

output "aws_sqs_queue_kms_master_key_id" {
  value = aws_sqs_queue.aws_sqs_queue_1.0.kms_master_key_id
}

output "aws_iam_access_key_id" {
  value = aws_iam_access_key.iam_user_access_key.0.id
}

output "aws_dynamodb_table_arn" {
  value = aws_dynamodb_table.aws-dynamodb-table.0.arn
}

output "aws_dynamodb_table_name" {
  value = aws_dynamodb_table.aws-dynamodb-table.0.name
}

output "aws_alb_arn" {
  value = aws_lb.aws-alb.0.arn
}

output "aws_rds_cluster_engine_version" {
  value = aws_rds_cluster.rds_cluster.0.engine_version
}

output "aws_transit_gateway_id" {
  value = aws_ec2_transit_gateway.gateway.0.id
}

output "aws_rds_db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group_1.0.name
}

output "aws_rds_db_subnet_group_arn" {
  value = aws_db_subnet_group.rds_subnet_group_1.0.arn
}

output "aws_rds_db_subnet_group_vpc_id" {
  value = aws_subnet.eks_subnet.0.vpc_id
}

output "aws_nat_gateway_id" {
  value = aws_nat_gateway.inspec_test.0.id
}

output "aws_nat_gateway_subnet_id" {
  value = aws_nat_gateway.inspec_test.0.subnet_id
}

output "aws_nat_gateway_allocation_id" {
  value = aws_nat_gateway.inspec_test.0.allocation_id
}

output "aws_nat_gateway_vpc_id" {
  value = aws_subnet.for_nat_gateway.0.vpc_id
}

output "aws_nat_gateway_private_ip" {
  value = aws_nat_gateway.inspec_test.0.private_ip
}

output "aws_nat_gateway_public_ip" {
  value = aws_nat_gateway.inspec_test.0.public_ip
}

output "aws_ssm_parameter_name" {
  value = aws_ssm_parameter.ssm_param_secret.0.name
}

output "aws_ssm_parameter_type" {
  value = aws_ssm_parameter.ssm_param_secret.0.type
}

output "aws_ssm_parameter_value" {
  value = aws_ssm_parameter.ssm_param_secret.0.value
}

output "aws_ssm_parameter_arn" {
  value = aws_ssm_parameter.ssm_param_secret.0.arn
}

output "aws_ssm_document_name" {
  value = aws_ssm_document.ssm_document_1.0.name
}

output "aws_ssm_document_document_type" {
  value = aws_ssm_document.ssm_document_1.0.document_type
}

output "aws_vpce_id" {
  value = aws_vpc_endpoint.vpc_endpoint_1.0.id
}

output "aws_vpce_service_name" {
  value = "com.amazonaws.${var.aws_region}.s3"
}

output "aws_guardduty_detector_id" {
  value = aws_guardduty_detector.detector_1.0.id
}

output "aws_guardduty_detector_publishing_frequency" {
  value = aws_guardduty_detector.detector_1.0.finding_publishing_frequency
}