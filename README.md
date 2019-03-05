# InSpec for AWS

This InSpec resource pack uses the AWS Ruby SDK v3 and provides the required resources to write tests for resources in AWS.

## Prerequisites

### AWS Credentials

Valid AWS credentials are required, see [AWS Documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal))  

Set your AWS credentials in an `.envrc` file or export them in your shell. (See example [.envrc file](.envrc_example))
    
```bash
    # Example configuration
    export AWS_ACCESS_KEY_ID="AKIAJUMP347SLS66IGCQ"
    export AWS_SECRET_ACCESS_KEY="vD2lfoNvPdwsofqyuO9jRuWUkZIMqisdfeFmkHTy7ON+w"
    export AWS_REGION="eu-west-3"
    export AWS_AVAILABILITY_ZONE="eu-west-3a"  
```

### Permissions
Each resource will require specific permissions to perform the operations required for testing. For example, to test an AWS EC2 instance, your service principal will require the `ec2:DescribeInstances` and `iam:GetInstanceProfile` permissions. You can find a comprehensive list of each resource's required permissions in the [documentation](docs/).

## Use the Resources

Since this is an InSpec resource pack, it only defines InSpec resources. It includes example tests only. To easily use the AWS resources in your tests do the following:

```
$ inspec init profile my-profile
```

Example inspec.yml:

```
name: my-profile
title: My own AWS profile
version: 0.1.0
inspec_version: '>= 2.2.7'
depends:
  - name: inspec-aws
    url: https://github.com/inspec/inspec-aws/archive/master.tar.gz
supports:
  - platform: aws
```

Add some tests and run the profile via:

```
$ inspec exec my-profile -t aws://
```


## Resource documentation
This resouce pack allows the testing of the following AWS resources. If a resource you wish to test is not listed, please feel free to open an [Issue](https://github.com/inspec/inspec-aws/issues). As an open source project, we also welcome public contributions via [Pull Request](https://github.com/inspec/inspec-aws/pulls).

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
- [aws_eks_cluster](docs/resources/aws_eks_cluster.md)
- [aws_eks_clusters](docs/resources/aws_eks_clusters.md)
- [aws_elb](docs/resources/aws_elb.md)
- [aws_flow_log](docs/resources/aws_flow_log.md)
- [aws_iam_access_key](docs/resources/aws_iam_access_key.md)
- [aws_iam_access_keys](docs/resources/aws_iam_access_keys.md)
- [aws_iam_group](docs/resources/aws_iam_group.md)
- [aws_iam_password_policy](docs/resources/aws_iam_password_policy.md)
- [aws_iam_policies](docs/resources/aws_iam_policies.md)
- [aws_iam_policy](docs/resources/aws_iam_policy.md)
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
- [aws_subnet](docs/resources/aws_subnet.md)
- [aws_subnets](docs/resources/aws_subnets.md)
- [aws_vpc](docs/resources/aws_vpc.md)
- [aws_vpcs](docs/resources/aws_vpcs.md)

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

## Support

The InSpec AWS resources are community supported. For bugs and features, please open a github issue and label it appropriately.

## Kudos

This work builds on the InSpec 2 AWS resources that were originally shipped as part of InSpec. 
