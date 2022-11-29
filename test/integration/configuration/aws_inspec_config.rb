# Configuration helper for AWS & Inspec
# - Terraform expects a JSON variable file
# - Inspec expects a YAML attribute file
# This allows to store all transient parameters in one place.
# If any of the @config keys are exported as environment variables in uppercase, these take precedence.
require 'json'
require 'yaml'

module AWSInspecConfig
  # helper method for adding random strings
  def self.add_random_string(length = 25)
    (0...length).map { rand(65..90).chr }.join.downcase.to_s
  end

  def self.region_parser(raw)
    profile_name = nil
    raw.lines.inject({}) do |profile_region, line|
      line.delete!("\n") # remove newline characters
      line = line.split(/^|\s#|;/).first # remove comments
      # checks if line contains the profile name in [] eg. [default]
      profile = line.strip.match(/^\[([^\[\]]+)\]\s*$/) unless line.nil?
      if profile
        profile_name = profile[1]
        # catches instances where "profile" is appended to the profile name eg. [profile partner-eng-tester]
        named_profile = profile_name.match(/^profile\s+(.+?)$/)
        # sets profile_name to the profile name found in the match data
        profile_name = named_profile[1] if named_profile
      elsif profile_name
        unless line.nil?
          # checks if the line contains a region eg. "region = us-west-1"
          region = line.match(/^*region*\s=\s*(.+?)\s*$/i)
        end
        if region
          profile_region[profile_name] ||= {}
          profile_region[profile_name]['region'] = region[1]
        end
      end
      profile_region
    end
  end

  if ENV['aws_region']
    @aws_region = ENV['aws_region']
  elsif File.exist?(ENV["HOME"] + "/.aws/config")
    config_regions = region_parser(File.read("#{ENV["HOME"]}/.aws/config"))
    @aws_region = config_regions['default']['region'] if config_regions['default']['region']
    @aws_region = config_regions[ENV['aws_profile']]['region'] if ENV['aws_profile'] && config_regions[ENV['aws_profile']]['region']
  else
    @aws_region = 'us-east-1'
  end

  # Config for terraform / inspec in the below hash
  @config = {
      # Generic AWS resource parameters
      aws_region: @aws_region,
      aws_availability_zone: "#{@aws_region}a",
      aws_alb_name: "alb-#{add_random_string}",
      aws_auto_scaling_group: "aws-auto-scaling-group-#{add_random_string}",
      aws_bucket_acl_policy_name: "aws-bucket-acl-policy-name-#{add_random_string}",
      aws_bucket_auth_name: "aws-bucket-auth-#{add_random_string}",
      aws_bucket_encryption_disabled: "aws-bucket-encryption-enabled-name-#{add_random_string}",
      aws_bucket_encryption_enabled: "aws-bucket-encryption-enabled-name-#{add_random_string}",
      aws_bucket_log_delivery_name: "aws-bucket-log-delivery-name-#{add_random_string}",
      aws_bucket_log_sender_name: "aws-bucket-log-sender-name-#{add_random_string}",
      aws_bucket_logging_disabled: "aws-bucket-logging-disabled-name-#{add_random_string}",
      aws_bucket_private_name: "aws-bucket-private-#{add_random_string}",
      aws_bucket_public_name: "aws-bucket-public-#{add_random_string}",
      aws_bucket_public_objects_name: "aws-bucket-public-objects-#{add_random_string}",
      aws_bucket_versioning_disabled: "aws-bucket-version-disabled-#{add_random_string}",
      aws_bucket_versioning_enabled: "aws-bucket-version-enabled-#{add_random_string}",
      aws_cloudformation_stack_name: "aws-cloudformation-stack-#{add_random_string}",
      aws_cloudformation_stack_ecr_name: "aws-cloudformation-stack-ecr-name-#{add_random_string}",
      aws_cloudfront_origin_s3_bucket: "inspec-cloudfront-origin-#{add_random_string}",
      aws_cloud_trail_bucket_name: "aws-cloud-trail-bucket-#{add_random_string}",
      aws_cloud_trail_key_description: "aws-cloud-trail-key-description-#{add_random_string}",
      aws_cloud_trail_log_group: "aws-cloud-trail-log-group-#{add_random_string}",
      aws_cloud_trail_name: "aws-cloud-trail-#{add_random_string}",
      aws_cloud_trail_open_name: "aws-cloud-trail-open-#{add_random_string}",
      aws_cloud_watch_alarm_metric_name: 'aws_cloudwatch_alarm_metric_1',
      aws_cloud_watch_alarm_name: "aws-cloudwatch-alarm-#{add_random_string}",
      aws_cloud_watch_alarm_metric_name_with_dimensions: 'aws_cloudwatch_alarm_metric_1',
      aws_cloud_watch_alarm_name_with_dimensions: "aws-cloudwatch-alarm-#{add_random_string}",
      aws_cloud_watch_log_group_name: "aws_cloudwatch_log_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_namespace_with_dimensions: "aws_lmf_namespace_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_log_group_name: "aws_lmf_log_group_name_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_metric_name: "aws_lmf_metric_name_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_name: "aws_cloudwatch_lmf_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_namespace: "aws_lmf_namespace_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_pattern: "awslmfpattern1#{add_random_string}",
      aws_cloud_watch_log_metric_filter_two_log_group_name: "aws_lmf_pattern_log_group_name_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_two_metric_name: "aws_lmf_pattern_metric_name_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_two_name: "aws_cloudwatch_lmf_pattern_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_two_namespace: "aws_lmf_namespace_#{add_random_string}",
      aws_cloud_watch_log_metric_filter_two_pattern: "awslmfpattern1#{add_random_string}",
      aws_cloud_watch_logs_role_name: "aws-iam-role-cloud-watch-logs-#{add_random_string}",
      aws_cloud_watch_logs_role_policy_name: "aws-iam-role-cloud-watch-logs-policy-#{add_random_string}",
      aws_configuration_recorder_name: "aws-config-recorder-#{add_random_string}",
      aws_configuration_recorder_role: "aws-config-recorder-role-#{add_random_string}",
      aws_dynamodb_table_name: "aws-dynamodb-table-#{add_random_string}",
      aws_delivery_channel_bucket_name: "aws-delivery-channel-bucket-#{add_random_string}",
      aws_delivery_channel_frequency: 'TwentyFour_Hours',
      aws_delivery_channel_name: "aws-delivery-channel-#{add_random_string}",
      aws_delivery_channel_sns_topic_name: "aws-delivery-channel-sns-topic-#{add_random_string}",
      aws_ebs_volume_name: "inspec-ebs-volume-name-#{add_random_string}",
      aws_ebs_encrypted_volume_name: "inspec-ebs-encrypted-volume-name-#{add_random_string}",
      aws_ebs_snapshot_name: "inspec-ebs-snapshot-name-#{add_random_string}",
      aws_ebs_encrypted_snapshot_name: "inspec-ebs-encrypted-snapshot-name-#{add_random_string}",
      aws_ecr_name: "aws-ecr-name-#{add_random_string}",
      aws_ecr_repository_name: "aws-ecr-repo-name-#{add_random_string}",
      aws_ecr_repository_image_tag_mutability: 'MUTABLE',
      aws_ecr_repository_scan_on_push_enabled: false,
      aws_ecrpublic_name: "aws-ecrpublic-name-#{add_random_string}",
      aws_ecrpublic_repository_name: "aws-ecrpublic-repo-name-#{add_random_string}",
      aws_ecs_cluster_name: "ecs-cluster-#{add_random_string}",
      aws_efs_creation_token: "aws-efs-creation-token-#{add_random_string}",
      aws_efs_encrypted: "true",
      aws_efs_performance_mode: "generalPurpose",
      aws_efs_throughput_mode: "bursting",
      aws_efs_name: "aws-efs-name-#{add_random_string}",
      aws_efs_company_name: "My Company Name",
      aws_efs_count: 3,
      aws_eks_cluster_name: "eks-cluster-#{add_random_string}",
      aws_eks_role_name: "eks-role-#{add_random_string}",
      aws_eks_subnet_name_1: "eks-subnet-1-#{add_random_string}",
      aws_eks_subnet_name_2: "eks-subnet-2-#{add_random_string}",
      aws_eks_vpc_name: "eks-vpc-name-#{add_random_string}",
      aws_emr_cluster_name: "emr-cluster-#{add_random_string}",
      aws_elasticache_cluster_id: "elasticache-cluster-#{add_random_string}",
      aws_elasticache_cluster_engine: "memcached",
      aws_elasticache_cluster_node_type: "cache.t2.micro",
      aws_elasticache_cluster_num_cache_nodes: 3,
      aws_elasticache_cluster_parameter_group_name: "default.memcached1.5",
      aws_elasticache_cluster_engine_version: "1.5.16",
      aws_elasticache_cluster_port: 11211,
      aws_elasticache_replication_group_node_type: "cache.t2.micro",
      aws_elasticache_replication_group_id: "elasticache-rg-#{add_random_string}",
      aws_elb_access_log_name: "elb-log-name-#{add_random_string}",
      aws_elb_access_log_prefix: "elb-log-prefix-#{add_random_string}",
      aws_elb_name: "elb-#{add_random_string}",
      aws_emr_security_configuration_name: "emr-sec-config-#{add_random_string}",
      aws_flow_log_bucket_name: "aws-flow-log-bucket-#{add_random_string}",
      aws_iam_user_name: "iam-user-#{add_random_string}",
      aws_iam_user_policy_name: "iam-user-policy-#{add_random_string}",
      aws_internet_gateway_name: 'inspec-aws-internet-gateway',
      aws_internet_gateway_name_tag: "inspec-aws-igw-#{add_random_string}",
      aws_internet_gateway_vpc_name: "aws-vpc-for-igw-#{add_random_string}",
      aws_iam_group_name: "iam_group-#{add_random_string}",
      aws_iam_group_policy_name: "aws-iam-group-policy-#{add_random_string}",
      aws_iam_role_generic_name: "aws-iam-role-#{add_random_string}",
      aws_iam_role_generic_policy_name: "aws-iam-role-policy-#{add_random_string}",
      aws_iam_policy_arn: "aws-iam-policy-arn-#{add_random_string}",
      aws_iam_policy_name: "aws-iam-policy-name-#{add_random_string}",
      aws_iam_policy_name_for_lambda: "aws-iam-policy-name-#{add_random_string}",
      aws_iam_role_name_for_ec2: "aws-iam-role-#{add_random_string}",
      aws_iam_profile_name_for_ec2: "aws-iam-policy-name-#{add_random_string}",
      aws_iam_role_name_for_lambda: "aws-iam-role-#{add_random_string}",
      aws_iam_attached_policy_name: "aws-iam-policy-name-#{add_random_string}",
      aws_key_description_disabled: 'InSpec KMS Key Test Disabled',
      aws_key_description_enabled: 'InSpec KMS Key Test Enabled',
      aws_launch_configuration_name: "aws-launch-configuration-name-#{add_random_string}",
      aws_nat_gateway_name: "aws-nat-gateway-#{add_random_string}",
      aws_nat_gateway_eip_name: "aws-nat-gateway-eip-#{add_random_string}",
      aws_nat_gateway_subnet_name: "aws-nat-gateway-subnet-#{add_random_string}",
      aws_rds_db_engine: 'mysql',
      aws_rds_db_engine_version: '5.6.37',
      aws_rds_db_identifier: "awsrds#{add_random_string}",
      aws_rds_db_master_user: 'awsinspecuser',
      aws_rds_db_name: "awsrdsname#{add_random_string}",
      aws_rds_db_storage_type: 'gp2',
      aws_rds_db_subnet_group_name: "subnet-group-name-#{add_random_string}",
      aws_rds_db_subnet_group_description: "subnet-group-description-#{add_random_string}",
      rds_subnet_name_1: "rds-subnet-name-#{add_random_string}",
      aws_rds_cluster_database_name: "awsclusterdbname#{add_random_string}" ,
      aws_rds_cluster_engine: "aurora",
      aws_rds_cluster_identifier: "awscluster-#{add_random_string}",
      aws_rds_cluster_instance_1_identifier: "aws-cluster-instance-1-#{add_random_string}",
      aws_rds_cluster_instance_2_identifier: "aws-cluster-instance-1-#{add_random_string}",
      aws_rds_cluster_master_user: 'awsinspecuser',
      aws_security_group_alpha: "aws-security-group-alpha-#{add_random_string}",
      aws_security_group_beta: "aws-security-group-beta-#{add_random_string}",
      aws_security_group_gamma: "aws-security-group-gamma-#{add_random_string}",
      aws_security_group_zeta: "aws-security-group-zeta-#{add_random_string}",
      aws_security_group_omega: "aws-security-group-omega-#{add_random_string}",
      aws_security_group_lb: "aws-security-group-lb-#{add_random_string}",
      aws_ssm_parameter_name: "parameter-name-#{add_random_string}",
      aws_ssm_document_name: "aws_ssm_document_name_#{add_random_string}",
      aws_sqs_queue_name: "aws-sqs-queue-#{add_random_string}",
      aws_sns_topic_with_encryption: "aws-sns-topic-encryption-#{add_random_string}",
      aws_sns_topic_no_subscription: "aws-sns-topic-no-subscription-#{add_random_string}",
      aws_sns_topic_subscription_sqs: "aws-sns-topic-subscription-sqs-#{add_random_string}",
      aws_sns_topic_with_subscription: "aws-sns-topic-subscription-#{add_random_string}",
      aws_subnet_ip_address_count: 16,
      aws_subnet_name: 'inspec-aws-subnet',
      aws_vm_image_filter: 'ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*',
      aws_vm_name: "aws-inspec-linux-ubuntu-#{add_random_string}",
      aws_vm_size: 't3.micro',
      aws_vpc_cidr_block: '10.0.0.0/27', # i.e. 32 IP addresses
      aws_vpc_instance_tenancy: 'dedicated',
      aws_vpc_name: "inspec-aws-vpc-#{add_random_string}",
      aws_vpc_dhcp_options_name: 'inspec-aws-dopt',
      aws_vpc_endpoint_name: "aws-vpc-endpoint-#{add_random_string}",
      # Simple flag to disable creation of resources (useful when prototyping new ones in isolation)
      aws_enable_creation: 1,
      # Flag to optionally disable creation/controls for configuration recorder (only 1 per AWS region allowed)
      aws_create_configuration_recorder: 0,
      # Some resources require elevated privileges to create and therefore test against.  The below flag is used to
      # control both the terraform resource creation and the inspec test execution for those resources.
      # Default behaviour is for this to be disabled meaning a user needs no special AWS privileges to run the
      # integration test pack.
      #
      # Note, would prefer to use boolean true or false here but will revisit for a future version of tf, see here for
      # more detail: https://www.terraform.io/docs/configuration/variables.html
      aws_enable_privileged_resources: 0,
      # Some controls make use of the gcloud command and grep to discover live data to then test against.
      # Only test execution is affected by this flag, resource creation via terraform is unaffected.
      # Default behaviour is for this to be disabled, enable by changing the below flag.
      aws_enable_cli_calls: 0,
      aws_route_53_zone: "aws-route53-zone-#{add_random_string}",
      aws_elasticsearch_domain_name: "domain1",
      aws_elasticsearch_version: "7.10",
      aws_elasticsearch_instance_type: "r6g.large.elasticsearch",
      aws_elasticsearch_automated_snapshot_start_hour: 23,
      aws_openid_connect_provider_arns: "arn:aws:iam::123456789012:oidc-provider/id.example.com",
      aws_image_id: "ami-09f56df189a29f532",
      aws_instance_type: "t2.micro",
      aws_auto_scaling_group_name: "test1",
      aws_auto_scaling_max_size: 1,
      aws_auto_scaling_min_size: 0,
      aws_auto_scaling_health_check_grace_period: 300,
      aws_auto_scaling_health_check_type: "ELB",
      aws_auto_scaling_force_delete: true,
      aws_auto_scaling_policy_name: "test_policy",
      aws_auto_scaling_adjustment: 4,
      aws_auto_scaling_adjustment_type: "ChangeInCapacity",
      aws_auto_scaling_cooldown: 300,
      tgw_route_cidr_block: '0.0.0.0/15',
      tgw_route_cidr_block_blockhole: '0.0.0.0/16',
      aws_launch_template_name: "launch_template-#{add_random_string}",
      aws_launch_template_core: 4,
      aws_launch_template_threads_per_core: 2,
      aws_launch_template_cpu_credits: "standard",
      aws_launch_template_volume_size: 20,
      aws_launch_template_instance_profile: "test-profile",
      aws_launch_template_resource_type: "instance",
      aws_launch_template_tag_name: "test",
      aws_launch_template_instance_type: "t2.micro",
      aws_launch_template_kernel_id: "test_kernel_id",
      aws_launch_template_key_name: "test_key_name",
      aws_vpn_gw_name: 'inspec_vpn_gw',
      aws_db_parameter_group_name: 'inspec-mysql-db-group-param',
      aws_db_parameter_group_family_name: 'mysql5.6',
      aws_db_parameter_group_description: 'Inspec Managed parameter group for mysql5.6',
      aws_db_option_group_name: 'option-group-test-terraform2',
      aws_db_option_group_description: 'Terraform Option Group',
      aws_db_option_group_engine_name: 'sqlserver-ee',
      aws_redshift_cluster_identifier: "redshift-cluster-#{add_random_string}",
      aws_redshift_parameter_group_name: "group#{add_random_string}",
      aws_redshift_parameter_group_family: "redshift-1.0",
      aws_network_acl_cidr_block: '10.3.0.0/18',
      aws_network_acl_name: 'inspec-nw-acl',
      acl_egress_rule_number: 100,
      acl_ingress_rule_number: 100,
      aws_enforce_workgroup_configuration: true,
      aws_publish_cloudwatch_metrics_enabled: true,
      aws_athena_workgroup: "test-workgroup",
      aws_athena_workgroup_description: "Test work group",
      aws_athena_workgroup_state: "ENABLED",
      aws_client_name: "pool_client",
      aws_identity_pool_name: "mypool",
      aws_batch_job_queue_name: "batch-queue-test-#{add_random_string}",
      aws_batch_job_queue_status: "ENABLED",
      aws_batch_job_queue_priority: 1,
      aws_compute_environment_name: "test-#{add_random_string}",
      aws_max_vcpus: 1,
      aws_min_vcpus: 0,
      aws_type: "EC2",
      aws_batch_job_name: "test1",
      aws_batch_job_type: "container",
      aws_route52_record_set_name: "integration.test.",
      aws_crawler_name: "crawler",
      aws_sfn_state_machine_name: "my-state-machine",
      aws_transfer_user_name: "tftestuser",
      aws_route53_resolver_endpoint_name: "endpooint-#{add_random_string}",
      aws_ecs_task_definition_family: "service-#{add_random_string}",
      aws_ecs_service_name: "bar-#{add_random_string}",
      aws_cluster_name: "white-hart-#{add_random_string}",
      aws_location: "us-east-2c",
      aws_vpn_connection_route_destination_cidr_block: "192.168.10.0/24",
      aws_vpn_connection_route_state: "available",
      aws_accepter_vpc_info_cidr_block: "10.2.0.0/16",
      aws_requester_vpc_info_cidr_block: "10.1.0.0/16",
  }

  def self.config
    @config
  end

  # This method ensures any environment variables take precedence.
  def self.update_from_environment
    @config.each { |k, v| @config[k] = ENV[k.to_s.upcase] || v }
  end

  # Create JSON for terraform
  def self.store_json(file_name = 'aws-inspec.tfvars.json')
    update_from_environment
    File.open(File.join(File.dirname(__FILE__), '..', 'build', file_name), 'w') do |f|
      f.write(@config.to_json)
    end
  end

  # Create YAML for inspec
  def self.store_yaml(file_name = 'aws-inspec-attributes.yaml')
    update_from_environment
    File.open(File.join(File.dirname(__FILE__), '..', 'build', file_name), 'w') do |f|
      f.write(@config.to_yaml)
    end
  end

  def self.get_tf_output_vars(file_name = 'outputs.tf')
    # let's assume that all lines starting with 'output' contain the desired target name
    # (brittle but this way we don't need to preserve a list)
    outputs = []
    outputs_file = File.join(File.dirname(__FILE__), '..', 'build', file_name)
    File.read(outputs_file).lines.each do |line|
      next if !line.start_with?('output')
      outputs += [line.sub(/^output \"/, "").sub(/\" {\n/, '')]
    end
    outputs
  end

  def self.update_yaml(file_name = 'aws-inspec-attributes.yaml')
    build_dir = File.join(File.dirname(__FILE__), '..', 'build')
    contents = YAML.load_file(File.join(build_dir, file_name))
    outputs = get_tf_output_vars
    outputs.each do |tf|
      # also assuming single values here
      value = `cd #{build_dir} && terraform output #{tf}`.strip
      contents[tf.to_sym] = value
    end
    File.open(File.join(File.dirname(__FILE__), '..', 'build', file_name), 'w') do |f|
      f.write(contents.to_yaml)
    end
  end
end
