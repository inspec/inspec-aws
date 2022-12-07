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

output "aws_ebs_volume_encrypted" {
  value = aws_ebs_volume.inspec_encrypted_ebs_volume.0.encrypted
}

output "aws_ebs_volume_iops" {
  value = aws_ebs_volume.inspec_encrypted_ebs_volume.0.iops
}

output "aws_ebs_volume_size" {
  value = aws_ebs_volume.inspec_encrypted_ebs_volume.0.size
}

output "aws_ebs_volume_type" {
  value = aws_ebs_volume.inspec_encrypted_ebs_volume.0.type
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

output "aws_rds_snapshot_identifier" {
  value = aws_db_snapshot.test_db_snapshot.db_instance_identifier
}

output "aws_rds_snapshot_engine" {
  value = aws_db_snapshot.test_db_snapshot.engine
}

output "aws_rds_snapshot_engine_version" {
  value = aws_db_snapshot.test_db_snapshot.engine_version
}

output "aws_rds_snapshot_storage_type" {
  value = aws_db_snapshot.test_db_snapshot.storage_type
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

output "listener_arn" {
  value = aws_lb_listener.front_end.arn
}

output "aws_traffic_filter_id" {
  value = aws_ec2_traffic_mirror_filter.filter.id
}

output "aws_traffic_filter_desc" {
  value = aws_ec2_traffic_mirror_filter.filter.description
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

output "aws_vpc_peering_test1_id" {
  value = aws_vpc.aws_vpc_peering_test1.id
}

output "aws_vpc_peering_test2_id" {
  value = aws_vpc.aws_vpc_peering_test2.id
}

output "aws_vpc_peering_connection_id" {
  value = aws_vpc_peering_connection.aws_vpc_peering_connection_test.id
}

output "traffic_mirror_session_id" {
  value = aws_ec2_traffic_mirror_session.session.id
}

output "traffic_mirror_target_id" {
  value = aws_ec2_traffic_mirror_session.session.traffic_mirror_target_id
}

output "traffic_mirror_filter_id" {
  value = aws_ec2_traffic_mirror_session.session.traffic_mirror_filter_id
}

output "network_interface_id" {
  value = aws_ec2_traffic_mirror_session.session.network_interface_id
}

output "aws_egress_only_internet_gateway_id" {
  value = aws_egress_only_internet_gateway.aws_egress_only_internet_gateway_test1.id
}

output "aws_vpc_eoig_test1_id" {
  value = aws_vpc.aws_vpc_eoig_test1.id
}

output "oidc_arn" {
  value = aws_iam_openid_connect_provider.for_oidc.arn
}

output "aws_cloudfront_origin_access_identity_id" {
  value = aws_cloudfront_origin_access_identity.aws_cloudfront_origin_access_identity_test1.id
}

output "aws_cloudfront_origin_access_identity_s3_canonical_user_id" {
  value = aws_cloudfront_origin_access_identity.aws_cloudfront_origin_access_identity_test1.s3_canonical_user_id
}

output "aws_cloudfront_origin_access_identity_caller_reference" {
  value = aws_cloudfront_origin_access_identity.aws_cloudfront_origin_access_identity_test1.caller_reference
}

output "aws_vpn_connection_id" {
  value = aws_vpn_connection.aws_vpn_connection_vpn_connection_route_test.id
}

output "aws_vpn_customer_gateway_id" {
  value = aws_vpn_connection.aws_vpn_connection_vpn_connection_route_test.customer_gateway_id
}

output "aws_ec2_fleet_id" {
  value = aws_ec2_fleet.aws_ec2_fleet_test1.id
}

output "aws_customer_gateway_id" {
  value = aws_customer_gateway.aws_customer_gateway_test1.id
}

output "aws_customer_gateway_arn" {
  value = aws_customer_gateway.aws_customer_gateway_test1.arn
}

output "aws_ec2_capacity_reservation_id" {
  value = aws_ec2_capacity_reservation.aws_ec2_capacity_reservation_test1.id
}

output "aws_ec2_capacity_reservation_instance_type" {
  value = aws_ec2_capacity_reservation.aws_ec2_capacity_reservation_test1.instance_type
}

output "aws_ec2_capacity_reservation_instance_platform" {
  value = aws_ec2_capacity_reservation.aws_ec2_capacity_reservation_test1.instance_platform
}

output "aws_ec2_capacity_reservation_availability_zone" {
  value = aws_ec2_capacity_reservation.aws_ec2_capacity_reservation_test1.availability_zone
}

output "aws_ec2_capacity_reservation_instance_count" {
  value = aws_ec2_capacity_reservation.aws_ec2_capacity_reservation_test1.instance_count
}

output "aws_ec2_capacity_reservation_instance_arn" {
  value = aws_ec2_capacity_reservation.aws_ec2_capacity_reservation_test1.arn
}

output "aws_cloudfront_realtime_log_config_name" {
  value = aws_cloudfront_realtime_log_config.aws_cloudfront_realtime_log_config_test1.name
}

output "aws_cloudfront_realtime_log_config_arn" {
  value = aws_cloudfront_realtime_log_config.aws_cloudfront_realtime_log_config_test1.arn
}

output "aws_cloudfront_realtime_log_config_sampling_rate" {
  value = aws_cloudfront_realtime_log_config.aws_cloudfront_realtime_log_config_test1.sampling_rate
}

output "aws_end_points_kinesis_stream_config_role_arn" {
  value = aws_cloudfront_realtime_log_config.aws_cloudfront_realtime_log_config_test1.sampling_rate
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.aws_internet_gateway_test.id
}

output "aws_internet_gateway_owner_id" {
  value = aws_internet_gateway.aws_internet_gateway_test.owner_id
}

output "aws_internet_gateway_vpc_id" {
  value = aws_vpc.aws_vpc_internet_gateway_test.id
}

output "aws_network_interface_id1" {
  value = aws_network_interface.aws_network_interface_test.id
}

output "aws_cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.id
}

output "aws_cloudfront_distribution_enabled" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.enabled
}

output "aws_cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.arn
}

output "aws_cloudfront_distribution_caller_reference" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.caller_reference
}

output "aws_cloudfront_distribution_status" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.status
}

output "aws_cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.domain_name
}

output "aws_cloudfront_distribution_in_progress_validation_batches" {
  value = aws_cloudfront_distribution.aws_cloudfront_distribution_test1.in_progress_validation_batches
}

output "domain-names-sdb" {
  value = aws_simpledb_domain.users.name
}

output "aws_api_gateway_deployement_id" {
  value = aws_api_gateway_stage.aws_api_gateway_stage_test.deployment_id
}

output "aws_api_gateway_stage_name_test" {
  value = aws_api_gateway_stage.aws_api_gateway_stage_test.stage_name
}

output "aws_api_gateway_client_certificate_id_test" {
  value = aws_api_gateway_stage.aws_api_gateway_stage_test.client_certificate_id
}

output "aws_api_gateway_rest_api_id_test" {
  value = aws_api_gateway_stage.aws_api_gateway_stage_test.rest_api_id
}

output "aws_api_gateway_rest_api_id" {
  value = aws_api_gateway_rest_api.aws_api_gateway_rest_api_bm_test1.id
}

output "aws_api_gateway_stage_name" {
  value = aws_api_gateway_stage.aws_api_gateway_stage_bm_test1.stage_name
}

output "aws_api_gateway_base_path_mapping_domain_name" {
  value = aws_api_gateway_base_path_mapping.aws_api_gateway_base_path_mapping_bm_test1.domain_name
}

output "aws_api_gateway_account_throttle_settings" {
  value = aws_api_gateway_account.aws_api_gateway_account_test1.throttle_settings
}

output "aws_api_gateway_account_cloudwatch_role_arn" {
  value = aws_api_gateway_account.aws_api_gateway_account_test1.cloudwatch_role_arn
}

output "aws_api_gateway_api_key_id" {
  value = aws_api_gateway_api_key.aws_api_gateway_api_key_test1.id
}

output "aws_api_gateway_api_key_created_date" {
  value = aws_api_gateway_api_key.aws_api_gateway_api_key_test1.created_date
}

output "aws_api_gateway_api_key_last_updated_date" {
  value = aws_api_gateway_api_key.aws_api_gateway_api_key_test1.last_updated_date
}

output "aws_api_gateway_api_key_arn" {
  value = aws_api_gateway_api_key.aws_api_gateway_api_key_test1.arn
}

output "aws_api_gateway_authorizer_id" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.id
}

output "aws_api_gateway_authorizer_authorizer_uri" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.authorizer_uri
}

output "aws_api_gateway_authorizer_authorizer_credentials" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.authorizer_credentials
}

output "aws_api_gateway_authorizer_authorizer_result_ttl_in_seconds" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.authorizer_result_ttl_in_seconds
}

output "aws_api_gateway_authorizer_name" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.name
}

output "aws_api_gateway_authorizer_type" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.type
}

output "aws_api_gateway_authorizer_provider_arns" {
  value = aws_api_gateway_authorizer.aws_api_gateway_authorizer_test1.provider_arns
}

output "aws_api_gateway_rest_api_id1" {
  value = aws_api_gateway_rest_api.aws_api_gateway_rest_api_test2.id
}

output "aws_api_gateway_client_certificate_id" {
  value = aws_api_gateway_client_certificate.aws_api_gateway_client_certificate_test1.id
}

output "aws_api_gateway_client_certificate_created_date" {
  value = aws_api_gateway_client_certificate.aws_api_gateway_client_certificate_test1.created_date
}

output "aws_api_gateway_client_certificate_expiration_date" {
  value = aws_api_gateway_client_certificate.aws_api_gateway_client_certificate_test1.expiration_date
}

output "aws_api_gateway_client_certificate_pem_encoded_certificate" {
  value = aws_api_gateway_client_certificate.aws_api_gateway_client_certificate_test1.pem_encoded_certificate
}

output "aws_cloudfront_group_id" {
  value =  aws_cloudfront_key_group.example.id
}

output "aws_cloudfront_group_name" {
  value =  aws_cloudfront_key_group.example.name
}

output "aws_cloudfront_group_comment" {
  value =  aws_cloudfront_key_group.example.comment
}

output "broker_id" {
  value = aws_mq_broker.test-broker.id
}

output "broker_arn" {
  value = aws_mq_broker.test-broker.arn
}

output "aws_db_cluster_snapshot_id" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.id
}

output "aws_db_cluster_snapshot_availability_zones" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.availability_zones
}

output "aws_db_cluster_snapshot_allocated_storage" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.allocated_storage
}

output "aws_db_cluster_snapshot_status" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.status
}

output "aws_db_cluster_snapshot_engine" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.engine
}

output "aws_db_cluster_snapshot_engine_version" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.engine_version
}

output "aws_db_cluster_snapshot_db_cluster_identifier" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.db_cluster_identifier
}

output "aws_db_cluster_snapshot_db_cluster_snapshot_arn" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.db_cluster_snapshot_arn
}

output "aws_db_cluster_snapshot_vpc_id" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.vpc_id
}

output "aws_db_cluster_snapshot_source_db_cluster_snapshot_arn" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.source_db_cluster_snapshot_arn
}

output "aws_db_cluster_snapshot_storage_encrypted" {
  value = aws_db_cluster_snapshot.aws_db_cluster_snapshot_test.storage_encrypted
}

output "aws_placement_group_name" {
  value = aws_placement_group.web.name
}

output "aws_cloudfront_cache_policy_id" {
  value = aws_cloudfront_cache_policy.aws_cloudfront_cache_policy_test1.id
}

output "request_origin_id" {
  value = aws_cloudfront_origin_request_policy.test-origin-policy.id
}

output "dashboard_name" {
  value = aws_cloudwatch_dashboard.main.dashboard_name
}

output "dashboard_arn" {
  value = aws_cloudwatch_dashboard.main.dashboard_arn
}

output "server_certificate_name" {
  value = aws_iam_server_certificate.test_cert.name
}

output "server_certificate_id" {
  value = aws_iam_server_certificate.test_cert.id
}

output "client_vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.test-endpoint.id
}

output "association_id" {
  value = aws_ec2_client_vpn_network_association.test-association.id
}

output "target_vpc_subnet_id" {
  value = aws_ec2_client_vpn_route.test-route.id
}

output "aws_cloudwatch_anomaly_detector_namespace" {
  value = aws_cloudwatch_metric_alarm.aws_cloudwatch_anomaly_detector_test1.namespace
}

output "aws_cloudwatch_anomaly_detector_metric_name" {
  value = aws_cloudwatch_metric_alarm.aws_cloudwatch_anomaly_detector_test1.metric_name
}

output "aws_signer_signing_profile_id" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.id
}

output "aws_signer_signing_profile_name" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.name
}

output "aws_signer_signing_profile_platform_id" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.platform_id
}

output "aws_signer_signing_profile_status" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.status
}

output "aws_signer_signing_profile_arn" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.arn
}

output "aws_signer_signing_profile_version" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.version
}

output "aws_signer_signing_profile_version_arn" {
  value = aws_signer_signing_profile.aws_signer_signing_profile_test.version_arn
}

output "configuration_id" {
  value = aws_mq_configuration.for_broker.id
}

output "configuration_arn" {
  value = aws_mq_configuration.for_broker.arn
}

output "aws_cloudwatch_log_stream_name" {
  value = aws_cloudwatch_log_stream.for_test.name
}

output "aws_cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.for_stream.name
}

output "aws_cloudwatch_log_stream_arn" {
  value = aws_cloudwatch_log_stream.for_test.arn
}

output "aws_volume_attachment_instance_device_name" {
  value = aws_volume_attachment.aws_volume_attachment_test.device_name
}

output "aws_volume_attachment_instance_volume_id" {
  value = aws_volume_attachment.aws_volume_attachment_test.volume_id
}

output "aws_networkfirewall_firewall_id" {
  value = aws_networkfirewall_firewall.aws_networkfirewall_firewall_test.id
}

output "aws_networkfirewall_firewall_policy_arn" {
  value = aws_networkfirewall_firewall.aws_networkfirewall_firewall_test.firewall_policy_arn
}

output "aws_networkfirewall_firewall_name" {
  value = aws_networkfirewall_firewall.aws_networkfirewall_firewall_test.name
}

output "aws_networkfirewall_firewall_vpc_id" {
  value = aws_networkfirewall_firewall.aws_networkfirewall_firewall_test.vpc_id
}

output "aws_networkfirewall_firewall_arn" {
  value = aws_networkfirewall_firewall.aws_networkfirewall_firewall_test.arn
}

output "aws_networkfirewall_firewall_policy_name" {
  value = aws_networkfirewall_firewall_policy.aws_networkfirewall_firewall_policy_test.name
}

output "aws_networkfirewall_firewall_policy_id" {
  value = aws_networkfirewall_firewall.aws_networkfirewall_firewall_test.id
}

output "aws_networkfirewall_rule_group_name" {
  value = aws_networkfirewall_rule_group.aws_networkfirewall_rule_group_test.name
}

output "aws_networkfirewall_rule_group_arn" {
  value = aws_networkfirewall_rule_group.aws_networkfirewall_rule_group_test.id
}

output "aws_networkfirewall_rule_group_capacity" {
  value = aws_networkfirewall_rule_group.aws_networkfirewall_rule_group_test.capacity
}

output "aws_networkfirewall_rule_group_type" {
  value = aws_networkfirewall_rule_group.aws_networkfirewall_rule_group_test.type
}

output "aws_spot_fleet_request_id" {
  value = aws_spot_fleet_request.aws_spot_fleet_request_test.id
}

output "aws_spot_fleet_request_iam_fleet_role" {
  value = aws_spot_fleet_request.aws_spot_fleet_request_test.iam_fleet_role
}

output "app_id" {
  value = aws_amplify_app.test-app.id
}

output "branch_name" {
  value = aws_amplify_app.test-app.name
}

output "aws_emr_security_configuration_name" {
  value = aws_emr_security_configuration.emr_security_configuration.name
}

output "aws_emr_security_configuration_json" {
  value = aws_emr_security_configuration.emr_security_configuration.configuration
}

output "aws_emr_cluster_id" {
  value = aws_emr_cluster.emr_cluster.id
}
output "aws_emr_cluster_service_role" {
  value = aws_emr_cluster.emr_cluster.service_role
}

output "aws_emr_cluster_applications" {
  value = aws_emr_cluster.emr_cluster.applications
}

output "aws_emr_cluster_arn" {
  value = aws_emr_cluster.emr_cluster.arn
}

output "aws_emr_cluster_name" {
  value = aws_emr_cluster.emr_cluster.name
}

output "aws_emr_cluster_visible_to_all_users" {
  value = aws_emr_cluster.emr_cluster.visible_to_all_users
}

output "aws_emr_cluster_release_label" {
  value = aws_emr_cluster.emr_cluster.release_label
}

output "aws_emr_cluster_log_uri" {
  value = aws_emr_cluster.emr_cluster.log_uri
}

output "aws_cloudfront_public_key_name" {
  value =  aws_cloudfront_public_key.test_cf_pk.name
}

output "aws_cloudfront_public_key_id" {
  value =  aws_cloudfront_public_key.test_cf_pk.id
}

output "aws_cloudfront_public_key" {
  value =  aws_cloudfront_public_key.test_cf_pk.encoded_key
}

output "stream_arns" {
  value = aws_cloudwatch_metric_stream.main.name
}

output "stream_name" {
  value = aws_cloudwatch_metric_stream.main.arn
}

output "aws_lambda_function_event_invoke_config_id" {
  value = aws_lambda_function_event_invoke_config.aws_lambda_function_event_invoke_config_test1.id
}

output "aws_lambda_function_event_invoke_config_arn" {
  value = aws_lambda_function.aws_lambda_function_lambda_event_invoke_config_test1.arn
}

output "aws_lambda_function_event_invoke_config_function_name" {
  value = aws_lambda_function_event_invoke_config.aws_lambda_function_event_invoke_config_test1.function_name
}

output "aws_lambda_layer_version_id" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.id
}

output "aws_eip_association_id" {
  value = aws_eip.aws_eip_1.association_id
}

output "aws_placement_group_placement_group_id" {
  value = aws_placement_group.aws_placement_group_test1.placement_group_id
}

output "aws_lambda_code_signing_config_id" {
  value = aws_lambda_code_signing_config.aws_lambda_code_signing_config_test1.id
}

output "aws_lambda_code_signing_config_arn" {
  value = aws_lambda_code_signing_config.aws_lambda_code_signing_config_test1.arn
}

output "aws_lambda_code_signing_config_description" {
  value = aws_lambda_code_signing_config.aws_lambda_code_signing_config_test1.description
}

output "aws_lambda_code_signing_config_last_modified" {
  value = aws_lambda_code_signing_config.aws_lambda_code_signing_config_test1.last_modified
}

output "aws_ses_receipt_rule_id" {
  value = aws_ses_receipt_rule.aws_ses_receipt_rule_test1.id
}

output "aws_ses_receipt_rule_arn" {
  value = aws_ses_receipt_rule.aws_ses_receipt_rule_test1.arn
}

output "aws_ses_receipt_rule_name" {
  value = aws_ses_receipt_rule.aws_ses_receipt_rule_test1.name
}

output "aws_ses_receipt_rule_rule_set_name" {
  value = aws_ses_receipt_rule.aws_ses_receipt_rule_test1.rule_set_name
}

output "aws_ses_receipt_rule_set_id" {
  value = aws_ses_receipt_rule_set.aws_ses_receipt_rule_set_test1.id
}

output "aws_ses_receipt_rule_set_name" {
  value = aws_ses_receipt_rule_set.aws_ses_receipt_rule_set_test1.rule_set_name
}

output "aws_ses_receipt_rule_set_arn" {
  value = aws_ses_receipt_rule_set.aws_ses_receipt_rule_set_test1.arn
}

output "aws_ses_template_id" {
  value = aws_ses_template.aws_ses_template_test1.id
}

output "aws_ses_template_name" {
  value = aws_ses_template.aws_ses_template_test1.name
}

output "aws_ses_template_subject" {
  value = aws_ses_template.aws_ses_template_test1.subject
}

output "aws_ses_template_html" {
  value = aws_ses_template.aws_ses_template_test1.html
}

output "aws_ses_template_text" {
  value = aws_ses_template.aws_ses_template_test1.text
}

output "aws_lambda_alias_function_name" {
  value = aws_lambda_function.aws_lambda_function_alias_test1.function_name
}

output "aws_lambda_alias_name" {
  value = aws_lambda_alias.aws_lambda_alias_test1.name
}

output "aws_lambda_alias_description" {
  value = aws_lambda_alias.aws_lambda_alias_test1.description
}

output "aws_lambda_alias_arn" {
  value = aws_lambda_alias.aws_lambda_alias_test1.arn
}

output "aws_proxy_name" {
  value = aws_db_proxy.for_proxy.name
}

output "subscription_name" {
  value = aws.aws_db_event_subscription.name
}

output "global_cluster_identifier" {
  value = aws_rds_global_cluster.for_test.global_cluster_identifier
}

output "aws_signer_signing_profile_permission_id" {
  value = aws_signer_signing_profile_permission.aws_signer_signing_profile_permission_test1.id
}

output "aws_signer_signing_profile_permission_action" {
  value = aws_signer_signing_profile_permission.aws_signer_signing_profile_permission_test1.action
}

output "aws_signer_signing_profile_permission_principal" {
  value = aws_signer_signing_profile_permission.aws_signer_signing_profile_permission_test1.principal
}

output "aws_signer_signing_profile_permission_profile_name" {
  value = aws_signer_signing_profile_permission.aws_signer_signing_profile_permission_test1.profile_name
}

output "aws_signer_signing_profile_permission_statement_id" {
  value = aws_signer_signing_profile_permission.aws_signer_signing_profile_permission_test1.statement_id
}

output "aws_lambda_layer_version_layer_arn" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.layer_arn
}

output "aws_lambda_layer_version_created_date" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.created_date
}

output "aws_lambda_layer_version_signing_job_arn" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.signing_job_arn
}

output "aws_lambda_layer_version_signing_profile_version_arn" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.signing_profile_version_arn
}

output "aws_lambda_layer_version_source_code_size" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.source_code_size
}

output "aws_lambda_layer_version" {
  value = aws_lambda_layer_version.aws_lambda_layer_version_test1.version
}

output "db_proxy_name" {
  value = aws_db_proxy.for_proxy.name
}

output "target_group_name" {
  value = aws_db_proxy_default_target_group.for_proxy.name
}

output "bucket_name" {
  value = aws_s3_bucket.my_test_bucket.id
}

output "aws_ssm_maintenance_window_id" {
  value = aws_ssm_maintenance_window.aws_ssm_maintenance_window_test1.id
}

output "aws_ssm_maintenance_window_target_id" {
  value = aws_ssm_maintenance_window_target.aws_ssm_maintenance_window_target_test1.id
}

output "aws_ssm_maintenance_window_target_name" {
  value = aws_ssm_maintenance_window_target.aws_ssm_maintenance_window_target_test1.name
}

output "aws_ssm_maintenance_window_target_description" {
  value = aws_ssm_maintenance_window_target.aws_ssm_maintenance_window_target_test1.description
}

output "aws_ssm_maintenance_window_target_window_id" {
  value = aws_ssm_maintenance_window_target.aws_ssm_maintenance_window_target_test1.window_id
}

output "aws_ssm_maintenance_window_task_id" {
  value = aws_ssm_maintenance_window_task.aws_ssm_maintenance_window_task_test1.id
}

output "aws_ssm_maintenance_window_task_window_id" {
  value = aws_ssm_maintenance_window_task.aws_ssm_maintenance_window_task_test1.window_id
}

output "aws_ssm_maintenance_window_task_task_arn" {
  value = aws_ssm_maintenance_window_task.aws_ssm_maintenance_window_task_test1.task_arn
}

output "aws_ssm_maintenance_window_task_task_type" {
  value = aws_ssm_maintenance_window_task.aws_ssm_maintenance_window_task_test1.task_type
}

output "aws_ssm_maintenance_window_task_max_concurrency" {
  value = aws_ssm_maintenance_window_task.aws_ssm_maintenance_window_task_test1.max_concurrency
}

output "aws_ssm_maintenance_window_task_priority" {
  value = aws_ssm_maintenance_window_task.aws_ssm_maintenance_window_task_test1.priority
}

output "aws_ssm_patch_baseline_id" {
  value = aws_ssm_patch_baseline.aws_ssm_patch_baseline_test1.id
}

output "aws_ssm_patch_baseline_arn" {
  value = aws_ssm_patch_baseline.aws_ssm_patch_baseline_test1.arn
}

output "aws_ssm_patch_baseline_name" {
  value = aws_ssm_patch_baseline.aws_ssm_patch_baseline_test1.name
}

output "aws_ssm_patch_baseline_approved_patches" {
  value = aws_ssm_patch_baseline.aws_ssm_patch_baseline_test1.approved_patches
}

output "aws_ssm_resource_data_sync_name" {
  value = aws_ssm_resource_data_sync.aws_ssm_resource_data_sync_test1.name
}

output "aws_ssm_resource_data_sync_id" {
  value = aws_ssm_resource_data_sync.aws_ssm_resource_data_sync_test1.id
}

output "aws_route53_zone_id" {
  value = aws_route53_zone.test_zone.id
}

output "aws_route53_zone_name" {
  value = aws_route53_zone.test_zone.name
}

output "aws_waf_byte_match_set_id" {
  value = aws_waf_byte_match_set.aws_waf_byte_match_set_test1.id
}

output "aws_waf_byte_match_set_name" {
  value = aws_waf_byte_match_set.aws_waf_byte_match_set_test1.name
}

output "aws_waf_byte_match_set_byte_match_tuples" {
  value = aws_waf_byte_match_set.aws_waf_byte_match_set_test1.byte_match_tuples
}

output "aws_waf_ipset_id" {
  value = aws_waf_ipset.aws_waf_ipset_test1.id
}

output "aws_waf_ipset_arn" {
  value = aws_waf_ipset.aws_waf_ipset_test1.arn
}

output "aws_waf_ipset_name" {
  value = aws_waf_ipset.aws_waf_ipset_test1.name
}

output "aws_waf_ipset_ip_set_descriptors" {
  value = aws_waf_ipset.aws_waf_ipset_test1.ip_set_descriptors
}

output "aws_waf_rule_id" {
  value = aws_waf_rule.aws_waf_rule_test1.id
}

output "aws_waf_rule_name" {
  value = aws_waf_rule.aws_waf_rule_test1.name
}

output "aws_waf_rule_arn" {
  value = aws_waf_rule.aws_waf_rule_test1.arn
}

output "aws_waf_rule_metric_name" {
  value = aws_waf_rule.aws_waf_rule_test1.metric_name
}

output "aws_waf_size_constraint_set_id" {
  value = aws_waf_size_constraint_set.aws_waf_size_constraint_set_test1.id
}

output "aws_waf_size_constraint_set_name" {
  value = aws_waf_size_constraint_set.aws_waf_size_constraint_set_test1.name
}

output "aws_waf_size_constraint_set_arn" {
  value = aws_waf_size_constraint_set.aws_waf_size_constraint_set_test1.arn
}

output "aws_waf_size_constraint_set_size_constraints" {
  value = aws_waf_size_constraint_set.aws_waf_size_constraint_set_test1.size_constraints
}

output "aws_waf_sql_injection_match_set_id" {
  value = aws_waf_sql_injection_match_set.sql_injection_match_set.id
}

output "aws_waf_sql_injection_match_set_name" {
  value = aws_waf_sql_injection_match_set.sql_injection_match_set.name
}

output "aws_waf_web_acl_id" {
  value = aws_waf_web_acl.aws_waf_web_acl_test1.id
}

output "aws_waf_web_acl_arn" {
  value = aws_waf_web_acl.aws_waf_web_acl_test1.arn
}

output "aws_waf_web_acl_name" {
  value = aws_waf_web_acl.aws_waf_web_acl_test1.name
}

output "aws_waf_web_acl_metric_name" {
  value = aws_waf_web_acl.aws_waf_web_acl_test1.metric_name
}

output "aws_api_gateway_rest_api_id_1" {
  value = aws_api_gateway_rest_api.aws_api_gateway_rest_api_test.id
}

output "aws_api_gateway_documentation_part_id" {
  value = aws_api_gateway_documentation_part.aws_api_gateway_documentation_part_test.id
}

output "aws_api_gateway_documentation_part_location_type" {
  value = aws_api_gateway_documentation_part.aws_api_gateway_documentation_part_test.location[0].type
}

output "aws_api_gateway_documentation_part_location_path" {
  value = aws_api_gateway_documentation_part.aws_api_gateway_documentation_part_test.location[0].path
}

output "aws_api_gateway_documentation_part_location_method" {
  value = aws_api_gateway_documentation_part.aws_api_gateway_documentation_part_test.location[0].method
}

output "aws_api_gateway_documentation_part_location_status_code" {
  value = aws_api_gateway_documentation_part.aws_api_gateway_documentation_part_test.location[0].status_code
}

output "aws_api_gateway_documentation_part_location_name" {
  value = aws_api_gateway_documentation_part.aws_api_gateway_documentation_part_test.location[0].name
}

output "aws_api_gateway_documentation_version_id" {
  value = aws_api_gateway_documentation_version.aws_api_gateway_documentation_version_test.id
}

output "aws_api_gateway_documentation_version_description" {
  value = aws_api_gateway_documentation_version.aws_api_gateway_documentation_version_test.description
}

output "aws_synthetics_canary_name" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.name
}

output "aws_synthetics_canary_id" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.id
}

output "aws_synthetics_canary_execution_role_arn" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.execution_role_arn
}

output "aws_synthetics_canary_artifact_s3_location" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.artifact_s3_location
}

output "aws_synthetics_canary_source_location_arn" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.source_location_arn
}

output "aws_synthetics_canary_engine_arn" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.engine_arn
}

output "aws_synthetics_canary_timeline" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.timeline
}

output "aws_synthetics_canary_status" {
  value = aws_synthetics_canary.aws_synthetics_canary_test1.status
}

output "aws_sfn_activity_id" {
  value = aws_sfn_activity.aws_sfn_activity_test1.id
}

output "aws_sfn_activity_name" {
  value = aws_sfn_activity.aws_sfn_activity_test1.name
}

output "aws_sfn_activity_creation_date" {
  value = aws_sfn_activity.aws_sfn_activity_test1.creation_date
}

output "aws_api_gateway_model_id" {
  value = aws_api_gateway_model.aws_api_gateway_model_test.id
}

output "aws_api_gateway_model_name" {
  value = aws_api_gateway_model.aws_api_gateway_model_test.name
}

output "aws_api_gateway_model_content_type" {
  value = aws_api_gateway_model.aws_api_gateway_model_test.content_type
}

output "aws_api_gateway_model_description" {
  value = aws_api_gateway_model.aws_api_gateway_model_test.description
}

output "aws_api_gateway_model_rest_api_id" {
  value = aws_api_gateway_model.aws_api_gateway_model_test.rest_api_id
}

output "aws_api_gateway_gateway_response_id" {
  value = aws_api_gateway_gateway_response.test.id
}

output "aws_api_gateway_gateway_response_response_type" {
  value = aws_api_gateway_gateway_response.test.response_type
}

output "aws_api_gateway_resource_id" {
  value = aws_api_gateway_resource.aws_api_gateway_resource_test.id
}

output "aws_api_gateway_resource_rest_api_id" {
  value = aws_api_gateway_resource.aws_api_gateway_resource_test.rest_api_id
}

output "aws_api_gateway_resource_parent_id" {
  value = aws_api_gateway_resource.aws_api_gateway_resource_test.parent_id
}

output "aws_api_gateway_resource_path_part" {
  value = aws_api_gateway_resource.aws_api_gateway_resource_test.path_part
}

output "aws_api_gateway_resource_path" {
  value = aws_api_gateway_resource.aws_api_gateway_resource_test.path
}

output "aws_api_gateway_resource_status" {
  value = aws_api_gateway_resource.aws_api_gateway_resource_test.status
}

output "aws_api_gateway_request_validator_id" {
  value = aws_api_gateway_request_validator.aws_api_gateway_request_validator_test.id
}

output "aws_api_gateway_request_validator_name" {
  value = aws_api_gateway_request_validator.aws_api_gateway_request_validator_test.name
}

output "aws_api_gateway_request_validator_rest_api_id" {
  value = aws_api_gateway_request_validator.aws_api_gateway_request_validator_test.rest_api_id
}

output "aws_api_gateway_request_validator_validate_request_body" {
  value = aws_api_gateway_request_validator.aws_api_gateway_request_validator_test.validate_request_body
}

output "aws_api_gateway_request_validator_validate_request_parameters" {
  value = aws_api_gateway_request_validator.aws_api_gateway_request_validator_test.validate_request_parameters
}

// API Gateway VPC Link

resource "aws_default_subnet" "aws_default_subnet_rest_api_test" {
  availability_zone = "us-east-2a"

  tags = {
    Name = "DefaultSubnet"
  }
}

resource "aws_lb" "aws_lb_rest_api_test" {
  name               = "example"
  internal           = true
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id = aws_default_subnet.aws_default_subnet_rest_api_test.id
  }
}

resource "aws_api_gateway_vpc_link" "aws_api_gateway_vpc_link_test" {
  name        = "example"
  description = "example description"
  target_arns = [aws_lb.aws_lb_rest_api_test.arn]
}

output "aws_api_gateway_vpc_link_id" {
  value = aws_api_gateway_vpc_link.aws_api_gateway_vpc_link_test.id
}

output "aws_api_gateway_vpc_link_name" {
  value = aws_api_gateway_vpc_link.aws_api_gateway_vpc_link_test.name
}

output "aws_api_gateway_vpc_link_description" {
  value = aws_api_gateway_vpc_link.aws_api_gateway_vpc_link_test.description
}

output "aws_api_gateway_vpc_link_target_arns" {
  value = aws_api_gateway_vpc_link.aws_api_gateway_vpc_link_test.target_arns
}

output "aws_api_gateway_usage_plan_id" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.id
}

output "aws_api_gateway_usage_plan_name" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.name
}

output "aws_api_gateway_usage_plan_description" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.description
}

output "aws_api_gateway_usage_plan_product_code" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.product_code
}

output "aws_api_gateway_usage_plan_api_stages" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.api_stages
}

output "aws_api_gateway_usage_plan_quota_settings" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.quota_settings
}

output "aws_api_gateway_usage_plan_throttle_settings" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.throttle_settings
}

output "aws_api_gateway_usage_plan_arn" {
  value = aws_api_gateway_usage_plan.aws_api_gateway_usage_plan_test.arn
}

output "aws_api_gateway_api_key_name" {
  value = aws_api_gateway_api_key.aws_api_gateway_api_key_test.name
}

output "aws_api_gateway_usage_plan_key_id" {
  value = aws_api_gateway_usage_plan_key.aws_api_gateway_usage_plan_key_test.id
}

output "aws_api_gateway_usage_plan_key_key_type" {
  value = aws_api_gateway_usage_plan_key.aws_api_gateway_usage_plan_key_test.key_type
}

output "aws_api_gateway_usage_plan_key_usage_plan_id" {
  value = aws_api_gateway_usage_plan_key.aws_api_gateway_usage_plan_key_test.usage_plan_id
}

output "aws_api_gateway_usage_plan_key_name" {
  value = aws_api_gateway_usage_plan_key.aws_api_gateway_usage_plan_key_test.name
}

output "aws_api_gateway_usage_plan_key_value" {
  value = aws_api_gateway_usage_plan_key.aws_api_gateway_usage_plan_key_test.value
}

########################################################################################################################################################
##################################################################  AWS::ApiGatewayV2 ##################################################################
########################################################################################################################################################

########################################################################################################################################################
################################################################  AWS::ApiGatewayV2::Api ###############################################################
########################################################################################################################################################

output "aws_apigatewayv2_api_id" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.id
}

output "aws_apigatewayv2_api_api_endpoint" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.api_endpoint
}

output "aws_apigatewayv2_api_api_key_selection_expression" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.api_key_selection_expression
}

output "aws_apigatewayv2_api_description" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.description
}

output "aws_apigatewayv2_api_disable_execute_api_endpoint" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.disable_execute_api_endpoint
}

output "aws_apigatewayv2_api_name" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.name
}

output "aws_apigatewayv2_api_protocol_type" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.protocol_type
}

output "aws_apigatewayv2_api_route_selection_expression" {
  value = aws_apigatewayv2_api.aws_apigatewayv2_api_test.route_selection_expression
}

########################################################################################################################################################
############################################################  AWS::ApiGatewayV2::ApiMapping ############################################################
########################################################################################################################################################

output "aws_apigatewayv2_api_mapping_id" {
  value = aws_apigatewayv2_api_mapping.aws_apigatewayv2_api_mapping_test.id
}

output "aws_apigatewayv2_api_mapping_api_id" {
  value = aws_apigatewayv2_api_mapping.aws_apigatewayv2_api_mapping_test.api_id
}

output "aws_apigatewayv2_api_mapping_api_mapping_key" {
  value = aws_apigatewayv2_api_mapping.aws_apigatewayv2_api_mapping_test.api_mapping_key
}

output "aws_apigatewayv2_api_mapping_domain_name" {
  value = aws_apigatewayv2_api_mapping.aws_apigatewayv2_api_mapping_test.domain_name
}

output "aws_apigatewayv2_api_mapping_stage" {
  value = aws_apigatewayv2_api_mapping.aws_apigatewayv2_api_mapping_test.stage
}

########################################################################################################################################################
############################################################  AWS::ApiGatewayV2::Authorizer ############################################################
########################################################################################################################################################

output "aws_apigatewayv2_authorizer_id" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.id
}

output "aws_apigatewayv2_authorizer_api_id" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.api_id
}

output "aws_apigatewayv2_authorizer_authorizer_credentials_arn" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.authorizer_credentials_arn
}

output "aws_apigatewayv2_authorizer_authorizer_payload_format_version" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.authorizer_payload_format_version
}

output "aws_apigatewayv2_authorizer_authorizer_result_ttl_in_seconds" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.authorizer_result_ttl_in_seconds
}

output "aws_apigatewayv2_authorizer_authorizer_type" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.authorizer_type
}

output "aws_apigatewayv2_authorizer_authorizer_uri" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.authorizer_uri
}

output "aws_apigatewayv2_authorizer_enable_simple_responses" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.enable_simple_responses
}

output "aws_apigatewayv2_authorizer_identity_sources" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.identity_sources
}

output "aws_apigatewayv2_authorizer_jwt_configuration" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.jwt_configuration
}

output "aws_apigatewayv2_authorizer_name" {
  value = aws_apigatewayv2_authorizer.aws_apigatewayv2_authorizer_test.name
}

########################################################################################################################################################
############################################################  AWS::ApiGatewayV2::Deployment ############################################################
########################################################################################################################################################

output "aws_apigatewayv2_deployment_api_id" {
  value = aws_apigatewayv2_deployment.aws_apigatewayv2_deployment_test.api_id
}

output "aws_apigatewayv2_deployment_id" {
  value = aws_apigatewayv2_deployment.aws_apigatewayv2_deployment_test.id
}

output "aws_apigatewayv2_deployment_description" {
  value = aws_apigatewayv2_deployment.aws_apigatewayv2_deployment_test.description
}

output "aws_apigatewayv2_deployment_auto_deployed" {
  value = aws_apigatewayv2_deployment.aws_apigatewayv2_deployment_test.auto_deployed
}

output "aws_apigatewayv2_deployment_triggers" {
  value = aws_apigatewayv2_deployment.aws_apigatewayv2_deployment_test.triggers
}

########################################################################################################################################################
############################################################  AWS::ApiGatewayV2::DomainName ############################################################
########################################################################################################################################################

output "aws_apigatewayv2_domain_name_id" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.id
}

output "aws_apigatewayv2_domain_name_domain_name" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.domain_name
}

output "aws_apigatewayv2_domain_name_arn" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.arn
}

output "aws_apigatewayv2_domain_name_api_mapping_selection_expression" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.api_mapping_selection_expression
}

output "aws_apigatewayv2_domain_name_domain_name_configuration" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.domain_name_configuration
}

output "aws_apigatewayv2_domain_name_mutual_tls_authentication" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.mutual_tls_authentication
}

output "aws_apigatewayv2_domain_name_timeouts" {
  value = aws_apigatewayv2_domain_name.aws_apigatewayv2_domain_name_test.timeouts
}

########################################################################################################################################################
##############################################################  AWS::ApiGatewayV2::Stage ###############################################################
########################################################################################################################################################

output "aws_apigatewayv2_stage_id" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.id
}

output "aws_apigatewayv2_stage_arn" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.arn
}

output "aws_apigatewayv2_stage_api_id" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.api_id
}

output "aws_apigatewayv2_stage_description" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.description
}

output "aws_apigatewayv2_stage_name" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.name
}

output "aws_apigatewayv2_stage_execution_arn" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.execution_arn
}

output "aws_apigatewayv2_stage_access_log_settings" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.access_log_settings
}

output "aws_apigatewayv2_stage_auto_deploy" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.auto_deploy
}

output "aws_apigatewayv2_stage_client_certificate_id" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.client_certificate_id
}

output "aws_apigatewayv2_stage_tags" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.tags
}

output "aws_apigatewayv2_stage_stage_variables" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.stage_variables
}

output "aws_apigatewayv2_stage_route_settings" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.route_settings
}

output "aws_apigatewayv2_stage_deployment_id" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.deployment_id
}

output "aws_apigatewayv2_stage_default_route_settings" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.default_route_settings
}

output "aws_apigatewayv2_stage_invoke_url" {
  value = aws_apigatewayv2_stage.aws_apigatewayv2_stage_test.invoke_url
}

########################################################################################################################################################
##############################################################  AWS::ApiGatewayV2::Integration #########################################################
########################################################################################################################################################

output "aws_apigatewayv2_integration_description" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.description
}

output "aws_apigatewayv2_integration_api_id" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.api_id
}

output "aws_apigatewayv2_integration_id" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.id
}

output "aws_apigatewayv2_integration_credentials_arn" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.credentials_arn
}

output "aws_apigatewayv2_integration_connection_id" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.connection_id
}

output "aws_apigatewayv2_integration_integration_method" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.integration_method
}

output "aws_apigatewayv2_integration_integration_type" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.integration_type
}

output "aws_apigatewayv2_integration_integration_response_selection_expression" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.integration_response_selection_expression
}

output "aws_apigatewayv2_integration_integration_uri" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.integration_uri
}

output "aws_apigatewayv2_integration_integration_subtype" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.integration_subtype
}

output "aws_apigatewayv2_integration_request_parameters" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.request_parameters
}

output "aws_apigatewayv2_integration_request_templates" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.request_templates
}

output "aws_apigatewayv2_integration_response_parameters" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.response_parameters
}

output "aws_apigatewayv2_integration_tls_config" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.tls_config
}

output "aws_apigatewayv2_integration_timeout_milliseconds" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.timeout_milliseconds
}

output "aws_apigatewayv2_integration_template_selection_expression" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.template_selection_expression
}

output "aws_apigatewayv2_integration_payload_format_version" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.payload_format_version
}

output "aws_apigatewayv2_integration_passthrough_behavior" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.passthrough_behavior
}

output "aws_apigatewayv2_integration_content_handling_strategy" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.content_handling_strategy
}

output "aws_apigatewayv2_integration_connection_type" {
  value = aws_apigatewayv2_integration.aws_apigatewayv2_integration_test.connection_type
}

########################################################################################################################################################
########################################################  AWS::ApiGatewayV2::IntegrationResponse #######################################################
########################################################################################################################################################

output "aws_apigatewayv2_integration_response_content_handling_strategy" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.content_handling_strategy
}

output "aws_apigatewayv2_integration_response_template_selection_expression" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.template_selection_expression
}

output "aws_apigatewayv2_integration_response_id" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.id
}

output "aws_apigatewayv2_integration_response_api_id" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.api_id
}

output "aws_apigatewayv2_integration_response_integration_id" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.integration_id
}

output "aws_apigatewayv2_integration_response_response_templates" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.response_templates
}

output "aws_apigatewayv2_integration_response_integration_response_key" {
  value = aws_apigatewayv2_integration_response.aws_apigatewayv2_integration_response_test.integration_response_key
}

########################################################################################################################################################
###############################################################  AWS::ApiGatewayV2::Model ##############################################################
########################################################################################################################################################

output "aws_apigatewayv2_model_api_id" {
  value = aws_apigatewayv2_model.aws_apigatewayv2_model_test.api_id
}

output "aws_apigatewayv2_model_id" {
  value = aws_apigatewayv2_model.aws_apigatewayv2_model_test.id
}

output "aws_apigatewayv2_model_description" {
  value = aws_apigatewayv2_model.aws_apigatewayv2_model_test.description
}

output "aws_apigatewayv2_model_name" {
  value = aws_apigatewayv2_model.aws_apigatewayv2_model_test.name
}

output "aws_apigatewayv2_model_content_type" {
  value = aws_apigatewayv2_model.aws_apigatewayv2_model_test.content_type
}

output "aws_apigatewayv2_model_schema" {
  value = aws_apigatewayv2_model.aws_apigatewayv2_model_test.schema
}

########################################################################################################################################################
###############################################################  AWS::ApiGatewayV2::Route ##############################################################
########################################################################################################################################################

output "aws_apigatewayv2_route_id" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.id
}

output "aws_apigatewayv2_route_api_id" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.api_id
}

output "aws_apigatewayv2_route_api_key_required" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.api_key_required
}

output "aws_apigatewayv2_route_authorization_scopes" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.authorization_scopes
}

output "aws_apigatewayv2_route_authorization_type" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.authorization_type
}

output "aws_apigatewayv2_route_authorizer_id" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.authorizer_id
}

output "aws_apigatewayv2_route_model_selection_expression" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.model_selection_expression
}

output "aws_apigatewayv2_route_operation_name" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.operation_name
}

output "aws_apigatewayv2_route_target" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.target
}

output "aws_apigatewayv2_route_route_response_selection_expression" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.route_response_selection_expression
}

output "aws_apigatewayv2_route_route_key" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.route_key
}

output "aws_apigatewayv2_route_request_parameter" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.request_parameter
}

output "aws_apigatewayv2_route_request_models" {
  value = aws_apigatewayv2_route.aws_apigatewayv2_route_test.request_models
}

########################################################################################################################################################
########################################################### AWS::ApiGatewayV2::RouteResponse ###########################################################
########################################################################################################################################################

output "aws_apigatewayv2_route_response_id" {
  value = aws_apigatewayv2_route_response.aws_apigatewayv2_route_response_test.id
}

output "aws_apigatewayv2_route_response_api_id" {
  value = aws_apigatewayv2_route_response.aws_apigatewayv2_route_response_test.api_id
}

output "aws_apigatewayv2_route_response_model_selection_expression" {
  value = aws_apigatewayv2_route_response.aws_apigatewayv2_route_response_test.model_selection_expression
}

output "aws_apigatewayv2_route_response_route_response_key" {
  value = aws_apigatewayv2_route_response.aws_apigatewayv2_route_response_test.route_response_key
}

output "aws_apigatewayv2_route_response_route_id" {
  value = aws_apigatewayv2_route_response.aws_apigatewayv2_route_response_test.route_id
}

output "aws_apigatewayv2_route_response_response_models" {
  value = aws_apigatewayv2_route_response.aws_apigatewayv2_route_response_test.response_models
}

########################################################################################################################################################
############################################################## AWS::ApiGatewayV2::VpcLink ##############################################################
########################################################################################################################################################

output "aws_apigatewayv2_vpc_link_id" {
  value = aws_apigatewayv2_vpc_link.aws_apigatewayv2_vpc_link_test.id
}

output "aws_apigatewayv2_vpc_link_name" {
  value = aws_apigatewayv2_vpc_link.aws_apigatewayv2_vpc_link_test.name
}

output "aws_apigatewayv2_vpc_link_tags" {
  value = aws_apigatewayv2_vpc_link.aws_apigatewayv2_vpc_link_test.tags
}

output "aws_apigatewayv2_vpc_link_arn" {
  value = aws_apigatewayv2_vpc_link.aws_apigatewayv2_vpc_link_test.arn
}

output "aws_apigatewayv2_vpc_link_security_group_ids" {
  value = aws_apigatewayv2_vpc_link.aws_apigatewayv2_vpc_link_test.security_group_ids
}

output "aws_apigatewayv2_vpc_link_subnet_ids" {
  value = aws_apigatewayv2_vpc_link.aws_apigatewayv2_vpc_link_test.subnet_ids
}


