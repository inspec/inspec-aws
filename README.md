# InSpec for AWS

* **Project State: Maintained**

For more information on project states and SLAs, see [this documentation](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md).

This InSpec resource pack uses the AWS Ruby SDK v3 and provides the required resources to write tests for resources in AWS.

## Prerequisites

### AWS Credentials

Valid AWS credentials are required, see [AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)

There are multiple ways to set the AWS credentials, as shown below:

#### 1) Environment Variables

Set your AWS credentials in a `.envrc` file or export them in your shell. (See example [.envrc file](.envrc_example))

```bash
    # Example configuration
    export AWS_ACCESS_KEY_ID="AKIAJUMP347SLS66IGCQ"
    export AWS_SECRET_ACCESS_KEY="vD2lfoNvPdwsofqyuO9jRuWUkZIMqisdfeFmkHTy7ON+w"
    export AWS_REGION="eu-west-3"
    export AWS_AVAILABILITY_ZONE="eu-west-3a"  
```

#### 2) Configuration File

Set your AWS credentials in `~/.aws/config` and `~/.aws/credentials` file. (See example [aws configure credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html))

Example `~/.aws/credentials` :

   ```bash
      [default]
      aws_access_key_id=AKIAIOSFODNN7EXAMPLE
      aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
      
      [engineering]
      aws_access_key_id=AKIAIOSFODNN7EXAMPLF
      aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY1
   ```

Example `~/.aws/config` :

 ```bash
    [default]
    region=us-west-2
    
    [engineering]
    region=us-east-2
 ```

 AWS SDK selects the default credentials unless `aws_profile` is set in an `.envrc`.

 ```bash
     # Example configuration
     export AWS_PROFILE="engineering"
 ```

##### The credentials precedence is

   1. Credentials set in `.envrc` OR as an Environment variable.
   2. Credentials set in `~/.aws/credentials` AND `~/.aws/config` AND `AWS_PROFILE` set as an Environment variable.
   3. Credentials set in `~/.aws/credentials` AND `~/.aws/config` AND `AWS_PROFILE` is NOT set as an Environment variable. Default credentials are used.

### AWS Region

The `aws_region` parameter queries resources in a specific region. If not provided, the AWS region set in environment variables or configuration files are used.

Example:

```ruby
describe aws_ec2_instances(aws_region: 'us-west-2') do
  its('count') { should eq 10 }
end
```

### Assuming an IAM role

Assuming an IAM role allows an IAM users gain additional (or different) permissions to perform actions in a different AWS account. (See example [aws configure IAM role](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html))

Example:

```bash
   [profile example_profile]
   role_arn = arn:aws:iam::123456789012:role/example_profile
   source_profile = user1
```

### Permissions

Each resource requires specific permissions to perform the operations required for testing. For example, to test an AWS EC2 instance, your service principal requires the `ec2:DescribeInstances` and `iam:GetInstanceProfile` permissions. You can find a comprehensive list of each resource's permissions needed in the [documentation](docs/).

## Use the Resources

Since this is an InSpec resource pack, it defines the InSpec resources and includes example tests only. To use the AWS resources in your tests, do the following:

```bash
inspec init profile --platform aws my-profile
```

The above command generates a sample inspec.yml that depends on `master`.  We recommend this is pinned to a release of the resource pack as follows:

```yaml
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 4.6.9'
depends:
  - name: inspec-aws
    url: https://github.com/inspec/inspec-aws/archive/x.tar.gz
supports:
  - platform: aws
```

### Use the Resources

Since this is an InSpec resource pack, it only defines InSpec resources. To use these resources in your controls, create your profile:

#### Create a profile

```bash
inspec init profile --platform aws my-profile
```

The above command generates a sample inspec.yml that depends on `master`.  We recommend this is pinned to a release of the resource pack as follows.

Example `inspec.yml`:

```yaml
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 4.6.9'
depends:
 - name: inspec-aws
   url: https://github.com/inspec/inspec-aws/archive/x.tar.gz
supports:
 - platform: aws
```

(For available inspec-aws versions, see this list of [inspec-aws versions](https://github.com/inspec/inspec-aws/releases).)

If a resource is in local, change the `url` to `path`.

```yaml
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 4.6.9'
depends:
 - name: inspec-aws
   path: ../my-profile
supports:
 - platform: aws
```

(For available inspec-aws versions, see this list of [inspec-aws versions](https://github.com/inspec/inspec-aws/releases).)

Add some tests and run the profile via:

```bash
inspec exec my-profile -t aws://
```

## Resource documentation

This resource pack allows the testing of the following AWS resources. If a resource you wish to test is not listed, please feel free to open an [Issue](https://github.com/inspec/inspec-aws/issues). As an open-source project, we also welcome public contributions via [Pull Request](https://github.com/inspec/inspec-aws/pulls).

InSpec AWS Supported Resources [https://docs.chef.io/inspec/resources/](https://docs.chef.io/inspec/resources/)

| Module Name | Services | Resource & Property Reference | Singular Resource | Plural Resource |
| --- | --- | --- | --- | --- |
| AmazonMQ | Application Integration | [AWS::AmazonMQ::Broker](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-broker.html) | [aws_mq_broker](docs/resources/aws_mq_broker.md) | [aws_mq_brokers](docs/resources/aws_mq_brokers.md) |
|  |  | [AWS::AmazonMQ::Configuration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amazonmq-configuration.html) | [aws_mq_configuration](docs/resources/aws_mq_configuration.md) | [aws_mq_configurations](docs/resources/aws_mq_configurations.md) |
| Amplify Console | Front-end Web & Mobile | [AWS::Amplify::App](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amplify-app.html) | [aws_amplify_app](docs/resources/aws_amplify_app.md) | [aws_amplify_apps](docs/resources/aws_amplify_apps.md) |
|  |  | [AWS::Amplify::Branch](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-amplify-branch.html) | [aws_amplify_branch](docs/resources/aws_amplify_branch.md) | [aws_amplify_branches](docs/resources/aws_amplify_branches.md) |
| API Gateway | Networking & Content Delivery | [AWS::ApiGateway::Account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-account.html) | [aws_apigateway_account](docs/resources/aws_apigateway_account.md) | No Plural Resource |
|  |  | [AWS::ApiGateway::ApiKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-apikey.html) | [aws_apigateway_api_key](docs/resources/aws_apigateway_api_key.md) | [aws_apigateway_api_keys](docs/resources/aws_apigateway_api_keys.md) |
|  |  | [AWS::ApiGateway::Authorizer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-authorizer.html) | [aws_apigateway_authorizer](docs/resources/aws_apigateway_authorizer.md) | [aws_apigateway_authorizers](docs/resources/aws_apigateway_authorizers.md) |
|  |  | [AWS::ApiGateway::BasePathMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html) | [aws_apigateway_base_path_mapping](docs/resources/aws_apigateway_base_path_mapping.md) | [aws_apigateway_base_path_mappings](docs/resources/aws_apigateway_base_path_mappings.md) |
|  |  | [AWS::ApiGateway::ClientCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-clientcertificate.html) | [aws_apigateway_client_certificate](docs/resources/aws_apigateway_client_certificate.md) | [aws_apigateway_client_certificates](docs/resources/aws_apigateway_client_certificates.md) |
|  |  | [AWS::ApiGateway::Deployment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-deployment.html) | [aws_api_gateway_deployment](docs/resources/aws_api_gateway_deployment.md) | [aws_api_gateway_deployments](docs/resources/aws_api_gateway_deployments.md) |
|  |  | [AWS::ApiGateway::Method](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-method.html) | [aws_api_gateway_method](docs/resources/aws_api_gateway_method.md) | [aws_api_gateway_methods](docs/resources/aws_api_gateway_methods.md) |
|  |  | [AWS::ApiGateway::RestApi](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-restapi.html) | [aws_api_gateway_restapi](docs/resources/aws_api_gateway_restapi.md) | [aws_api_gateway_restapis](docs/resources/aws_api_gateway_restapis.md) |
|  |  | [AWS::ApiGateway::Stage](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html) | [aws_api_gateway_stage](docs/resources/aws_api_gateway_stage.md) | [aws_api_gateway_stages](docs/resources/aws_api_gateway_stages.md) |
|  |  | [AWS::ApiGateway::DocumentationPart](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationpart.html) | [aws_api_gateway_documentation_part](docs/resources/aws_api_gateway_documentation_part.md) | [aws_api_gateway_documentation_parts](docs/resources/aws_api_gateway_documentation_parts.md) |
|  |  | [AWS::ApiGateway::DocumentationVersion](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationversion.html) | [aws_api_gateway_documentation_version](docs/resources/aws_api_gateway_documentation_version.md) | [aws_api_gateway_documentation_versions](docs/resources/aws_api_gateway_documentation_versions.md) |
| Application Auto Scaling | Compute | [AWS::ApplicationAutoScaling::ScalableTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalabletarget.html) | [aws_application_autoscaling_scalable_target](docs/resources/aws_application_autoscaling_scalable_target.md) | [aws_application_autoscaling_scalable_targets](docs/resources/aws_application_autoscaling_scalable_targets.md) |
|  |  | [AWS::ApplicationAutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html) | [aws_application_autoscaling_scaling_policy](docs/resources/aws_application_autoscaling_scaling_policy.md) | [aws_application_autoscaling_scaling_policies](docs/resources/aws_application_autoscaling_scaling_policies.md) |
| Athena | Analytics | [AWS::Athena::WorkGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html) | [aws_athena_work_group](docs/resources/aws_athena_work_group.md) | [aws_athena_work_groups](docs/resources/aws_athena_work_groups.md) |
| Amazon EC2 Auto Scaling | Compute | [AWS::AutoScaling::AutoScalingGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-group.html) | [aws_auto_scaling_group](docs/resources/aws_auto_scaling_group.md) | [aws_auto_scaling_groups](docs/resources/aws_auto_scaling_groups.md) |
|  |  | [AWS::AutoScaling::LaunchConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-launchconfig.html) | [aws_launch_configuration](docs/resources/aws_launch_configuration.md) | No Plural Resource |
|  |  | [AWS::AutoScaling::ScalingPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html) | [aws_autoscaling_scaling_policy](docs/resources/aws_autoscaling_scaling_policy.md) | [aws_autoscaling_scaling_policies](docs/resources/aws_autoscaling_scaling_policies.md) |
| AWS Batch | Compute | [AWS::Batch::ComputeEnvironment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-computeenvironment.html) | [aws_batch_compute_environment](docs/resources/aws_batch_compute_environment.md) | [aws_batch_compute_environments](docs/resources/aws_batch_compute_environments.md) |
|  |  | [AWS::Batch::JobDefinition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html) | [aws_batch_job_definition](docs/resources/aws_batch_job_definition.md) | [aws_batch_job_definitions](docs/resources/aws_batch_job_definitions.md) |
|  |  | [AWS::Batch::JobQueue](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobqueue.html) | [aws_batch_job_queue](docs/resources/aws_batch_job_queue.md) | [aws_batch_job_queues](docs/resources/aws_batch_job_queues.md) |
| CloudFormation | Management & Governance | [AWS::CloudFormation::Stack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-stack.html) | [aws_cloudformation_stack](docs/resources/aws_cloudformation_stack.md) | [aws_cloudformation_stacks](docs/resources/aws_cloudformation_stacks.md) |
|  |  | [AWS::CloudFormation::StackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stackset.html) | [aws_cloud_formation_stack_set](docs/resources/aws_cloud_formation_stack_set.md) | [aws_cloud_formation_stack_sets](docs/resources/aws_cloud_formation_stack_sets.md) |
|  |  | Others | [aws_cloudformation_template](docs/resources/aws_cloudformation_template.md) | No Plural Resource |
| CloudFront | Networking & Content Delivery | [AWS::CloudFront::CachePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cachepolicy.html) | [aws_cloudfront_cache_policy](docs/resources/aws_cloudfront_cache_policy.md) | [aws_cloudfront_cache_policies](docs/resources/aws_cloudfront_cache_policies.md) |
|  |  | [AWS::CloudFront::CloudFrontOriginAccessIdentity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cloudfrontoriginaccessidentity.html) | [aws_cloudfront_origin_access_identity](docs/resources/aws_cloudfront_origin_access_identity.md) | [aws_cloudfront_origin_access_identities](docs/resources/aws_cloudfront_origin_access_identities.md) |
|  |  | [AWS::CloudFront::Distribution](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html) | [aws_cloudfront_distribution](docs/resources/aws_cloudfront_distribution.md) | [aws_cloudfront_distributions](docs/resources/aws_cloudfront_distributions.md) |
|  |  | [AWS::CloudFront::KeyGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-keygroup.html) | [aws_cloudfront_key_group](docs/resources/aws_cloudfront_key_group.md) | [aws_cloudfront_key_groups](docs/resources/aws_cloudfront_key_groups.md) |
|  |  | [AWS::CloudFront::OriginRequestPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-originrequestpolicy.html) | [aws_cloud_front_origin_request_policy](docs/resources/aws_cloud_front_origin_request_policy.md) | No Plural Resource |
|  |  | [AWS::CloudFront::PublicKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-publickey.html) | [aws_cloudfront_public_key](docs/resources/aws_cloudfront_public_key.md) | [aws_cloudfront_public_keys](docs/resources/aws_cloudfront_public_keys.md) |
|  |  | [AWS::CloudFront::RealtimeLogConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html) | [aws_cloudfront_realtime_log_config](docs/resources/aws_cloudfront_realtime_log_config.md) | [aws_cloudfront_realtime_log_configs](docs/resources/aws_cloudfront_realtime_log_configs.md) |
|  |  | [AWS::CloudFront::StreamingDistribution](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-streamingdistribution.html) | [aws_cloudfront_streaming_distribution](docs/resources/aws_cloudfront_streaming_distribution.md) | [aws_cloudfront_streaming_distributions](docs/resources/aws_cloudfront_streaming_distributions.md) |
| CloudTrail | Management & Governance | [AWS::CloudTrail::Trail](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudtrail-trail.html) | [aws_cloudtrail_trail](docs/resources/aws_cloudtrail_trail.md) | [aws_cloudtrail_trails](docs/resources/aws_cloudtrail_trails.md) |
| CloudWatch | Management & Governance | [AWS::CloudWatch::Alarm](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cw-alarm.html) | [aws_cloudwatch_alarm](docs/resources/aws_cloudwatch_alarm.md) | No Plural Resource |
|  |  | [AWS::CloudWatch::AnomalyDetector](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-anomalydetector.html) | [aws_cloudwatch_anomaly_detector](docs/resources/aws_cloudwatch_anomaly_detector.md) | [aws_cloudwatch_anomaly_detectors](docs/resources/aws_cloudwatch_anomaly_detectors.md) |
|  |  | [AWS::CloudWatch::CompositeAlarm](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-compositealarm.html) | [aws_cloudwatch_composite_alarm](docs/resources/aws_cloudwatch_composite_alarm.md) | [aws_cloudwatch_composite_alarms](docs/resources/aws_cloudwatch_composite_alarms.md) |
|  |  | [AWS::CloudWatch::Dashboard](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-dashboard.html) | [aws_cloudwatch_dashboard](docs/resources/aws_cloudwatch_dashboard.md) | [aws_cloudwatch_dashboards](docs/resources/aws_cloudwatch_dashboards.md) |
|  |  | [AWS::CloudWatch::InsightRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-insightrule.html) | No Singular Resource | [aws_cloudwatch_insight_rules](docs/resources/aws_cloudwatch_insight_rules.md) |
|  |  | [AWS::CloudWatch::MetricStream](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-metricstream.html) | [aws_cloudwatch_metric_stream](docs/resources/aws_cloudwatch_metric_stream.md) | [aws_cloudwatch_metric_streams](docs/resources/aws_cloudwatch_metric_streams.md) |
| CloudWatch Logs | Management & Governance | [AWS::Logs::Destination](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html) | [aws_cloudwatchlogs_destination](docs/resources/aws_cloudwatchlogs_destination.md) | [aws_cloudwatchlogs_destinations](docs/resources/aws_cloudwatchlogs_destinations.md) |
|  |  | [AWS::Logs::LogGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html) | [aws_cloudwatch_log_group](docs/resources/aws_cloudwatch_log_group.md) | No Plural Resource |
|  |  | [AWS::Logs::LogStream](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-logstream.html) | [aws_cloudwatchlogs_log_stream](docs/resources/aws_cloudwatchlogs_log_stream.md) | [aws_cloudwatchlogs_log_streams](docs/resources/aws_cloudwatchlogs_log_streams.md) |
|  |  | [AWS::Logs::MetricFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-metricfilter.html) | [aws_cloudwatch_log_metric_filter](docs/resources/aws_cloudwatch_log_metric_filter.md) | No Plural Resource |
|  |  |  | [aws_logs_metric_filter](docs/resources/aws_logs_metric_filter.md) | [aws_logs_metric_filters](docs/resources/aws_logs_metric_filters.md) |
|  |  | [AWS::Logs::SubscriptionFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-subscriptionfilter.html) | [aws_cloudwatchlogs_subscription_filter](docs/resources/aws_cloudwatchlogs_subscription_filter.md) | [aws_cloudwatchlogs_subscription_filters](docs/resources/aws_cloudwatchlogs_subscription_filters.md) |
| Amazon Cognito | Security, Identity, & Compliance | [AWS::Cognito::IdentityPool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-identitypool.html) | [aws_cognito_identity_pool](docs/resources/aws_cognito_identity_pool.md) | [aws_cognito_identity_pools](docs/resources/aws_cognito_identity_pools.md) |
|  |  | [AWS::Cognito::UserPool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html) | [aws_cognito_userpool](docs/resources/aws_cognito_userpool.md) | [aws_cognito_userpools](docs/resources/aws_cognito_userpools.md) |
|  |  | [AWS::Cognito::UserPoolClient](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpoolclient.html) | [aws_cognito_userpool_client](docs/resources/aws_cognito_userpool_client.md) | [aws_cognito_userpool_clients](docs/resources/aws_cognito_userpool_clients.md) |
| Config | Management & Governance  | [AWS::Config::ConfigurationRecorder](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-configurationrecorder.html) | [aws_config_recorder](docs/resources/aws_config_recorder.md) | No Plural Resource |
|  |   | [AWS::Config::DeliveryChannel](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-deliverychannel.html) | [aws_config_delivery_channel](docs/resources/aws_config_delivery_channel.md) | No Plural Resource |
| DMS | Compute | [AWS::DMS::Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html) | [aws_dms_endpoint](docs/resources/aws_dms_endpoint.md) | [aws_dms_endpoints](docs/resources/aws_dms_endpoints.md) |
|  |  | [AWS::DMS::ReplicationInstance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationinstance.html) | [aws_dms_replication_instance](docs/resources/aws_dms_replication_instance.md) | [aws_dms_replication_instances](docs/resources/aws_dms_replication_instances.md) |
|  |  | [AWS::DMS::ReplicationSubnetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html) | [aws_dms_replication_subnet_group](docs/resources/aws_dms_replication_subnet_group.md) | [aws_dms_replication_subnet_groups](docs/resources/aws_dms_replication_subnet_groups.md) |
| DynamoDB | Database | [AWS::DynamoDB::Table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html) | [aws_dynamodb_table](docs/resources/aws_dynamodb_table.md) | [aws_dynamodb_tables](docs/resources/aws_dynamodb_tables.md) |
| EC2 | Compute | [AWS::EC2::CapacityReservation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-capacityreservation.html) | [aws_ec2_capacity_reservation](docs/resources/aws_ec2_capacity_reservation.md) | [aws_ec2_capacity_reservations](docs/resources/aws_ec2_capacity_reservations.md) |
|  |  | [AWS::EC2::CarrierGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-carriergateway.html) | [aws_ec2_carrier_gateway](docs/resources/aws_ec2_carrier_gateway.md) | [aws_ec2_carrier_gateways](docs/resources/aws_ec2_carrier_gateways.md) |
|  |  | [AWS::EC2::CustomerGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html) | [aws_ec2_customer_gateway](docs/resources/aws_ec2_customer_gateway.md) | [aws_ec2_customer_gateways](docs/resources/aws_ec2_customer_gateways.md) |
|  |  | [AWS::EC2::DHCPOptions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-dhcpoptions.html) | No Singular Resource | [aws_dhcp_options](docs/resources/aws_dhcp_options.md) |
|  |  |  | [aws_ec2_dhcp_option](docs/resources/aws_ec2_dhcp_option.md) | [aws_ec2_dhcp_options](docs/resources/aws_ec2_dhcp_options.md) |
|  |  | [AWS::EC2::Fleet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-ec2fleet.html) | [aws_ec2_fleet](docs/resources/aws_ec2_fleet.md) | [aws_ec2_fleets](docs/resources/aws_ec2_fleets.md) |
|  |  | [AWS::EC2::EgressOnlyInternetGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-egressonlyinternetgateway.html) | [aws_ec2_egress_only_internet_gateway](docs/resources/aws_ec2_egress_only_internet_gateway.md) | [aws_ec2_egress_only_internet_gateways](docs/resources/aws_ec2_egress_only_internet_gateways.md) |
|  |  | [AWS::EC2::EIP](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html) | [aws_ec2_eip](docs/resources/aws_ec2_eip.md) | [aws_ec2_eips](docs/resources/aws_ec2_eips.md) |
|  |  | [AWS::EC2::EIPAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip-association.html) | [aws_ec2_eip_association](docs/resources/aws_ec2_eip_association.md) | [aws_ec2_eip_associations](docs/resources/aws_ec2_eip_associations.md) |
|  |  | [AWS::EC2::FlowLog](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-flowlog.html) | [aws_flow_log](docs/resources/aws_flow_log.md) | No Plural Resource |
|  |  | [AWS::EC2::Host](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-host.html) | [aws_ec2_host](docs/resources/aws_ec2_host.md) | [aws_ec2_hosts](docs/resources/aws_ec2_hosts.md) |
|  |  | [AWS::EC2::Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-instance.html) | [aws_ec2_instance](docs/resources/aws_ec2_instance.md) | [aws_ec2_instances](docs/resources/aws_ec2_instances.md) |
|  |  | [AWS::EC2::InternetGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html) | [aws_ec2_internet_gateway](docs/resources/aws_ec2_internet_gateway.md) | [aws_ec2_internet_gateways](docs/resources/aws_ec2_internet_gateways.md) |
|  |  |  | [aws_internet_gateway](docs/resources/aws_internet_gateway.md) | [aws_internet_gateways](docs/resources/aws_internet_gateways.md) |
|  |  | [AWS::EC2::LaunchTemplate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html) | [aws_ec2_launch_template](docs/resources/aws_ec2_launch_template.md) | [aws_ec2_launch_templates](docs/resources/aws_ec2_launch_templates.md) |
|  |  | [AWS::EC2::NatGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-natgateway.html) | [aws_nat_gateway](docs/resources/aws_nat_gateway.md) | [aws_nat_gateways](docs/resources/aws_nat_gateways.md) |
|  |  | [AWS::EC2::NetworkAcl](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-acl.html) | [aws_network_acl](docs/resources/aws_network_acl.md) | [aws_network_acls](docs/resources/aws_network_acls.md) |
|  |  | [AWS::EC2::NetworkAclEntry](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-acl-entry.html) | [aws_network_acl](docs/resources/aws_network_acl.md) | [aws_network_acls](docs/resources/aws_network_acls.md) |
|  |  | [AWS::EC2::NetworkInsightsAnalysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html) | [aws_ec2_network_insights_analysis](docs/resources/aws_ec2_network_insights_analysis.md) | [aws_ec2_network_insights_analysis_plural](docs/resources/aws_ec2_network_insights_analysis_plural.md) |
|  |  | [AWS::EC2::NetworkInsightsPath](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html) | [aws_ec2_network_insights_path](docs/resources/aws_ec2_network_insights_path.md) | [aws_ec2_network_insights_paths](docs/resources/aws_ec2_network_insights_paths.md) |
|  |  | [AWS::EC2::NetworkInterface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface.html) | [aws_ec2_network_interface](docs/resources/aws_ec2_network_interface.md) | [aws_ec2_network_interfaces](docs/resources/aws_ec2_network_interfaces.md) |
|  |  | [AWS::EC2::NetworkInterfaceAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface-attachment.html) | [aws_ec2_network_interface_attachment](docs/resources/aws_ec2_network_interface_attachment.md) | [aws_ec2_network_interface_attachments](docs/resources/aws_ec2_network_interface_attachments.md) |
|  |  | [AWS::EC2::NetworkInterfacePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission.html) | [aws_ec2_network_interface_permission](docs/resources/aws_ec2_network_interface_permission.md) | [aws_ec2_network_interface_permission](docs/resources/aws_ec2_network_interface_permissions.md) |
|  |  | [AWS::EC2::PlacementGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html) | [aws_ec2_placement_group](docs/resources/aws_ec2_placement_group.md) | [aws_ec2_placement_groups](docs/resources/aws_ec2_placement_groups.md) |
|  |  | [AWS::EC2::PrefixList](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-prefixlist.html) | [aws_ec2_prefix_list](docs/resources/aws_ec2_prefix_list.md) | [aws_ec2_prefix_lists](docs/resources/aws_ec2_prefix_lists.md) |
|  |  | [AWS::EC2::Route](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route.html) | [aws_route_table](docs/resources/aws_route_table.md) | [aws_route_tables](docs/resources/aws_route_tables.md) |
|  |  | [AWS::EC2::RouteTable](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route-table.html) | [aws_route_table](docs/resources/aws_route_table.md) | [aws_route_tables](docs/resources/aws_route_tables.md) |
|  |  | [AWS::EC2::SecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html) | [aws_security_group](docs/resources/aws_security_group.md) | [aws_security_groups](docs/resources/aws_security_groups.md) |
|  |  | [AWS::EC2::SecurityGroupEgress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-security-group-egress.html) | [aws_security_group](docs/resources/aws_security_group.md) | [aws_security_groups](docs/resources/aws_security_groups.md) |
|  |  | [AWS::EC2::SecurityGroupIngress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group-ingress.html) | [aws_security_group](docs/resources/aws_security_group.md) | [aws_security_groups](docs/resources/aws_security_groups.md) |
|  |  | [AWS::EC2::SpotFleet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-spotfleet.html) | [aws_ec2_spot_fleet](docs/resources/aws_ec2_spot_fleet.md) | [aws_ec2_spot_fleets](docs/resources/aws_ec2_spot_fleets.md) |
|  |  | [AWS::EC2::Subnet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnet.html) | [aws_subnet](docs/resources/aws_subnet.md) | [aws_subnets](docs/resources/aws_subnets.md) |
|  |  | [AWS::EC2::TrafficMirrorFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-trafficmirrorfilter.html) | [aws_ec2_traffic_mirror_filter](docs/resources/aws_ec2_traffic_mirror_filter.md) | [aws_ec2_traffic_mirror_filters](docs/resources/aws_ec2_traffic_mirror_filters.md) |
|  |  | [AWS::EC2::TrafficMirrorSession](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-trafficmirrorsession.html) | [aws_ec2_traffic_mirror_session](docs/resources/aws_ec2_traffic_mirror_session.md) | [aws_ec2_traffic_mirror_sessions](docs/resources/aws_ec2_traffic_mirror_sessions.md) |
|  |  | [AWS::EC2::TrafficMirrorTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-trafficmirrortarget.html) | [aws_ec2_traffic_mirror_target](docs/resources/aws_ec2_traffic_mirror_target.md) | [aws_ec2_traffic_mirror_targets](docs/resources/aws_ec2_traffic_mirror_targets.md) |
|  |  | [AWS::EC2::TransitGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgateway.html) | [aws_transit_gateway](docs/resources/aws_transit_gateway.md) | No Plural Resource |
|  |  | [AWS::EC2::TransitGatewayAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayattachment.html) | [aws_ec2_transit_gateway_attachment](docs/resources/aws_ec2_transit_gateway_attachment.md) | [aws_ec2_transit_gateway_attachments](docs/resources/aws_ec2_transit_gateway_attachments.md) |
|  |  | [AWS::EC2::TransitGatewayConnect](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayconnect.html) | [aws_transit_gateway_connect](docs/resources/aws_transit_gateway_connect.md) | [aws_transit_gateway_connects](docs/resources/aws_transit_gateway_connects.md) |
|  |  | [AWS::EC2::TransitGatewayMulticastDomain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomain.html) | [aws_transit_gateway_multicast_domain](docs/resources/aws_transit_gateway_multicast_domain.md) | [aws_transit_gateway_multicast_domains](docs/resources/aws_transit_gateway_multicast_domains.md) |
|  |  | [AWS::EC2::TransitGatewayMulticastDomainAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomainassociation.html) | [aws_transit_gateway_multicast_domain_association](docs/resources/aws_transit_gateway_multicast_domain_association.md) | [aws_transit_gateway_multicast_domain_associations](docs/resources/aws_transit_gateway_multicast_domain_associations.md) |
|  |  | [AWS::EC2::TransitGatewayMulticastGroupMember](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupmember.html) | [aws_transit_gateway_multicast_group_member](docs/resources/aws_transit_gateway_multicast_group_member.md) | [aws_transit_gateway_multicast_group_members](docs/resources/aws_transit_gateway_multicast_group_members.md) |
|  |  | [AWS::EC2::TransitGatewayMulticastGroupSource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupsource.html) | [aws_transit_gateway_multicast_group_source](docs/resources/aws_transit_gateway_multicast_group_source.md) | [aws_transit_gateway_multicast_group_sources](docs/resources/aws_transit_gateway_multicast_group_sources.md) |
|  |  | [AWS::EC2::TransitGatewayRoute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroute.html) | [aws_transit_gateway_route](docs/resources/aws_transit_gateway_route.md) | [aws_transit_gateway_routes](docs/resources/aws_transit_gateway_routes.md) |
|  |  | [AWS::EC2::TransitGatewayRouteTable](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetable.html) | [aws_ec2_transit_gateway_route_table](docs/resources/aws_ec2_transit_gateway_route_table.md) | [aws_ec2_transit_gateway_route_tables](docs/resources/aws_ec2_transit_gateway_route_tables.md) |
|  |  | [AWS::EC2::TransitGatewayRouteTableAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html) | [aws_ec2_transit_gateway_route_table_association](docs/resources/aws_ec2_transit_gateway_route_table_association.md) | [aws_ec2_transit_gateway_route_table_associations](docs/resources/aws_ec2_transit_gateway_route_table_associations.md) |
|  |  | [AWS::EC2::TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html) | [aws_ec2_transit_gateway_route_table_propagation](docs/resources/aws_ec2_transit_gateway_route_table_propagation.md) | [aws_ec2_transit_gateway_route_table_propagations](docs/resources/aws_ec2_transit_gateway_route_table_propagations.md) |
|  |  | [AWS::EC2::Volume](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volume.html) | [aws_ebs_volume](docs/resources/aws_ebs_volume.md) | [aws_ebs_volumes](docs/resources/aws_ebs_volumes.md) |
|  |  | [AWS::EC2::VolumeAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volumeattachment.html) | No Singular Resource | [aws_ec2_volume_attachments](docs/resources/aws_ec2_volume_attachments.md) |
|  |  | [AWS::EC2::VPC](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpc.html) | [aws_vpc](docs/resources/aws_vpc.md) | [aws_vpcs](docs/resources/aws_vpcs.md) |
|  |  | [AWS::EC2::VPCEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpoint.html) | [aws_vpc_endpoint](docs/resources/aws_vpc_endpoint.md) | [aws_vpc_endpoints](docs/resources/aws_vpc_endpoints.md) |
|  |  | [AWS::EC2::VPCEndpointConnectionNotification](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointconnectionnotification.html) | [aws_vpc_endpoint_connection_notification](docs/resources/aws_vpc_endpoint_connection_notification.md) | [aws_vpc_endpoint_connection_notifications](docs/resources/aws_vpc_endpoint_connection_notifications.md) |
|  |  |  | [aws_vpc_endpoint_notification](docs/resources/aws_vpc_endpoint_notification.md) | [aws_vpc_endpoint_notifications](docs/resources/aws_vpc_endpoint_notifications.md) |
|  |  | [AWS::EC2::VPCEndpointService](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointservice.html) | [aws_vpc_endpoint_service](docs/resources/aws_vpc_endpoint_service.md) | [aws_vpc_endpoint_services](docs/resources/aws_vpc_endpoint_services.md) |
|  |  | [AWS::EC2::VPCEndpointServicePermissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointservicepermissions.html) | [aws_vpc_endpoint_service_permission](docs/resources/aws_vpc_endpoint_service_permission.md) | [aws_vpc_endpoint_service_permissions](docs/resources/aws_vpc_endpoint_service_permissions.md) |
|  |  | [AWS::EC2::VPCPeeringConnection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html) | [aws_ec2_vpc_peering_connection](docs/resources/aws_ec2_vpc_peering_connection.md) | [aws_ec2_vpc_peering_connections](docs/resources/aws_ec2_vpc_peering_connections.md) |
|  |  | [AWS::EC2::VPNConnection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection.html) | No Singular Resource | [aws_vpn_connections](docs/resources/aws_vpn_connections.md) |
|  |  | [AWS::EC2::VPNConnectionRoute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection-route.html) | No Singular Resource | [aws_ec2_vpn_connection_routes](docs/resources/aws_ec2_vpn_connection_routes.md) |
|  |  | [AWS::EC2::VPNGateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gateway.html) | [aws_vpn_gateway](docs/resources/aws_vpn_gateway.md) | [aws_vpn_gateways](docs/resources/aws_vpn_gateways.md) |
|  |  | [AWS::EC2::VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html) | [aws_ec2_vpn_gateway_route_propagation](docs/resources/aws_ec2_vpn_gateway_route_propagation.md) | [aws_ec2_vpn_gateway_route_propagations](docs/resources/aws_ec2_vpn_gateway_route_propagations.md) |
|  |  | Others | [aws_region](docs/resources/aws_region.md) | [aws_regions](docs/resources/aws_regions.md) |
|  |  |  | [aws_ebs_snapshot](docs/resources/aws_ebs_snapshot.md) | [aws_ebs_snapshots](docs/resources/aws_ebs_snapshots.md) |
|  |  |  | [aws_ami](docs/resources/aws_ami.md) | [aws_amis](docs/resources/aws_amis.md) |
| Amazon ECR | Containers | [AWS::ECR::PublicRepository](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-publicrepository.html) | [aws_ecrpublic_repository](docs/resources/aws_ecrpublic_repository.md) | [aws_ecrpublic_repositories](docs/resources/aws_ecrpublic_repositories.md) | |
|  |  | [AWS::ECR::Repository](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html) | [aws_ecr_repository](docs/resources/aws_ecr_repository.md) | [aws_ecr_repositories](docs/resources/aws_ecr_repositories.md) |
| Amazon ECS | Containers | [AWS::ECS::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-cluster.html) | [aws_ecs_cluster](docs/resources/aws_ecs_cluster.md) | [aws_ecs_clusters](docs/resources/aws_ecs_clusters.md) |
|  |  | [AWS::ECS::Service](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html) | [aws_ecs_service](docs/resources/aws_ecs_service.md) | [aws_ecs_services](docs/resources/aws_ecs_services.md) |
|  |  | [AWS::ECS::TaskDefinition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html) | [aws_ecs_task_definition](docs/resources/aws_ecs_task_definition.md) | [aws_ecs_task_definitions](docs/resources/aws_ecs_task_definitions.md) |
|  |  | Others | [aws_ecr_repository_policy](docs/resources/aws_ecr_repository_policy.md) | No Plural Resource |
|  |  |  | [aws_ecr](docs/resources/aws_ecr.md) | No Plural Resource |
|  |  |  | [aws_ecr_image](docs/resources/aws_ecr_image.md) | [aws_ecr_images](docs/resources/aws_ecr_images.md) |
| EFS | Storage | [AWS::EFS::FileSystem](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-filesystem.html) | [aws_efs_file_system](docs/resources/aws_efs_file_system.md) | [aws_efs_file_systems](docs/resources/aws_efs_file_systems.md) |
|  |  | [AWS::EFS::MountTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget.html) | [aws_efs_mount_target](docs/resources/aws_efs_mount_target.md) | [aws_efs_mount_targets](docs/resources/aws_efs_mount_targets.md) |
| EKS | Containers | [AWS::EKS::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-eks-cluster.html) | [aws_eks_cluster](docs/resources/aws_eks_cluster.md) | [aws_eks_clusters](docs/resources/aws_eks_clusters.md)
| ElasticCache | Database | [AWS::ElastiCache::CacheCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticache-cache-cluster.html) | [aws_elasticache_cluster](docs/resources/aws_elasticache_cluster.md) | [aws_elasticache_clusters](docs/resources/aws_elasticache_clusters.md) |
|  |  | [AWS::ElastiCache::ReplicationGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticache-replicationgroup.html) | [aws_elasticache_replication_group](docs/resources/aws_elasticache_replication_group.md) | [aws_elasticache_replication_groups](docs/resources/aws_elasticache_replication_groups.md) |
|  |  |  | [aws_elasticache_cluster_node](docs/resources/aws_elasticache_cluster_node.md) | No Plural Resource |
| Elasticsearch | Analytics | [AWS::Elasticsearch::Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html) | [aws_elasticsearchservice_domain](docs/resources/aws_elasticsearchservice_domain.md) | [aws_elasticsearchservice_domains](docs/resources/aws_elasticsearchservice_domains.md) |
| ElasticLoadBalancingV2 | Networking & Content Delivery | [AWS::ElasticLoadBalancingV2::Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html) | [aws_elasticloadbalancingv2_listener](docs/resources/aws_elasticloadbalancingv2_listener.md) | [aws_elasticloadbalancingv2_listeners](docs/resources/aws_elasticloadbalancingv2_listeners.md) |
|  |  | [AWS::ElasticLoadBalancingV2::ListenerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenercertificate.html) | [aws_elasticloadbalancingv2_listener_certificate](docs/resources/aws_elasticloadbalancingv2_listener_certificate.md) | [aws_elasticloadbalancingv2_listener_certificates](docs/resources/aws_elasticloadbalancingv2_listener_certificates.md) |
|  |  | [AWS::ElasticLoadBalancingV2::ListenerRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html) | [aws_elasticloadbalancingv2_listener_rule](docs/resources/aws_elasticloadbalancingv2_listener_rule.md) | [aws_elasticloadbalancingv2_listener_rules](docs/resources/aws_elasticloadbalancingv2_listener_rules.md) |
|  |  | [AWS::ElasticLoadBalancingV2::LoadBalancer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-loadbalancer.html) | [aws_elb](docs/resources/aws_elb.md) | [aws_elbs](docs/resources/aws_elbs.md) |
|  |  |  | [aws_alb](docs/resources/aws_alb.md) | [aws_albs](docs/resources/aws_albs.md) |
|  |  | [AWS::ElasticLoadBalancingV2::TargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-targetgroup.html) | [aws_elasticloadbalancingv2_target_group](docs/resources/aws_elasticloadbalancingv2_target_group.md) | [aws_elasticloadbalancingv2_target_groups](docs/resources/aws_elasticloadbalancingv2_target_groups.md) |
| Amazon EMR | Analytics  | [AWS::EMR::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticmapreduce-cluster.html) | [aws_emr_cluster](docs/resources/aws_emr_cluster.md) | [aws_emr_clusters](docs/resources/aws_emr_clusters.md) |
|  |  | [AWS::EMR::SecurityConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-emr-securityconfiguration.html) | [aws_emr_security_configuration](docs/resources/aws_emr_security_configuration.md) | [aws_emr_security_configurations](docs/resources/aws_emr_security_configurations.md) |
| Amazon EventBridge | Application Integration  | [AWS::Events::Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule.html) | [aws_eventbridge_rule](docs/resources/aws_eventbridge_rule.md) | [aws_eventbridge_rules](docs/resources/aws_eventbridge_rules.md) |
| AWS Glue | Analytics | [AWS::Glue::Crawler](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-crawler.html) | [aws_glue_crawler](docs/resources/aws_glue_crawler.md) | [aws_glue_crawlers](docs/resources/aws_glue_crawlers.md) |
|  |  | [AWS::Glue::Database](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-database.html) | [aws_glue_database](docs/resources/aws_glue_database.md) | [aws_glue_databases](docs/resources/aws_glue_databases.md) |
| GuardDuty | Security, Identity, & Compliance | [AWS::GuardDuty::Detector](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-guardduty-detector.html) | [aws_guardduty_detector](docs/resources/aws_guardduty_detector.md) | [aws_guardduty_detectors](docs/resources/aws_guardduty_detectors.md) |
| IAM | Security, Identity, & Compliance | [AWS::IAM::AccessKey](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html) | [aws_iam_access_key](docs/resources/aws_iam_access_key.md) | [aws_iam_access_keys](docs/resources/aws_iam_access_keys.md) |
|  |  |  | No Singular Resource | [aws_iam_account_alias](docs/resources/aws_iam_account_alias.md) |
|  |  |  | [aws_iam_ssh_public_key](docs/resources/aws_iam_ssh_public_key.md) | [aws_iam_ssh_public_keys](docs/resources/aws_iam_ssh_public_keys.md) |
|  |  | [AWS::IAM::Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html) | [aws_iam_group](docs/resources/aws_iam_group.md) | [aws_iam_groups](docs/resources/aws_iam_groups.md) |
|  |  | [AWS::IAM::InstanceProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html) | [aws_iam_instance_profile](docs/resources/aws_iam_instance_profile.md) | [aws_iam_instance_profiles](docs/resources/aws_iam_instance_profiles.md) |
|  |  | [AWS::IAM::ManagedPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html) | [aws_iam_managed_policy](docs/resources/aws_iam_managed_policy.md) | [aws_iam_managed_policies](docs/resources/aws_iam_managed_policies.md) |
|  |  | [AWS::IAM::OIDCProvider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-oidcprovider.html) | [aws_iam_oidc_provider](docs/resources/aws_iam_oidc_provider.md) | [aws_iam_oidc_providers](docs/resources/aws_iam_oidc_providers.md) |
|  |  | [AWS::IAM::Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-policy.html) | [aws_iam_policy](docs/resources/aws_iam_policy.md) | [aws_iam_policies](docs/resources/aws_iam_policies.md) |
|  |  |  | [aws_iam_password_policy](docs/resources/aws_iam_password_policy.md) | No Plural Resource |
|  |  |  | [aws_iam_inline_policy](docs/resources/aws_iam_inline_policy.md) | No Plural Resource |
|  |  | [AWS::IAM::Role](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html) | [aws_iam_role](docs/resources/aws_iam_role.md) | [aws_iam_roles](docs/resources/aws_iam_roles.md) |
|  |  | [AWS::IAM::SAMLProvider](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-samlprovider.html) | [aws_iam_saml_provider](docs/resources/aws_iam_saml_provider.md) | [aws_iam_saml_providers](docs/resources/aws_iam_saml_providers.md) |
|  |  | [AWS::IAM::ServerCertificate](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servercertificate.html) | [aws_iam_server_certificate](docs/resources/aws_iam_server_certificate.md) | [aws_iam_server_certificates](docs/resources/aws_iam_server_certificates.md) |
|  |  | [AWS::IAM::ServiceLinkedRole](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servicelinkedrole.html) | [aws_iam_service_linked_role_deletion_status](docs/resources/aws_iam_service_linked_role_deletion_status.md) | No Plural Resource |
|  |  | [AWS::IAM::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-user.html) | [aws_iam_user](docs/resources/aws_iam_user.md) | [aws_iam_users](docs/resources/aws_iam_users.md) |
|  |  |  | [aws_iam_root_user](docs/resources/aws_iam_root_user.md) | No Plural Resource |
|  |  | [AWS::IAM::VirtualMFADevice](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-virtualmfadevice.html) | No Singular Resource | [aws_iam_virtual_mfa_devices](docs/resources/aws_iam_virtual_mfa_devices.md) |
|  |  | Others | [aws_iam_ssh_public_key](docs/resources/aws_iam_ssh_public_key.md) | [aws_iam_ssh_public_keys](docs/resources/aws_iam_ssh_public_keys.md) |
| KMS | Security, Identity, & Compliance | [AWS::KMS::Key](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-key.html) | [aws_kms_key](docs/resources/aws_kms_key.md) | [aws_kms_keys](docs/resources/aws_kms_keys.md) |
| Lambda | Compute | [AWS::Lambda::Alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-alias.html) | [aws_lambda_alias](docs/resources/aws_lambda_alias.md) | [aws_lambda_aliases](docs/resources/aws_lambda_aliases.md) |
|  |  | [AWS::Lambda::CodeSigningConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-codesigningconfig.html) | [aws_lambda_code_signing_config](docs/resources/aws_lambda_code_signing_config.md) | [aws_lambda_code_signing_configs](docs/resources/aws_lambda_code_signing_configs.md) |
|  |  | [AWS::Lambda::EventInvokeConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventinvokeconfig.html) | [aws_lambda_event_invoke_config](docs/resources/aws_lambda_event_invoke_config.md) | [aws_lambda_event_invoke_configs](docs/resources/aws_lambda_event_invoke_configs.md) |
|  |  | [AWS::Lambda::EventSourceMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventsourcemapping.html) | [aws_lambda_event_source_mapping](docs/resources/aws_lambda_event_source_mapping.md) | [aws_lambda_event_source_mappings](docs/resources/aws_lambda_event_source_mappings.md) |
|  |  | [AWS::Lambda::Function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html) | [aws_lambda](docs/resources/aws_lambda.md) | [aws_lambdas](docs/resources/aws_lambdas.md) |
|  |  | [AWS::Lambda::LayerVersionPermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-layerversionpermission.html) | [aws_lambda_layer_version_permission](docs/resources/aws_lambda_layer_version_permission.md) | No Plural Resource |
|  |  | [AWS::Lambda::Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html) | [aws_lambda_permission](docs/resources/aws_lambda_permission.md) | [aws_lambda_permissions](docs/resources/aws_lambda_permissions.md) |
|  |  | [AWS::Lambda::Version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-version.html) | [aws_lambda_version](docs/resources/aws_lambda_version.md) | [aws_lambda_versions](docs/resources/aws_lambda_versions.md) |
| Network Firewall | Security, Identity, & Compliance | [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html) | [aws_network_firewall_firewall](docs/resources/aws_network_firewall_firewall.md) | [aws_network_firewall_firewalls](docs/resources/aws_network_firewall_firewalls.md) |
|  |  | [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) | [aws_network_firewall_firewall_policy](docs/resources/aws_network_firewall_firewall_policy.md) | [aws_network_firewall_firewall_policies](docs/resources/aws_network_firewall_firewall_policies.md) |
|  |  | [AWS::NetworkFirewall::LoggingConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-loggingconfiguration.html) | [aws_network_firewall_logging_configuration](docs/resources/aws_network_firewall_logging_configuration.md) | No Plural Resource |
|  |  | [AWS::NetworkFirewall::RuleGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html) | [aws_network_firewall_rule_group](docs/resources/aws_network_firewall_rule_group.md) | [aws_network_firewall_rule_groups](docs/resources/aws_network_firewall_rule_groups.md) |
| NetworkManager | Networking & Content Delivery | [AWS::NetworkManager::CustomerGatewayAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-customergatewayassociation.html) | [aws_network_manager_customer_gateway_association](docs/resources/aws_network_manager_customer_gateway_association.md) | [aws_network_manager_customer_gateway_associations](docs/resources/aws_network_manager_customer_gateway_associations.md) |
|  |  | [AWS::NetworkManager::Device](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-device.html) | [aws_network_manager_device](docs/resources/aws_network_manager_device.md) | [aws_network_manager_devices](docs/resources/aws_network_manager_devices.md) |
|  |  | [AWS::NetworkManager::GlobalNetwork](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-globalnetwork.html) | [aws_network_manager_global_network](docs/resources/aws_network_manager_global_network.md) | [aws_network_manager_global_networks](docs/resources/aws_network_manager_global_networks.md) |
| Organizations | Management & Governance | AWS::Organizations::Member | [aws_organizations_member](docs/resources/aws_organizations_member.md) | No Plural Resource |
| RAM | Security, Identity, & Compliance | [AWS::RAM::ResourceShare](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ram-resourceshare.html) | [aws_ram_resource_share](docs/resources/aws_ram_resource_share.md) | [aws_ram_resource_shares](docs/resources/aws_ram_resource_shares.md) |
| RDS | Database | [AWS::RDS::DBCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbcluster.html) | [aws_rds_cluster](docs/resources/aws_rds_cluster.md) | [aws_rds_clusters](docs/resources/aws_rds_clusters.md) |
|  |  |  | [aws_rds_db_cluster_snapshot](docs/resources/aws_rds_db_cluster_snapshot.md) | [aws_rds_db_cluster_snapshots](docs/resources/aws_rds_db_cluster_snapshots.md)
|  |  | [AWS::RDS::DBInstance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-database-instance.html) | [aws_rds_instance](docs/resources/aws_rds_instance.md) | [aws_rds_instances](docs/resources/aws_rds_instances.md)
|  |  | [AWS::RDS::DBParameterGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html) | [aws_db_parameter_group](docs/resources/aws_db_parameter_group.md) | [aws_db_parameter_groups](docs/resources/aws_db_parameter_groups.md) |
|  |  | [AWS::RDS::DBProxy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxy.html) | [aws_rds_db_proxy](docs/resources/aws_rds_db_proxy.md) | No Plural Resource |
|  |  | [AWS::RDS::DBProxyEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxyendpoint.html) | [aws_rds_db_proxy_endpoint](docs/resources/aws_rds_db_proxy_endpoint.md) | [aws_rds_db_proxy_endpoints](docs/resources/aws_rds_db_proxy_endpoints.md) |
|  |  | [AWS::RDS::DBProxyTargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxytargetgroup.html) | [aws_rds_db_proxy_target_group](docs/resources/aws_rds_db_proxy_target_group.md) | [aws_rds_db_proxy_target_groups](docs/resources/aws_rds_db_proxy_target_groups.md) |
|  |  | [AWS::RDS::DBSecurityGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-security-group.html) | [aws_rds_db_security_group](docs/resources/aws_rds_db_security_group.md) | [aws_rds_db_security_groups](docs/resources/aws_rds_db_security_groups.md) |
|  |  | [AWS::RDS::DBSubnetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbsubnet-group.html) | [aws_db_subnet_group](docs/resources/aws_db_subnet_group.md) | [aws_db_subnet_groups](docs/resources/aws_db_subnet_groups.md) |
|  |  | [AWS::RDS::EventSubscription](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-eventsubscription.html) | [aws_rds_event_subscription](docs/resources/aws_rds_event_subscription.md) | [aws_rds_event_subscriptions](docs/resources/aws_rds_event_subscriptions.md) |
|  |  | [AWS::RDS::GlobalCluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-globalcluster.html) | [aws_rds_global_cluster](docs/resources/aws_rds_global_cluster.md) | [aws_rds_global_clusters](docs/resources/aws_rds_global_clusters.md) |
|  |  | [AWS::RDS::OptionGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-optiongroup.html) | [aws_rds_group_option](docs/resources/aws_rds_group_option.md) | [aws_rds_group_options](docs/resources/aws_rds_group_options.md) |
|  |  | Others | [aws_rds_snapshot](docs/resources/aws_rds_snapshot.md) | [aws_rds_snapshots](docs/resources/aws_rds_snapshots.md) |
|  |  |  | No Singular Resource | [aws_rds_snapshot_attributes](docs/resources/aws_rds_snapshot_attributes.md) |
| Amazon Redshift | Analytics | [AWS::Redshift::Cluster](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html) | [aws_redshift_cluster](docs/resources/aws_redshift_cluster.md) | [aws_redshift_clusters](docs/resources/aws_redshift_clusters.md) |
|  |  | [AWS::Redshift::ClusterParameterGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-clusterparametergroup.html) | [aws_redshift_cluster_parameter_group](docs/resources/aws_redshift_cluster_parameter_group.md) | [aws_redshift_cluster_parameter_groups](docs/resources/aws_redshift_cluster_parameter_groups.md) |
| Route 53 | Networking & Content Delivery | [AWS::Route53::HostedZone](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53-hostedzone.html) | [aws_hosted_zone](docs/resources/aws_hosted_zone.md) | [aws_hosted_zones](docs/resources/aws_hosted_zones.md) |
|  |  | [AWS::Route53::RecordSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-route53-recordset.html) | [aws_route53_record_set](docs/resources/aws_route53_record_set.md) | [aws_route53_record_sets](docs/resources/aws_route53_record_sets.md) |
| Route 53 Resolver | Networking & Content Delivery  | [AWS::Route53Resolver::ResolverEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverendpoint.html) | [aws_route53resolver_resolver_endpoint](docs/resources/aws_route53resolver_resolver_endpoint.md) | [aws_route53resolver_resolver_endpoints](docs/resources/aws_route53resolver_resolver_endpoints.md) |
|  |  | [AWS::Route53Resolver::ResolverRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverrule.html) | [aws_route53resolver_resolver_rule](docs/resources/aws_route53resolver_resolver_rule.md) | [aws_route53resolver_resolver_rules](docs/resources/aws_route53resolver_resolver_rules.md) |
|  |  | [AWS::Route53Resolver::ResolverRuleAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-route53resolver-resolverruleassociation.html) | [aws_route53resolver_resolver_rule_association](docs/resources/aws_route53resolver_resolver_rule_association.md) | [aws_route53resolver_resolver_rule_associations](docs/resources/aws_route53resolver_resolver_rule_associations.md) |
| Amazon S3 | Compute | [AWS::S3::AccessPoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-accesspoint.html) | [aws_s3_access_point](docs/resources/aws_s3_access_point.md) | [aws_s3_access_points](docs/resources/aws_s3_access_points.md) |
|  |  | [AWS::S3::Bucket](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html) | [aws_s3_bucket](docs/resources/aws_s3_bucket.md) | [aws_s3_buckets](docs/resources/aws_s3_buckets.md) |
|  |  | [AWS::S3::BucketPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html) | [aws_s3_bucket_policy](docs/resources/aws_s3_bucket_policy.md) | No Plural Resource |
|  |  | Others | [aws_s3_bucket_object](docs/resources/aws_s3_bucket_object.md) | [aws_s3_bucket_objects](docs/resources/aws_s3_bucket_objects.md) |
| Secrets Manager | Security, Identity, & Compliance | [AWS::SecretsManager::Secret](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html) | [aws_secretsmanager_secret](docs/resources/aws_secretsmanager_secret.md) | [aws_secretsmanager_secrets](docs/resources/aws_secretsmanager_secrets.md) |
| Service Catalog | Management & Governance | [AWS::ServiceCatalog::CloudFormationProduct](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-cloudformationproduct.html) | [aws_servicecatalog_cloud_formation_product](docs/resources/aws_servicecatalog_cloud_formation_product.md) | No Plural Resource |
|  |  | [AWS::ServiceCatalog::LaunchRoleConstraint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-launchroleconstraint.html) | [aws_servicecatalog_launch_role_constraint](docs/resources/aws_servicecatalog_launch_role_constraint.md) | [aws_servicecatalog_launch_role_constraints](docs/resources/aws_servicecatalog_launch_role_constraints.md) |
|  |  | [AWS::ServiceCatalog::PortfolioPrincipalAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioprincipalassociation.html) | [aws_servicecatalog_portfolio_principal_association](docs/resources/aws_servicecatalog_portfolio_principal_association.md) | [aws_servicecatalog_portfolio_principal_associations](docs/resources/aws_servicecatalog_portfolio_principal_associations.md) |
|  |  | [AWS::ServiceCatalog::PortfolioProductAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioproductassociation.html) | [aws_servicecatalog_portfolio_product_association](docs/resources/aws_servicecatalog_portfolio_product_association.md) |  [aws_servicecatalog_portfolio_product_associations](docs/resources/aws_servicecatalog_portfolio_product_associations.md) |
| Shield | Security, Identity, & Compliance | [AWS::Shield::Subscription]() | [aws_shield_subscription](docs/resources/aws_shield_subscription.md) | No Plural Resource |
| SecurityHub | Security, Identity, & Compliance | [AWS::SecurityHub::Hub](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-securityhub-hub.html) | [aws_securityhub_hub](docs/resources/aws_securityhub_hub.md) | No Plural Resource |
| Amazon SES | Business Applications | [AWS::SES::ReceiptRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptrule.html) | [aws_ses_receipt_rule](docs/resources/aws_ses_receipt_rule.md) | No Plural Resource |
|  |  | [AWS::SES::ReceiptRuleSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-receiptruleset.html) | [aws_ses_receipt_rule_set](docs/resources/aws_ses_receipt_rule_set.md) | [aws_ses_receipt_rule_sets](docs/resources/aws_ses_receipt_rule_sets.md) |
|  |  | [AWS::SES::Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ses-template.html) | [aws_ses_template](docs/resources/aws_ses_template.md) | [aws_ses_templates](docs/resources/aws_ses_templates.md) |
| Amazon SimpleDB | Simple Database Service | [AWS::SDB::Domain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-simpledb.html) | No Singular Resource | [aws_sdb_domains](docs/resources/aws_sdb_domains.md) |
| Signer | Security, Identity, & Compliance | [AWS::Signer::ProfilePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-profilepermission.html) | No Singular Resource | [aws_signer_profile_permissions](docs/resources/aws_signer_profile_permissions.md) |
|  |  | [AWS::Signer::SigningProfile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html) | [aws_signer_signing_profile](docs/resources/aws_signer_signing_profile.md) | [aws_signer_signing_profiles](docs/resources/aws_signer_signing_profiles.md) |
| Amazon SNS | Application Integration | [AWS::SNS::Subscription](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sns-subscription.html) | [aws_sns_subscription](docs/resources/aws_sns_subscription.md) | [aws_sns_subscriptions](docs/resources/aws_sns_subscriptions.md) |
|  |  | [AWS::SNS::Topic](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-topic.html) | [aws_sns_topic](docs/resources/aws_sns_topic.md) |  [aws_sns_topics](docs/resources/aws_sns_topics.md) |
|  |  | [AWS::SNS::TopicPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sns-policy.html) | [aws_sns_topic](docs/resources/aws_sns_topic.md) |  [aws_sns_topics](docs/resources/aws_sns_topics.md) |
| Amazon SQS | Application Integration | [AWS::SQS::Queue](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sqs-queues.html) | [aws_sqs_queue](docs/resources/aws_sqs_queue.md) |  [aws_sqs_queues](docs/resources/aws_sqs_queues.md) |
|  |  | [AWS::SQS::QueuePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-sqs-policy.html) | [aws_sqs_queue](docs/resources/aws_sqs_queue.md) |  [aws_sqs_queues](docs/resources/aws_sqs_queues.md) |
| SSO | Security, Identity, & Compliance | [AWS::SSO::Assignment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sso-assignment.html) | [aws_sso_assignment](docs/resources/aws_sso_assignment.md) | [aws_sso_assignments](docs/resources/aws_sso_assignments.md) |
|  |  | [AWS::SSO::InstanceAccessControlAttributeConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sso-instanceaccesscontrolattributeconfiguration.html) | [aws_sso_instance_access_control_attribute_configuration](docs/resources/aws_sso_instance_access_control_attribute_configuration.md) | [aws_sso_instance_access_control_attribute_configurations](docs/resources/aws_sso_instance_access_control_attribute_configurations.md) |
|  |  | [AWS::SSO::PermissionSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sso-permissionset.html) | [aws_sso_permission_set](docs/resources/aws_sso_permission_set.md) | [aws_sso_permission_sets](docs/resources/aws_sso_permission_sets.md) |
| Step Functions | Application Integration | [AWS::StepFunctions::Activity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html) | [aws_stepfunctions_activity](docs/resources/aws_stepfunctions_activity.md) |  [aws_stepfunctions_activities](docs/resources/aws_stepfunctions_activities.md) |
|  |  | [AWS::StepFunctions::StateMachine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html) | [aws_stepfunctions_state_machine](docs/resources/aws_stepfunctions_state_machine.md) |  [aws_stepfunctions_state_machines](docs/resources/aws_stepfunctions_state_machines.md) |
| STS | Security, Identity, & Compliance | AWS::STS::CallerIdentity | [aws_sts_caller_identity](docs/resources/aws_sts_caller_identity.md) | No Plural Resource |
| CloudWatch Synthetics | Synthetics | [AWS::Synthetics::Canary](Amazon) | [aws_synthetics_canary](docs/resources/aws_synthetics_canary.md) | [aws_synthetics_canaries](docs/resources/aws_synthetics_canaries.md) |
| System Manager | Management & Governance | [AWS::SSM::Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-association.html) | [aws_ssm_association](docs/resources/aws_ssm_association.md) | [aws_ssm_associations](docs/resources/aws_ssm_associations.md) |
|  |  | [AWS::SSM::Document](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-document.html) | [aws_ssm_document](docs/resources/aws_ssm_document.md) | [aws_ssm_documents](docs/resources/aws_ssm_documents.md) |
|  |  | [AWS::SSM::MaintenanceWindow](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindow.html) | [aws_ssm_maintenance_window](docs/resources/aws_ssm_maintenance_window.md) | [aws_ssm_maintenance_windows](docs/resources/aws_ssm_maintenance_windows.md) |
|  |  | [AWS::SSM::MaintenanceWindowTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtarget.html) | [aws_ssm_maintenance_window_target](docs/resources/aws_ssm_maintenance_window_target.md) | [aws_ssm_maintenance_window_targets](docs/resources/aws_ssm_maintenance_window_targets.md) |
|  |  | [AWS::SSM::MaintenanceWindowTask](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtask.html) | [aws_ssm_maintenance_window_task](docs/resources/aws_ssm_maintenance_window_task.md) | [aws_ssm_maintenance_window_tasks](docs/resources/aws_ssm_maintenance_window_tasks.md) |
|  |  | [AWS::SSM::Parameter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-parameter.html) | [aws_ssm_parameter](docs/resources/aws_ssm_parameter.md) | [aws_ssm_parameters](docs/resources/aws_ssm_parameters.md) |
|  |  | [AWS::SSM::PatchBaseline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-patchbaseline.html) | [aws_ssm_patch_baseline](docs/resources/aws_ssm_patch_baseline.md) | [aws_ssm_patch_baselines](docs/resources/aws_ssm_patch_baselines.md) |
|  |  | [AWS::SSM::ResourceDataSync](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-resourcedatasync.html) | No Singular Resources | [aws_ssm_resource_data_syncs](docs/resources/aws_ssm_resource_data_syncs.md) |
|  |  | Others | [aws_ssm_activation](docs/resources/aws_ssm_activation.md) |  [aws_ssm_activations](docs/resources/aws_ssm_activations.md) |
|  |  |  | [aws_ssm_resource_compliance_summary](docs/resources/aws_ssm_resource_compliance_summary.md) | [aws_ssm_resource_compliance_summaries](docs/resources/aws_ssm_resource_compliance_summaries.md) |
| Amazon Timestream | Migration & Transfer | [AWS::Transfer::User](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-transfer-user.html) | [aws_transfer_user](docs/resources/aws_transfer_user.md) | [aws_transfer_users](docs/resources/aws_transfer_users.md) |
| WAF | Security, Identity, & Compliance | [AWS::WAF::ByteMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-bytematchset.html) | [aws_waf_byte_match_set](docs/resources/aws_waf_byte_match_set.md) | [aws_waf_byte_match_sets](docs/resources/aws_waf_byte_match_sets.md) |
|  |  | [AWS::WAF::IPSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html) | [aws_waf_ip_set](docs/resources/aws_waf_ip_set.md) | [aws_waf_ip_sets](docs/resources/aws_waf_ip_sets.md) |
|  |  | [AWS::WAF::Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-rule.html) | [aws_waf_rule](docs/resources/aws_waf_rule.md) | [aws_waf_rules](docs/resources/aws_waf_rules.md) |
|  |  | [AWS::WAF::SizeConstraintSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html) | [aws_waf_size_constraint_set](docs/resources/aws_waf_size_constraint_set.md) | [aws_waf_size_constraint_sets](docs/resources/aws_waf_size_constraint_sets.md) |
|  |  | [AWS::WAF::SqlInjectionMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sqlinjectionmatchset.html) | [aws_waf_sql_injection_match_set](docs/resources/aws_waf_sql_injection_match_set.md) | [aws_waf_sql_injection_match_sets](docs/resources/aws_waf_sql_injection_match_sets.md) |
|  |  | [AWS::WAF::WebACL](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-webacl.html) | [aws_waf_web_acl](docs/resources/aws_waf_web_acl.md) | [aws_waf_web_acls](docs/resources/aws_waf_web_acls.md) |
|  |  | [AWS::WAF::XssMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-xssmatchset.html) | [aws_waf_xss_match_set](docs/resources/aws_waf_xss_match_set.md) | [aws_waf_xss_match_sets](docs/resources/aws_waf_xss_match_sets.md) |

## Examples 

### Ensure Security Groups disallow FTP

For disallowing FTP, we check that there is no ingress from 0.0.0.0/0 on port 21.  The below sample control loops across all regions, checking all security groups for the account:

```ruby
title 'Test AWS Security Groups Across All Regions For an Account Disallow FTP'

control 'aws-multi-region-security-group-ftp-1.0' do

  impact 1.0
  title 'Ensure AWS Security Groups disallow FTP ingress from 0.0.0.0/0.'

  aws_regions.region_names.each do |region|
    aws_security_groups(aws_region: region).group_ids.each do |security_group_id|
      describe aws_security_group(aws_region: region, group_id: security_group_id) do
        it { should exist }
        it { should_not allow_in(ipv4_range: '0.0.0.0/0', port: 21) }
      end
    end
  end
end
```

### Test that an EC2 instance is running and using the correct AMI

```ruby
    describe aws_ec2_instance(name: 'ProdWebApp') do
      it              { should be_running }
      its('image_id') { should eq 'ami-27a58d5c' }
    end
```

### Ensure all AWS Users have MFA enabled

```ruby
    describe aws_iam_users.where( has_mfa_enabled: false) do
      it { should_not exist }
    end
```

## Properties Applying to All InSpec AWS Resources

### `aws_region`

To provide multi-region support, the `aws_region` property is specified to a resource.  This property affects AWS resources that have a region dependency. For example, security groups.  One special case worth mentioning is the `aws_s3_bucket` resource that updates its region based on the location returned from S3.

The `aws_regions` resource is used to loop across all regions.

```ruby
  aws_regions.region_names.each do |region|
    <use region in other resources here>
  end
```

### `aws_endpoint`

A custom endpoint URL can optionally be specified to resources for testing other compatible providers.  This propagates to the AWS client configuration.  An example is provided below for [Minio](https://github.com/minio/minio) S3 compatible buckets.

```ruby
title 'Test For Minio Buckets Existing at a Custom Endpoint'

endpoint = attribute(:minio_server, value: 'http://127.0.0.1:9000', description: 'The Minio server custom endpoint.')

control 'minio-buckets-1.0' do
  impact 1.0
  title 'Ensure Minio buckets exist.'

  describe aws_s3_bucket(aws_endpoint: endpoint, bucket_name: 'miniobucket') do
    it { should exist }
  end

  describe aws_s3_bucket(aws_endpoint: endpoint, bucket_name: 'notthere') do
    it { should_not exist }
  end
end
```

{{< note >}}

The InSpec AWS assumes full compatibility with the underlying AWS SDK, and unsupported operations cause failures. Hence, depending on the external provider implementation, your mileage may vary!

{{< /note >}}

### `aws_retry_limit` and `aws_retry_backoff`

In certain cases, AWS implements rate-limiting. To mitigate this issue, the `Retry Limit` and `Retry Backoff` can be set in two ways:

#### 1) Environment Variables

Setting `AWS_RETRY_LIMIT` and `AWS_RETRY_BACKOFF` environment variables is implemented at the session level.

```bash
   export AWS_RETRY_LIMIT=5
   export aws_retry_limit=5
```

_Note environment variables are case insensitive._

#### 2) InSpec Control

InSpec AWS resources now support setting the Retry Limit and Retry Backoff at the control level, as shown below.

```ruby
  describe aws_config_recorder(recorder_name: aws_config_recorder_name, aws_retry_limit=5, aws_retry_backoff=5) do
    it { should exist }
    its('recorder_name') { should eq aws_config_recorder_name }
  end
```

 #####The `aws_retry_limit` and `aws_retry_backoff` precedence:

   1. Set at Inspec control level.
   2. Set at Environment level.

[Retry Limit and Retry Backoff documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/timeout-duration.html)

### `NullResponse`

InSpec AWS resources returns `NullResponse` when an undefined property is tested from version **1.24** onwards instead of raising a `NoMethodError`.

```ruby
describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('fake_property') { should be_nil }
end
# =>   EC2 Instance i-12345678
#          ✔  fake_property is expected to be nil

describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('instance_ID') { should eq 'i-12345678' }
end
# =>  ×  instance_ID is expected to eq "i-12345678"    
#     expected: "i-12345678"
#          got: #<#<Class:0x00007ffc4aa24c68>::NullResponse:0x00007ffc39f16070>    
#     (compared using ==)
```

Prior to version **1.24**.

```ruby
describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('fake_property') { should be_nil }
end
# => EC2 Instance i-12345678
#          ×  fake_property 
#          undefined method `fake_property' for EC2 Instance i-12345678

describe aws_ec2_instance(instance_id: 'i-12345678') do
  its('instance_ID') { should eq 'i-12345678' }
end
# => undefined method `instance_ID' for EC2 Instance i-12345678
```

## Environment and Setup Notes

### Train and InSpec Dependencies

InSpec AWS depends on version 3 of the AWS SDK provided via [Train AWS](https://github.com/inspec/train-aws). InSpec depends on Train AWS, so this is not explicitly listed in the Gemfile here.

### Running a sample profile using Docker

A `Dockerfile` is provided at the root of this resource pack repository.  

```bash
cd inspec-aws
docker build -t inspec-aws -f Dockerfile
docker run -it inspec-aws /bin/bash
export AWS_ACCESS_KEY_ID=<your creds here>
export AWS_SECRET_ACCESS_KEY=<your creds here>
bundle exec inspec exec sample_profile -t aws://
```

If successful, output similar to below code is seen:

```bash
# bundle exec inspec exec sample_profile -t aws://

Profile: AWS InSpec Profile (InSpec AWS Sample Profile)
Version: 0.1.0
Target:  aws://us-east-1

  ✔  aws-vpcs-multi-region-status-check: Check AWS VPCs in all regions have status "available"
     ✔  VPC vpc-1234abcd in eu-north-1 should exist
     ✔  VPC vpc-1234abcd in eu-north-1 should be available
<curtailing> ...


Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  aws://us-east-1

     No tests were executed.

Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 50 successful, 0 failures, 0 skipped
```

### Running a single unit test

```bash
rake test TEST=inspec-aws/test/unit/resources/aws_alb_test.rb
```

The above example is for running the `aws_alb_test.rb` file.

### Running the unit and integration tests

Run the linting and unit tests via the below:

```bash
$ bundle exec rake
Running RuboCop...
Inspecting 2 files
..

2 files inspected, no offenses detected
/Users/spaterson/.rubies/ruby-2.4.3/bin/ruby -I"lib:libraries:test/unit" -I"/Users/spaterson/.rubies/ruby-2.4.3/lib/ruby/gems/2.4.0/gems/rake-12.3.1/lib" "/Users/spaterson/.rubies/ruby-2.4.3/lib/ruby/gems/2.4.0/gems/rake-12.3.1/lib/rake/rake_test_loader.rb" "test/unit/resources/aws_vpc_test.rb"
Run options: --seed 64195

# Running:

.................

Fabulous run in 0.253300s, 67.1141 runs/s, 51.3225 assertions/s.

17 runs, 13 assertions, 0 failures, 0 errors, 0 skips
bundle exec inspec check /Users/spaterson/Documents/workspace/aws/inspec-aws
Location:    /Users/spaterson/Documents/workspace/aws/inspec-aws
Profile:     inspec-aws
Controls:    0
Timestamp:   2018-11-29T15:02:33+00:00
Valid:       true

  !  No controls or tests were defined.

Summary:     0 errors, 1 warnings
```

Conversely, run using within a docker container, using the make file:

To run unit tests and linting:

````bash
make sure

````

Will result in...

````bash
make sure

docker-compose run --rm builder 
Running RuboCop...
Inspecting 68 files
....................................................................

68 files inspected, no offenses detected
/usr/local/bin/ruby -I"lib:libraries:test/unit" -I"/usr/local/bundle/gems/rake-12.3.3/lib" "/usr/local/bundle/gems/rake-12.3.3/lib/rake/rake_test_loader.rb" "test/unit/resources/aws_alb_test.rb" "test/unit/resources/aws_auto_scaling_group_test.rb" "test/unit/resources/aws_cloudformation_stack_test.rb" "test/unit/resources/aws_cloudtrail_trail_test.rb" "test/unit/resources/aws_cloudtrail_trails_test.rb" "test/unit/resources/aws_cloudwatch_alarm_test.rb" "test/unit/resources/aws_cloudwatch_log_metric_filter_test.rb" "test/unit/resources/aws_config_delivery_channel_test.rb" "test/unit/resources/aws_config_recorder_test.rb" "test/unit/resources/aws_dynamodb_table_test.rb" "test/unit/resources/aws_ebs_volume_test.rb" "test/unit/resources/aws_ebs_volumes_test.rb" "test/unit/resources/aws_ec2_instance_test.rb" "test/unit/resources/aws_ec2_instances_test.rb" "test/unit/resources/aws_ecr_test.rb" "test/unit/resources/aws_ecs_cluster_test.rb" "test/unit/resources/aws_eks_cluster_test.rb" "test/unit/resources/aws_eks_clusters_test.rb" "test/unit/resources/aws_elb_test.rb" "test/unit/resources/aws_flow_log_test.rb" "test/unit/resources/aws_hosted_zones_test.rb" "test/unit/resources/aws_iam_account_alias_test.rb" "test/unit/resources/aws_iam_group_test.rb" "test/unit/resources/aws_iam_password_policy_test.rb" "test/unit/resources/aws_iam_policy_test.rb" "test/unit/resources/aws_iam_role_test.rb" "test/unit/resources/aws_iam_root_user_test.rb" "test/unit/resources/aws_iam_saml_provider_test.rb" "test/unit/resources/aws_iam_user_test.rb" "test/unit/resources/aws_kms_key_test.rb" "test/unit/resources/aws_kms_keys_test.rb" "test/unit/resources/aws_launch_configuration_test.rb" "test/unit/resources/aws_organizations_member_test.rb" "test/unit/resources/aws_rds_instance_test.rb" "test/unit/resources/aws_rds_instances_test.rb" "test/unit/resources/aws_region_test.rb" "test/unit/resources/aws_regions_test.rb" "test/unit/resources/aws_route_table_test.rb" "test/unit/resources/aws_route_tables_test.rb" "test/unit/resources/aws_s3_bucket_object_test.rb" "test/unit/resources/aws_s3_bucket_test.rb" "test/unit/resources/aws_s3_buckets_test.rb" "test/unit/resources/aws_security_group_test.rb" "test/unit/resources/aws_security_groups_test.rb" "test/unit/resources/aws_sns_subscription_test.rb" "test/unit/resources/aws_sns_topic_test.rb" "test/unit/resources/aws_sns_topics_test.rb" "test/unit/resources/aws_sqs_queue_test.rb" "test/unit/resources/aws_sts_caller_identity_test.rb" "test/unit/resources/aws_subnet_test.rb" "test/unit/resources/aws_subnets_test.rb" "test/unit/resources/aws_vpc_test.rb" "test/unit/resources/aws_vpcs_test.rb" 
Run options: --seed 22010

# Running:

..............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................

Fabulous run in 4.613042s, 155.6457 runs/s, 172.3375 assertions/s.

718 runs, 795 assertions, 0 failures, 0 errors, 0 skips

````

To run the full suite of tests, run

````bash
make doubly_sure

````

This test runs the unit tests, creates the target infrastructure, and runs the intergration tests.  If successful, the test  automatically destroy everything.  If it fails, it will keep the environment up, testing then can be achieved by running:

````bash
make int_test
````

The AWS credentials can either be supplied via environmental variables or files located on ./aws folder.

This requires docker, docker-compose and make, see [Three Musketeers Pattern](https://3musketeers.io/docs/make.html) for details.

Running the integration tests (after `setup_integration_tests`):

```bash
$ bundle exec rake test:run_integration_tests
----> Run
bundle exec inspec exec test/integration/verify --attrs test/integration/build/aws-inspec-attributes.yaml; rc=$?; if [ $rc -eq 0 ] || [ $rc -eq 101 ]; then exit 0; else exit 1; fi

Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  aws://eu-west-2

  ✔  aws-vpc-1.0: Ensure AWS VPC has the correct properties.
     ✔  VPC vpc-0373aeb7284407ffd should exist
     ✔  VPC vpc-0373aeb7284407ffd should not be default
     ✔  VPC vpc-0373aeb7284407ffd cidr_block should eq "10.0.0.0/27"
     ✔  VPC vpc-0373aeb7284407ffd instance_tenancy should eq "dedicated"
     ✔  VPC vpc-0373aeb7284407ffd vpc_id should eq "vpc-0373aeb7284407ffd"
     ✔  VPC vpc-0373aeb7284407ffd state should eq "available"
     ✔  VPC vpc-0373aeb7284407ffd dhcp_options_id should eq "dopt-f557819d"
     ✔  VPC default should exist
     ✔  VPC default should be default
     ✔  VPC default vpc_id should eq "vpc-1ea06476"
     ✔  VPC vpc-0373aeb7284407ffd should exist
     ✔  VPC vpc-0373aeb7284407ffd should not be default
     ✔  VPC vpc-0373aeb7284407ffd vpc_id should eq "vpc-0373aeb7284407ffd"
...

Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  aws://eu-west-2

     No tests were executed.

Profile Summary: 50 successful controls, 0 control failures, 3 controls skipped
Test Summary: 602 successful, 0 failures, 18 skipped
```

## FAQ

### Failure running "inspec exec" on my AWS profile

If an error occurs when running "inspec exec" on a newly created AWS profile, check that the AWS transport is specified as below:

```bash
inspec exec . -t aws://
```

If a method missing error occurs and all the steps documented above is followed try running the following command within the profile directory:

```bash
inspec vendor --overwrite
```

## Support

The InSpec AWS resources are community-supported. For bugs and features, please open a GitHub issue and label it appropriately.

## Kudos

This work builds on the InSpec 2 AWS resources that are originally shipped as part of InSpec.
