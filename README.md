# InSpec for AWS

* **Project State: Maintained**

For more information on project states and SLAs, see [this documentation](https://github.com/chef/chef-oss-practices/blob/master/repo-management/repo-states.md).

This InSpec resource pack uses the AWS Ruby SDK v3 and provides the required resources to write tests for resources in AWS.

## Prerequisites

### AWS Credentials

Valid AWS credentials are required, see [AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)

There are multiple ways to set AWS credentials as shown below:

#### 1) Environment Variables

Set your AWS credentials in an `.envrc` file or export them in your shell. (See example [.envrc file](.envrc_example))
    
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
   ```
      [default]
      aws_access_key_id=AKIAIOSFODNN7EXAMPLE
      aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
      
      [engineering]
      aws_access_key_id=AKIAIOSFODNN7EXAMPLF
      aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY1
   ```
   
Example `~/.aws/config` :
 ```
    [default]
    region=us-west-2
    
    [engineering]
    region=us-east-2
 ```
 
 AWS SDK will select the default credentials unless `aws_profile` is set in an `.envrc`
 ```bash
     # Example configuration
     export AWS_PROFILE="engineering"
 ```
 
 ##### The credentials precedence is:
   1. Credentials set in `.envrc` OR as an Environment variable.
   2. Credentials set in `~/.aws/credentials` AND `~/.aws/config` AND `AWS_PROFILE` set as an Environment variable.
   3. Credentials set in `~/.aws/credentials` AND `~/.aws/config` AND `AWS_PROFILE` is NOT set as an Environment variable. Default credentials will be used.
   
### AWS Region
The `aws_region` parameter can be provided to query resources in a specific region. If not provided, the AWS region set in environment variables or configuration files will be used. 

Example:
```ruby
describe aws_ec2_instances(aws_region: 'us-west-2') do
  its('count') { should eq 10 }
end
```

### Assuming an IAM role
Assuming an IAM role allows an IAM user to gain additional/different permissions to perform actions in a different AWS account. (See example [aws configure IAM role](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html))

Example:
```bash
   [profile example_profile]
   role_arn = arn:aws:iam::123456789012:role/example_profile
   source_profile = user1
```

### Permissions
Each resource will require specific permissions to perform the operations required for testing. For example, to test an AWS EC2 instance, your service principal will require the `ec2:DescribeInstances` and `iam:GetInstanceProfile` permissions. You can find a comprehensive list of each resource's required permissions in the [documentation](docs/).

## Use the Resources

Since this is an InSpec resource pack, it only defines InSpec resources. It includes example tests only. To easily use the AWS resources in your tests do the following:

```
$ inspec init profile --platform aws my-profile
```

The above command will generate a sample inspec.yml that depends on `master`.  We recommend this is pinned to a release of the resource pack as follows:

```
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

Add some tests and run the profile via:

```
$ inspec exec my-profile -t aws://
```


## Resource documentation
This resouce pack allows the testing of the following AWS resources. If a resource you wish to test is not listed, please feel free to open an [Issue](https://github.com/inspec/inspec-aws/issues). As an open source project, we also welcome public contributions via [Pull Request](https://github.com/inspec/inspec-aws/pulls).

- [aws_alb](docs/resources/aws_alb.md)
- [aws_albs](docs/resources/aws_albs.md)
- [aws_ami](docs/resources/aws_ami.md)
- [aws_amis](docs/resources/aws_amis.md)
- [aws_auto_scaling_group](docs/resources/aws_auto_scaling_group.md)
- [aws_auto_scaling_groups](docs/resources/aws_auto_scaling_groups.md)
- [aws_cloudformation_stack](docs/resources/aws_cloudformation_stack.md)
- [aws_cloudtrail_trail](docs/resources/aws_cloudtrail_trail.md)
- [aws_cloudtrail_trails](docs/resources/aws_cloudtrail_trails.md)
- [aws_cloudwatch_alarm](docs/resources/aws_cloudwatch_alarm.md)
- [aws_cloudwatch_log_metric_filter](docs/resources/aws_cloudwatch_log_metric_filter.md)
- [aws_config_delivery_channel](docs/resources/aws_config_delivery_channel.md)
- [aws_config_recorder](docs/resources/aws_config_recorder.md)
- [aws_db_subnet_group](docs/resources/aws_db_subnet_group.md)
- [aws_db_subnet_groups](docs/resources/aws_db_subnet_groups.md)
- [aws_dhcp_options](docs/resources/aws_dhcp_options.md)
- [aws_dynamodb_table](docs/resources/aws_dynamodb_table.md)
- [aws_ebs_volume](docs/resources/aws_ebs_volume.md)
- [aws_ebs_volumes](docs/resources/aws_ebs_volumes.md)
- [aws_ec2_instance](docs/resources/aws_ec2_instance.md)
- [aws_ec2_instances](docs/resources/aws_ec2_instances.md)
- [aws_ecr](docs/resources/aws_ecr.md)
- [aws_ecr_image](docs/resources/aws_ecr_image.md)
- [aws_ecr_images](docs/resources/aws_ecr_images.md)
- [aws_ecr_repository](docs/resources/aws_ecr_repository.md)
- [aws_ecr_repositories](docs/resources/aws_ecr_repositories.md)
- [aws_ecs_cluster](docs/resources/aws_ecs_cluster.md)
- [aws_ecs_clusters](docs/resources/aws_ecs_clusters.md)
- [aws_efs_file_system](docs/resources/aws_efs_file_system.md)
- [aws_efs_file_systems](docs/resources/aws_efs_file_systems.md)
- [aws_eks_cluster](docs/resources/aws_eks_cluster.md)
- [aws_eks_clusters](docs/resources/aws_eks_clusters.md)
- [aws_elb](docs/resources/aws_elb.md)
- [aws_elbs](docs/resources/aws_elbs.md)
- [aws_elasticache_cluster](docs/resources/aws_elasticache_cluster.md)
- [aws_elasticache_cluster_node](docs/resources/aws_elasticache_cluster_node.md)
- [aws_elasticache_clusters](docs/resources/aws_elasticache_clusters.md)
- [aws_flow_log](docs/resources/aws_flow_log.md)
- [aws_guardduty_detector](docs/resources/aws_guardduty_detector.md)
- [aws_guardduty_detectors](docs/resources/aws_guardduty_detectors.md)
- [aws_hosted_zone](docs/resources/aws_hosted_zone.md)
- [aws_hosted_zones](docs/resources/aws_hosted_zones.md)
- [aws_iam_access_key](docs/resources/aws_iam_access_key.md)
- [aws_iam_access_keys](docs/resources/aws_iam_access_keys.md)
- [aws_iam_account_alias](docs/resources/aws_iam_account_alias.md)
- [aws_iam_group](docs/resources/aws_iam_group.md)
- [aws_iam_groups](docs/resources/aws_iam_groups.md)
- [aws_iam_password_policy](docs/resources/aws_iam_password_policy.md)
- [aws_iam_policies](docs/resources/aws_iam_policies.md)
- [aws_iam_policy](docs/resources/aws_iam_policy.md)
- [aws_iam_role](docs/resources/aws_iam_role.md)
- [aws_iam_roles](docs/resources/aws_iam_roles.md)
- [aws_iam_root_user](docs/resources/aws_iam_root_user.md)
- [aws_iam_saml_provider](docs/resources/aws_iam_saml_provider.md)
- [aws_iam_saml_providers](docs/resources/aws_iam_saml_providers.md)
- [aws_iam_user](docs/resources/aws_iam_user.md)
- [aws_iam_users](docs/resources/aws_iam_users.md)
- [aws_kms_key](docs/resources/aws_kms_key.md)
- [aws_kms_keys](docs/resources/aws_kms_keys.md)
- [aws_lambda](docs/resources/aws_lambda.md)
- [aws_lambdas](docs/resources/aws_lambdas.md)
- [aws_launch_configuration](docs/resources/aws_launch_configuration.md)
- [aws_nat_gateway](docs/resources/aws_nat_gateway.md)
- [aws_nat_gateways](docs/resources/aws_nat_gateways.md)
- [aws_organizations_member](docs/resources/aws_organizations_member.md)
- [aws_rds_cluster](docs/resources/aws_rds_cluster.md)
- [aws_rds_clusters](docs/resources/aws_rds_clusters.md)
- [aws_rds_instance](docs/resources/aws_rds_instance.md)
- [aws_rds_instances](docs/resources/aws_rds_instances.md)
- [aws_region](docs/resources/aws_region.md)
- [aws_regions](docs/resources/aws_regions.md)
- [aws_route_table](docs/resources/aws_route_table.md)
- [aws_route_tables](docs/resources/aws_route_tables.md)
- [aws_s3_bucket](docs/resources/aws_s3_bucket.md)
- [aws_s3_bucket_object](docs/resources/aws_s3_bucket_object.md)
- [aws_s3_buckets](docs/resources/aws_s3_buckets.md)
- [aws_security_group](docs/resources/aws_security_group.md)
- [aws_security_groups](docs/resources/aws_security_groups.md)
- [aws_sns_subscription](docs/resources/aws_sns_subscription.md)
- [aws_sns_topic](docs/resources/aws_sns_topic.md)
- [aws_sns_topics](docs/resources/aws_sns_topics.md)
- [aws_sqs_queue](docs/resources/aws_sqs_queue.md)
- [aws_sqs_queues](docs/resources/aws_sqs_queues.md)
- [aws_ssm_activation](docs/resources/aws_ssm_activation.md)
- [aws_ssm_activations](docs/resources/aws_ssm_activations.md)
- [aws_ssm_association](docs/resources/aws_ssm_association.md)
- [aws_ssm_associations](docs/resources/aws_ssm_associations.md)
- [aws_ssm_document](docs/resources/aws_ssm_document.md)
- [aws_ssm_documents](docs/resources/aws_ssm_documents.md)
- [aws_ssm_parameter](docs/resources/aws_ssm_parameter.md)
- [aws_ssm_parameters](docs/resources/aws_ssm_parameters.md)
- [aws_ssm_resource_compliance_summaries](docs/resources/aws_ssm_resource_compliance_summaries.md)
- [aws_ssm_resource_compliance_summary](docs/resources/aws_ssm_resource_compliance_summary.md)
- [aws_sts_caller_identity](docs/resources/aws_sts_caller_identity.md)
- [aws_subnet](docs/resources/aws_subnet.md)
- [aws_subnets](docs/resources/aws_subnets.md)
- [aws_transit_gateway](docs/resources/aws_transit_gateway.md)
- [aws_vpc](docs/resources/aws_vpc.md)
- [aws_vpc_endpoint](docs/resources/aws_vpc_endpoint.md)
- [aws_vpc_endpoints](docs/resources/aws_vpc_endpoints.md)
- [aws_vpcs](docs/resources/aws_vpcs.md)
- [aws_vpn_connections](docs/resources/aws_vpn_connections.md)

## Examples

### Ensure Security Groups Disallow FTP

For disallowing FTP we check that there is no ingress from 0.0.0.0/0 on port 21.  The below sample control loops across all regions, checking all security groups for the account:

```
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

### Test that an EC2 instance is running & using the correct AMI

```
    describe aws_ec2_instance(name: 'ProdWebApp') do
      it              { should be_running }
      its('image_id') { should eq 'ami-27a58d5c' }
    end
```
    
### Ensure all AWS Users have MFA enabled

```   
    describe aws_iam_users.where( has_mfa_enabled: false) do
      it { should_not exist }
    end
```

## Properties Applying to All InSpec AWS Resources

### `aws_region`

In order to provide multi-region support, the `aws_region` property may be specified to a resource.  This will only have an effect on AWS resources that have a region dependency e.g. security groups.  One special-case worth mentioning is the `aws_s3_bucket` resource that updates its region based on the location returned from S3.

The `aws_regions` resource can be used to loop across all regions e.g.

```
  aws_regions.region_names.each do |region|
    <use region in other resources here>
  end
```

### `aws_endpoint`

A custom endpoint URL can optionally be specified to resources for testing other compatible providers.  This propagates to the AWS client configuration.  An example is provided below for [Minio](https://github.com/minio/minio) S3 compatible buckets e.g.

```
title 'Test For  Minio Buckets Existing at a Custom Endpoint'

endpoint = input(:minio_server, value: 'http://127.0.0.1:9000', description: 'The Minio server custom endpoint.')

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

Note that InSpec AWS assumes full compatibility with the underlying AWS SDK and unsupported operations will cause failures.  Therefore, depending on the external provider implementation your mileage may vary!

### `aws_retry_limit` and `aws_retry_backoff`

In certain cases AWS may implement rate limiting. In order to mitigate this issue the `Retry Limit` and `Retry Backoff` can be set in two ways:

#### 1) Environment Variables
Setting `AWS_RETRY_LIMIT` and `AWS_RETRY_BACKOFF` environment variables will be implemented at session level.

```bash
   export AWS_RETRY_LMIIT=5
   export aws_retry_limit=5
```
_Note environment variables are case insensitive._

#### 2) InSpec Control
InSpec AWS resources now support setting the Retry Limit and Retry Backoff at control level as shown below.

```
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

InSpec AWS resources will return `NullResponse` when an undefined property is tested from version **1.24** onwards instead of raising a `NoMethodError`.
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

#### Train and InSpec Dependencies

InSpec AWS depends on version 3 of the AWS SDK that is provided via [Train AWS](https://github.com/inspec/train-aws).  InSpec depends on Train AWS so this is not explicitly listed in the Gemfile here.

### Running a Sample Profile Using Docker

A `Dockerfile` is provided in the root of this resource pack repository.  

```
cd inspec-aws
docker build -t inspec-aws -f Dockerfile .
docker run -it inspec-aws /bin/bash
export AWS_ACCESS_KEY_ID=<your creds here>
export AWS_SECRET_ACCESS_KEY=<your creds here>
bundle exec inspec exec sample_profile -t aws://
```

If successful, output similar to this should be seen:

```
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

     No tests executed.

Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 50 successful, 0 failures, 0 skipped
```

### Running the unit and integration tests

Run the linting and unit tests via the below:
```
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

Conversely run using within a docker container, using the make file:

To run unit tests and linting:

````bash
make sure

````
Will result in...

````
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

To run the full suite of tests run

```` bash

make doubly_sure

````

This will run the unit tests, create the target infrastructure and run the intergration tests.  If successful, will automatically destroy everything.  If it fails it will keep the environment up, testing then can be achieved by running:

```` bash
make int_test
````

To keep things simple the aws credentials can either be supplied via environmental variables or files located on ./aws in this folder.

This just requires docker, docker-compose and make, see [Three Musketeers Pattern](https://3musketeers.io/docs/make.html) for details

Running the integration tests (after `setup_integration_tests`):
```
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

     No tests executed.

Profile Summary: 50 successful controls, 0 control failures, 3 controls skipped
Test Summary: 602 successful, 0 failures, 18 skipped
```

## FAQ

### Failure running "inspec exec" on my AWS profile

If an error such occurs when running "inspec exec" on a newly created AWS profile, check that the AWS transport is being specified as below:

```
$ inspec exec . -t aws://
```

If a method missing error occurs and all the steps documented above have been followed try running the following command within the profile directory:
```bash
inspec vendor --overwrite
```

## Support

The InSpec AWS resources are community supported. For bugs and features, please open a github issue and label it appropriately.

## Kudos

This work builds on the InSpec 2 AWS resources that were originally shipped as part of InSpec. 
