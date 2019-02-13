# InSpec for AWS

This InSpec resource pack uses the AWS Ruby SDK v3 and provides the required resources to write tests for resources in AWS.

## Prerequisites

* Ruby
* Bundler
* AWS Service Principal (see [AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal))  
    * Set your AWS credentials in an `.envrc` file or export them in your shell. (See example [.envrc file](.envrc_example))
    
    ```bash
    # Example configuration
    export AWS_ACCESS_KEY_ID="AKIAJUMP347SLS66IGCQ"
    export AWS_SECRET_ACCESS_KEY="vD2lfoNvPdwsofqyuO9jRuWUkZIMqisdfeFmkHTy7ON+w"
    export AWS_REGION="eu-west-3"
    export AWS_AVAILABILITY_ZONE="eu-west-3a"  

##### Permissions
Each resource will require specific permissions to perform the operations required for testing. For example, to test an AWS EC2 instance, your service principal will require the `ec2:DescribeInstances` and `iam:GetInstanceProfile` permissions. You can find a comprehensive list of each resource's required permissions in the [documentation](docs/).


## Resources 
This resouce pack allows the testing of the following AWS resources. If a resource you wish to test is not listed, please feel free to open an [Issue](https://github.com/chef-partners/inspec-aws/issues). As an open source project, we also welcome public contributions via [Pull Request](https://github.com/chef-partners/inspec-aws/pulls).

- [aws_cloudtrail_trail](docs/resources/aws_cloudtrail_trail.md)
- [aws_cloudtrail_trails](docs/resources/aws_cloudtrail_trails.md)
- [aws_cloudwatch_alarm](docs/resources/aws_cloudwatch_alarm.md)
- [aws_cloudwatch_log_metric_filter](docs/resources/aws_cloudwatch_log_metric_filter.md)
- [aws_config_delivery_channel](docs/resources/aws_config_delivery_channel.md)
- [aws_config_recorder](docs/resources/aws_config_recorder.md)
- [aws_ebs_volume](docs/resources/aws_ebs_volume.md)
- [aws_ebs_volumes](docs/resources/aws_ebs_volumes.md)
- [aws_ec2_instance](docs/resources/aws_ec2_instance.md)
- [aws_ec2_instances](docs/resources/aws_ec2_instances.md)
- [aws_ecs_cluster](docs/resources/aws_ecs_cluster.md)
- [aws_ecs_clusters](docs/resources/aws_ecs_clusters.md)
- [aws_flow_log](docs/resources/aws_flow_log.md)
- [aws_iam_access_key](docs/resources/aws_iam_access_key.md)
- [aws_iam_access_keys](docs/resources/aws_iam_access_keys.md)
- [aws_iam_group](docs/resources/aws_iam_group.md)
- [aws_iam_password_policy](docs/resources/aws_iam_password_policy.md)
- [aws_iam_policies](docs/resources/aws_iam_policies.md)
- [aws_iam_policy](docs/resources/aws_iam_policy.md)
- [aws_iam_role](docs/resources/aws_iam_role.md)
- [aws_iam_roles](docs/resources/aws_iam_roles.md)
- [aws_iam_root_user](docs/resources/aws_iam_root_user.md)
- [aws_iam_user](docs/resources/aws_iam_user.md)
- [aws_iam_users](docs/resources/aws_iam_users.md)
- [aws_kms_key](docs/resources/aws_kms_key.md)
- [aws_kms_keys](docs/resources/aws_kms_keys.md)
- [aws_rds_instance](docs/resources/aws_rds_instance.md)
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
- [aws_subnet](docs/resources/aws_subnet.md)
- [aws_subnets](docs/resources/aws_subnets.md)
- [aws_vpc](docs/resources/aws_vpc.md)
- [aws_vpcs](docs/resources/aws_vpcs.md)

## Examples

##### Test that an EC2 instance is running & using the correct AMI

    describe aws_ec2_instance(name: 'ProdWebApp') do
      it              { should be_running }
      its('image_id') { should eq 'ami-27a58d5c' }
    end
    
##### Ensure all AWS Users have MFA enabled
      
      describe aws_iam_users.where( has_mfa_enabled: false) do
        it { should_not exist }
      end

## Environment and Setup Notes

#### Train and InSpec Dependencies

At the time of writing, this Resource Pack's [Inspec](https://github.com/inspec/inspec) and [Train](https://github.com/inspec/train) dependencies are ahead of the latest releases. This is the case until these dependencies target v3 of the AWS SDK for Ruby.

In order to use the latest SDK the `aws-sdk` version, we pin to a Github Branch on each of these repositories in our Gemfile.

```
gem 'train', :git => 'https://github.com/inspec/train.git', :branch => 'sp/update-aws-sdk-3'
gem 'inspec', :git => 'https://github.com/inspec/inspec.git', :branch => 'sp/remove-aws-resources'
```

The branched InSpec version has all AWS components removed.  
The branched Train version is upgraded to SDK version 3 to avoid the above conflict.  

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

Running the integration tests (after `init_workspace` and `setup_integration_tests`):
```
$ bundle exec rake test:run_integration_tests
----> Run
bundle exec inspec exec test/integration/verify --attrs test/integration/build/aws-inspec-attributes.yaml; rc=$?; if [ $rc -eq 0 ] || [ $rc -eq 101 ]; then exit 0; else exit 1; fi

Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  local://

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


Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  local://

     No tests executed.

Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 13 successful, 0 failures, 0 skipped
```



<RF Reviewed to here. Below unreviewed.>




## Discussion Points

### Train and InSpec Update Options

At the time of writing the proposal would be to do the following:
1. Update train AWS transport to SDK3 (TBD whether or not to upgrade existing AWS components in InSpec initially)
2. Remove AWS components from InSpec, use classes within `inspec-aws` as a replacement
3. TBD - instead of relying on train, use connection logic within the resource pack for AWS client instantiation.

The thinking behind 3. is to decouples the resource pack from the train release cycle.  This also simplifies testing and makes it easier to supply additional options at client instantiation e.g. for switching endpoints.


## Resource Unit tests

Neither `inspec-gcp` or `inspec-azure` have resource unit tests and have instead opted for integration tests only.  However, unit tests can be useful for parameter validation and exception checking/handling.  For example:

```
describe aws_vpc( vpc_id: 'vpc-not-formatted-correctly-123') do
   it { should_not exist }
end
```

By design the original implementation of the above throws a source code error (ArgumentError) but this cannot be easily triggered as part of integration tests. 

Therefore, pursuing minimal unit tests for the gaps not covered by integration seems prudent as a starting point.  Simple stubbing can be achieved via the AWS SDK e.g.
[https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/stubbing.html]
This will allow more rapid development of new resources.

##  Plural singular resource woes 

VPCs have a function to describe 'all'.  This fine but we have to artificially restrict results for singular resources.  The plural resource could cache everything from one API interaction as an improvement.  Same thing often happens in GCP / AWS.

For background, I was trying to expose filtering by tags for the singular resource.  When only one VPC applies this isn't an issue, however, should several apply, we end up in a mess.
```
    filter = opts[:filter] if opts[:filter]
    
    # can't offer the filter for singular resource here in case >1 results are returned
    
    describe aws_vpc( filter: { name: 'tag:Name', values: [aws_vpc_name] } ) do
    ...
```

## Accepting scalar arguments

Originally it was possible to supply single string args as a default.  For example:

```
describe aws_vpc('vpc-id') do
# instead of forcing the more explicit
describe aws_vpc( vpc_id: 'vpc-id') do
```

This is supported for simplicity but perhaps it would be worth removing the option altogether? 
