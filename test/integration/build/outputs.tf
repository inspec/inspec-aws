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

output "aws_ebs_snapshot_id" {
  value = aws_ebs_snapshot.inspec_ebs_snapshot.0.id
}

output "aws_ebs_snapshot_owner_id" {
  value = aws_ebs_snapshot.inspec_ebs_snapshot.0.owner_id
}

output "aws_ebs_encrypted_snapshot_id" {
  value = aws_ebs_snapshot.inspec_encrypted_ebs_snapshot.0.id
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

output "aws_sns_topic_with_encryption_arn" {
  value = aws_sns_topic.sns_topic_encryption.0.arn
}

output "aws_sns_topic_kms_master_key_id" {
  value = aws_sns_topic.sns_topic_encryption.0.kms_master_key_id
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

output "aws_public_ip" {
  value = aws_eip.aws_eip_1.public_ip
}

output "aws_instance_id1" {
  value = aws_eip.aws_eip_1.instance
}

output "aws_allocation_id" {
  value = aws_eip.aws_eip_1.allocation_id
}

output "aws_association_id" {
  value = aws_eip.aws_eip_1.association_id
}

output "aws_domain" {
  value = aws_eip.aws_eip_1.domain
}

output "aws_network_interface_id" {
  value = aws_eip.aws_eip_1.network_interface
}

output "aws_network_interface_owner_id" {
  value = aws_eip.aws_eip_1.customer_owned_ip
}

output "aws_private_ip_address" {
  value = aws_eip.aws_eip_1.private_ip
}

output "aws_elasticache_replication_group_id" {
  value = aws_elasticache_replication_group.replication_group.id
}

output "aws_elasticache_replication_group_node_type" {
  value = aws_elasticache_replication_group.replication_group.node_type
}

output "aws_service_id" {
  value = aws_ecs_service.bar.id
}

output "aws_cluster_arn" {
  value = aws_ecs_cluster.for_ecs_service.arn
}

output "aws_task_definition_arn" {
  value = aws_ecs_task_definition.aws_ecs_task_definition_test.arn
}

output "aws_transfer_server_arn" {
  value = aws_transfer_server.aws_transfer_server_tu_test.arn
}

output "aws_transfer_server_id" {
  value = aws_transfer_server.aws_transfer_server_tu_test.id
}

output "aws_transfer_user_arn" {
  value = aws_transfer_user.aws_transfer_user_tu_test.arn
}

output "aws_target_group_arn" {
  value = aws_lb_target_group.for_elb.arn
}

output "aws_elbv2_rule_arn" {
  value = aws_lb_listener_rule.static.arn
}

output "aws_cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.aws_cloudwatch_event_rule_test.arn
}

output "aws_elasticsearch_domain_id" {
  value = aws_elasticsearch_domain.aws_elasticsearch_domain_test.domain_id
}

output "aws_elasticsearch_domain_arn" {
  value = aws_elasticsearch_domain.aws_elasticsearch_domain_test.arn
}

output "aws_dms_endpoint_arn" {
  value = aws_dms_endpoint.aws_dms_endpoint_test.endpoint_arn
}

output "aws_mount_target_mt_id" {
  value = aws_efs_mount_target.aws_efs_mount_target_mt_test.id
}

output "aws_file_system_mt_id" {
  value = aws_efs_file_system.aws_efs_file_system_mt_test.id
}

output "aws_subnet_mt_id" {
  value = aws_subnet.aws_subnet_mount_mt_test.id
}

output "aws_vpc_mt_id" {
  value = aws_vpc.aws_vpc_mount_mt_test.id
}

output "batch_job_queue_arn" {
  value = aws_batch_job_queue.test_queue.arn
}

output "batch_job_queue_compute_environments" {
  value = aws_batch_job_queue.test_queue.compute_environments
}

output "aws_ecs_task_definition_arn" {
  value = aws_ecs_task_definition.aws_ecs_task_definition_test.arn
}

output "aws_ecs_task_definition_revision" {
  value = aws_ecs_task_definition.aws_ecs_task_definition_test.revision
}

output "aws_client_id" {
  value = aws_cognito_user_pool_client.aws_cognito_user_pool_client_test.id
}

output "aws_client_secret" {
  value = aws_cognito_user_pool_client.aws_cognito_user_pool_client_test.client_secret
}

output "aws_batch_job_arn" {
  value = aws_batch_job_definition.aws_batch_job_definition1.arn
}

output "aws_batch_job_revision" {
  value = aws_batch_job_definition.aws_batch_job_definition1.revision
}

output "aws_user_pool_id" {
  value = aws_cognito_user_pool.aws_cognito_user_pool_test.id
}

output "aws_identity_pool_id" {
  value = aws_cognito_identity_pool.aws_cognito_identity_pool_test.id
}

output "aws_saml_provider_arns" {
  value = aws_cognito_identity_pool.aws_cognito_identity_pool_test.arn
}

output "aws_option_group_name" {
  value = aws_db_option_group.test-option-group.name
}

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway_route_table.aws_ec2_transit_gateway_route_table1.transit_gateway_id
}

output "transit_gateway_route_table_id" {
  value = aws_ec2_transit_gateway_route_table.aws_ec2_transit_gateway_route_table1.id
}

output "launch_template_name" {
  value = aws_launch_template.launch-template-test.name
}

output "aws_vpn_gateway_id" {
  value = aws_vpn_gateway.inspec_vpn_gw.id
}

output "aws_amazon_side_asn" {
  value = aws_vpn_gateway.inspec_vpn_gw.amazon_side_asn
}

output "aws_transit_gateway_route_table_id_association" {
  value = aws_ec2_transit_gateway_route_table.aws_ec2_transit_gateway_route_table_association1.id
}

output "aws_transit_gateway_attachment_id_association" {
  value = aws_ec2_transit_gateway_vpc_attachment.aws_ec2_transit_gateway_vpc_attachment_association1.id
}

output "aws_transit_gateway_attachment_vpc_id_association" {
  value = aws_vpc.attachment.id
}

output "network_acl_id" {
  value = aws_network_acl.inspec-nw-acl.id
}

output "aws_db_parameter_group_arn" {
  value = aws_db_parameter_group.inspec_db_parameter_group.arn
}

output "aws_transit_gateway_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.aws_ec2_transit_gateway_vpc_attachment1.id
}

output "aws_transit_gateway_id1" {
  value = aws_ec2_transit_gateway_vpc_attachment.aws_ec2_transit_gateway_vpc_attachment1.transit_gateway_id
}

output "aws_transit_gateway_owner_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.aws_ec2_transit_gateway_vpc_attachment1.vpc_owner_id
}

output "aws_redshift_cluster_identifier" {
  value = aws_redshift_cluster.redshift_test.cluster_identifier
}

output "aws_vpc_endpoint_notification_id" {
  value = aws_vpc_endpoint_connection_notification.test-endpoint-notification.id
}

output "aws_vpc_notifications_arn" {
  value = aws_vpc_endpoint_connection_notification.test-endpoint-notification.connection_notification_arn
}

output "aws_transit_gateway_route_table_id" {
  value = aws_ec2_transit_gateway.gateway.association_default_route_table_id
}

output "aws_vpc_endpoint_service_name" {
  value = aws_vpc_endpoint_service.notification_service.service_name
}

output "aws_vpc_endpoint_service_id" {
  value = aws_vpc_endpoint_service.notification_service.id
}

output "aws_vpc_base_endpoint_dns_names" {
  value = aws_vpc_endpoint_service.notification_service.base_endpoint_dns_names
}

output "resolver_rule_arn" {
  value = aws_route53_resolver_rule.sys.arn
}

output "resolver_rule_type" {
  value = aws_route53_resolver_rule.sys.rule_type
}

output "resolver_rule_association_id" {
  value = aws_route53_resolver_rule_association.for-int-test.id
}

output "resolver_rule_id" {
  value =  aws_route53_resolver_rule_association.for-int-test.resolver_rule_id
}

output "re_vpc_id" {
  value =  aws_route53_resolver_rule_association.for-int-test.vpc_id
}

output "aws_ram_resource_share_arn" {
  value = aws_ram_resource_share.aws_ram_resource_share_test.arn
}

output "aws_secure_cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.secure_distribution.0.id
}

output "aws_insecure_cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.insecure_distribution.0.id
}

output "aws_default_cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.default.0.id
}

output "aws_vpc_endpoint_service_allowed_principal_arn" {
  value = aws_vpc_endpoint_service_allowed_principal.notification_service_principal.principal_arn
}

output "load_balancer_arn" {
  value = aws_lb.test.arn
}

output "listener_arn" {
  value = aws_lb_listener.front_end.arn
}

output "aws_sfn_state_machine_id" {
  value = aws_sfn_state_machine.sfn_state_machine_sf_test.id
}

output "aws_sfn_state_machine_arn" {
  value = aws_sfn_state_machine.sfn_state_machine_sf_test.arn
}

output "aws_sfn_state_machine_status" {
  value = aws_sfn_state_machine.sfn_state_machine_sf_test.status
}

output "aws_sfn_state_machine_role_arn" {
  value = aws_iam_role.aws_iam_role_sf_test.arn
}

output "aws_route_table_association_id" {
  value = aws_route_table_association.association_route_table_first.id
}

output "aws_route_table_associated_subnet" {
  value = aws_route_table_association.association_route_table_first.subnet_id
}

output "aws_servicecatalog_product_sm_id" {
  value = aws_servicecatalog_product.aws_servicecatalog_product_sc_test.id
}

output "aws_servicecatalog_portfolio_sm_id" {
  value = aws_servicecatalog_portfolio.aws_servicecatalog_portfolio_sc_test.id
}

output "aws_servicecatalog_portfolio_sm_arn" {
  value = aws_servicecatalog_portfolio.aws_servicecatalog_portfolio_sc_test.arn
}

output "aws_servicecatalog_portfolio_sm_created_time" {
  value = aws_servicecatalog_portfolio.aws_servicecatalog_portfolio_sc_test.created_time
}

output "aws_servicecatalog_constraint_sm_id" {
  value = aws_servicecatalog_constraint.aws_servicecatalog_constraint_sc_test.id
}

output "aws_iam_role_sc_test_sm_arn" {
  value = aws_iam_role.aws_iam_role_sc_test.arn
}

output "aws_resolver_endpoint_id" {
  value = aws_route53_resolver_endpoint.for-int.id
}

output "aws_resolver_endpoint_arn" {
  value = aws_route53_resolver_endpoint.for-int.arn
}

output "aws_resolver_endpoint_name" {
  value = aws_route53_resolver_endpoint.for-int.name
}

output "aws_resolver_endpoint_vpc_id" {
  value = aws_route53_resolver_endpoint.for-int.host_vpc_id
}

output "aws_resolver_endpoint_security_group_ids" {
  value = aws_route53_resolver_endpoint.for-int.security_group_ids
}

output "aws_lambda_event_source_mapping_uuid" {
  value = aws_lambda_event_source_mapping.event_source_mapping.uuid
}

output "aws_lambda_event_source_mapping_function_arn" {
  value = aws_lambda_event_source_mapping.event_source_mapping.function_arn
}

output "aws_lambda_event_source_mapping_last_modified" {
  value = aws_lambda_event_source_mapping.event_source_mapping.last_modified
}

output "aws_lambda_event_source_mapping_last_processing_result" {
  value = aws_lambda_event_source_mapping.event_source_mapping.last_processing_result
}

output "aws_lambda_event_source_mapping_state" {
  value = aws_lambda_event_source_mapping.event_source_mapping.state
}

output "aws_lambda_event_source_mapping_state_transition_reason" {
  value = aws_lambda_event_source_mapping.event_source_mapping.state_transition_reason
}

output "aws_lambda_event_source_mapping_function_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "aws_lambda_event_source_mapping_event_source_arn" {
  value = aws_lambda_event_source_mapping.event_source_mapping.event_source_arn
}

output "aws_route53_hosted_zone_id" {
  value = aws_route53_zone.for_route53_set_record_test.zone_id
}

output "aws_iam_instance_profile_id" {
  value = aws_iam_instance_profile.aws_iam_instance_profile_test.id
}

output "aws_iam_instance_profile_arn" {
  value = aws_iam_instance_profile.aws_iam_instance_profile_test.arn
}

output "aws_iam_role_id" {
  value = aws_iam_role.aws_iam_role_test.id
}

output "aws_iam_role_arn" {
  value = aws_iam_role.aws_iam_role_test.arn
}
output "aws_secretsmanager_secret_sm_id" {
  value = aws_secretsmanager_secret.aws_secretsmanager_secret_sm_test.id
}

output "aws_secretsmanager_secret_sm_arn" {
  value = aws_secretsmanager_secret.aws_secretsmanager_secret_sm_test.arn
}
output "server_certificate_name" {
  value = aws_iam_server_certificate.test_cert.name
}