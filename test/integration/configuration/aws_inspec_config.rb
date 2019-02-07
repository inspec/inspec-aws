# frozen_string_literal: true

# Configuration helper for AWS & Inspec
# - Terraform expects a JSON variable file
# - Inspec expects a YAML attribute file
# This allows to store all transient parameters in one place.
# If any of the @config keys are exported as environment variables in uppercase, these take precedence.
require 'json'
require 'yaml'
require 'passgen'

module AWSInspecConfig
  # helper method for adding random strings
  def self.add_random_string(length = 25)
    (0...length).map { rand(65..90).chr }.join.downcase.to_s
  end

  # Config for terraform / inspec in the below hash
  @config = {
      # Generic AWS resource parameters
      aws_region: 'us-east-1',
      aws_availability_zone: 'us-east-1a',
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
      aws_cloud_trail_bucket_name: "aws-cloud-trail-bucket-#{add_random_string}",
      aws_cloud_trail_key_description: "aws-cloud-trail-key-description-#{add_random_string}",
      aws_cloud_trail_log_group: "aws-cloud-trail-log-group-#{add_random_string}",
      aws_cloud_trail_name: "aws-cloud-trail-#{add_random_string}",
      aws_cloud_trail_open_name: "aws-cloud-trail-open-#{add_random_string}",
      aws_cloud_watch_alarm_metric_name: 'aws_cloudwatch_alarm_metric_1',
      aws_cloud_watch_alarm_name: "aws-cloudwatch-alarm-#{add_random_string}",
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
      aws_delivery_channel_bucket_name: "aws-delivery-channel-bucket-#{add_random_string}",
      aws_delivery_channel_frequency: 'TwentyFour_Hours',
      aws_delivery_channel_name: "aws-delivery-channel-#{add_random_string}",
      aws_delivery_channel_sns_topic_name: "aws-delivery-channel-sns-topic-#{add_random_string}",
      aws_ebs_volume_name: 'inspec-ebs-volume-name',
      aws_ecs_cluster_name: "ecs-cluster-#{add_random_string}",
      aws_elb_access_log_name: "elb-log-name-#{add_random_string}",
      aws_elb_access_log_prefix: "elb-log-prefix-#{add_random_string}",
      aws_elb_name: "elb-#{add_random_string}",
      aws_flow_log_bucket_name: "aws-flow-log-bucket-#{add_random_string}",
      aws_iam_user_name: "iam-user-#{add_random_string}",
      aws_iam_user_policy_name: "iam-user-policy-#{add_random_string}",
      aws_internet_gateway_name: 'inspec-aws-internet-gateway',
      aws_iam_group_name: "iam_group-#{add_random_string}",
      aws_key_description_disabled: 'InSpec KMS Key Test Disabled',
      aws_key_description_enabled: 'InSpec KMS Key Test Enabled',
      aws_rds_db_engine: 'mysql',
      aws_rds_db_engine_version: '5.6.37',
      aws_rds_db_identifier: "awsrds#{add_random_string}",
      aws_rds_db_master_user: 'awsinspecuser',
      aws_rds_db_name: "awsrdsname#{add_random_string}",
      aws_rds_db_storage_type: 'gp2',
      aws_security_group_alpha: "aws-security-group-alpha-#{add_random_string}",
      aws_security_group_beta: "aws-security-group-beta-#{add_random_string}",
      aws_security_group_gamma: "aws-security-group-gamma-#{add_random_string}",
      aws_security_group_omega: "aws-security-group-omega-#{add_random_string}",
      aws_sns_topic_no_subscription: "aws-sns-topic-no-subscription-#{add_random_string}",
      aws_sns_topic_subscription_sqs: "aws-sns-topic-subscription-sqs-#{add_random_string}",
      aws_sns_topic_with_subscription: "aws-sns-topic-subscription-#{add_random_string}",
      aws_subnet_ip_address_count: 16,
      aws_subnet_name: 'inspec-aws-subnet',
      aws_vm_image_filter: 'ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*',
      aws_vm_name: "aws-inspec-linux-ubuntu-#{add_random_string}",
      aws_vm_size: 't2.micro',
      aws_vpc_cidr_block: '10.0.0.0/27', # i.e. 32 IP addresses
      aws_vpc_instance_tenancy: 'dedicated',
      aws_vpc_name: 'inspec-aws-vpc',
      # Simple flag to disable creation of resources (useful when prototyping new ones in isolation)
      aws_enable_creation: 0,
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
      aws_enable_cli_calls: 0
  }

  def self.config
    @config
  end

  # This method ensures any environment variables take precedence.
  def self.update_from_environment
    @config.each { |k, v| @config[k] = ENV[k.to_s.upcase] || v }
  end

  # Create JSON for terraform
  def self.store_json(file_name = 'aws-inspec.tfvars')
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
