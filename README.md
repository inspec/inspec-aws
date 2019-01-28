# inspec-aws 

This is incubation for the new InSpec AWS standalone resource pack.  Below is not intended as an end-user README, it contains notes and discussion points for the implementation. 

## Resources WIP

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
- [aws_flow_log](docs/resources/aws_flow_log.md)
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
- [aws_subnet](docs/resources/aws_subnet.md)
- [aws_subnets](docs/resources/aws_subnets.md)
- [aws_vpc](docs/resources/aws_vpc.md)
- [aws_vpcs](docs/resources/aws_vpcs.md)

## Multi-region support

With CIS certification firmly in mind, the following two controls are good examples of providing multi-region support for operations within InSpec AWS:

- [aws_multi_region_security_group](test/integration/verify/controls/aws_multi_region_security_group.rb)
- [aws_multi_region_config_recorder](test/integration/verify/controls/aws_multi_region_config_recorder.rb)

Sample output:

```

Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  local://

  ✔  aws-multi-region-security-group-1.0: Ensure AWS Security Groups across all regions have the correct properties.
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-south-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-south-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-south-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-south-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-south-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-south-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-west-3 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-west-3 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-west-3 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-west-3 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-west-3 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-west-3 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-north-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-north-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-north-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-north-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-north-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-north-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-west-2 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-west-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-west-2 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-west-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-west-2 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-west-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-west-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-west-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-west-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-west-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-west-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-west-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-northeast-2 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-northeast-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-northeast-2 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-northeast-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-northeast-2 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-northeast-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-northeast-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-northeast-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-northeast-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-northeast-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-northeast-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-northeast-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in sa-east-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in sa-east-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in sa-east-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in sa-east-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in sa-east-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in sa-east-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ca-central-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ca-central-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ca-central-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ca-central-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in ca-central-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in ca-central-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-southeast-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-southeast-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-southeast-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-southeast-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-southeast-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-southeast-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-southeast-2 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in ap-southeast-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-southeast-2 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in ap-southeast-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-southeast-2 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in ap-southeast-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-central-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in eu-central-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-central-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in eu-central-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-central-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in eu-central-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-east-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-east-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-east-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-east-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in us-east-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in us-east-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-east-2 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-east-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-east-2 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-east-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in us-east-2 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in us-east-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-west-1 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-west-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-west-1 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-west-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in us-west-1 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in us-west-1 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-west-2 should exist
     ✔  EC2 Security Group sg-00d511ce91a97f40f in us-west-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-west-2 should exist
     ✔  EC2 Security Group sg-067cd21e928c3a2f1 in us-west-2 should not allow in only {:port=>12345}
     ✔  EC2 Security Group sg-9bb3b9f3 in us-west-2 should exist
     ✔  EC2 Security Group sg-9bb3b9f3 in us-west-2 should not allow in only {:port=>12345}
  ✔  aws-multi-region-config-recorder-1.0: Ensure at least one AWS Configuration Recorder exists across all regions.
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in ap-south-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in eu-west-3 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in eu-north-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in eu-west-2 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in eu-west-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in ap-northeast-2 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in ap-northeast-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in sa-east-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in ca-central-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in ap-southeast-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in ap-southeast-2 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in eu-central-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in us-east-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in us-east-2 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in us-west-1 should exist
     ✔  Configuration Recorder aws-config-recorder-fhzyvtwpeyddhxqflmmsmrvnk in us-west-2 should exist


Profile: Amazon Web Services  Resource Pack (inspec-aws)
Version: 0.1.0
Target:  local://

     No tests executed.

Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 112 successful, 0 failures, 0 skipped
``` 

## Enviroment and Setup Notes

### Train and InSpec Dependencies

In order to use the latest SDK the `aws-sdk` version in train must be updated to avoid conflicts e.g.

```
Bundler could not find compatible versions for gem "aws-sdk":
  In Gemfile:
    aws-sdk (~> 3)

    inspec (>= 3.0.25, ~> 3.0) was resolved to 3.0.52, which depends on
      train (>= 1.5.6, ~> 1.5) was resolved to 1.5.6, which depends on
        aws-sdk (~> 2)
```

For this initial prototype, an explicit dependency on train and inspec is required in the Gemfile.  To make this simpler, add the equivalent of the following to your envrc:

```
export INSPEC_AWS_TRAIN_PATH='/Users/spaterson/Documents/workspace/aws/train'
export INSPEC_AWS_INSPEC_PATH='/Users/spaterson/Documents/workspace/aws/inspec
```

The local InSpec version has all AWS components removed.  The local train version is upgraded to SDK version 3 to avoid the above conflict.  

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
