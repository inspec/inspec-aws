+++
title = "aws_cloudtrail_trail Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudtrail_trail"
identifier = "inspec/resources/aws/aws_cloudtrail_trail Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudtrail_trail` InSpec audit resource to test properties of a single AWS CloudTrail.

## Installation

{{% inspec_aws_install %}}

## Syntax

An `aws_cloudtrail_trail` resource block identifies a trail by `TRIAL_NAME`.

# Find a trail by name
```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  it { should exist }
end
```

# Hash syntax for trail name
```ruby
describe aws_cloudtrail_trail(TRIAL_NAME: 'TRIAL_NAME') do
  it { should exist }
end
```

## Parameters

`trial_name` _(required)_
: This resource expects a single parameter, the CloudTrail Name which uniquely identifies it. 
  This can be passed either as a string or as a `trial_name: 'value'` key-value entry in a hash.

See also the [AWS documentation on CloudTrail](https://docs.aws.amazon.com/cloudtrail/index.html#lang/en_us).

## Properties

`trail_arn`
: Specifies the ARN of the trail.

`trial_name`
: Name of the trail.

`home_region`
: The region in which the trail was created.

`s3_bucket_name`
: Name of the Amazon S3 bucket into which CloudTrail delivers your trail files.

`cloud_watch_logs_role_arn`
: Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.

`cloud_watch_logs_log_group_arn`
: Specifies an Amazon Resource Name (ARN), a unique identifier that represents the log group to which CloudTrail logs will be delivered.

`kms_key_id`
: Specifies the KMS key ID that encrypts the logs delivered by CloudTrail.

`s3_key_prefix`
: Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery.

`is_organization_trail`
: Specifies whether the trail is an organization trail. It returns boolean value.

## Examples

**Test that the specified trail does exist.**

```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  it { should exist }
end
```

```ruby
describe aws_cloudtrail_trail(TRIAL_NAME: 'TRIAL_NAME') do
  it { should exist }
end
```

**Check the KMS key used to encrypt.**

```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  its('kms_key_id') { should eq "KMS_KEY_ID" }
end
```

**Check the home region is correct.**

```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  its('home_region') { should eq 'us-east-1' }
end
```

**Test that the specified trail is a multi-region trail.**

```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  it { should be_multi_region_trail }
end
```

**Test that the specified trail is a organization trail.**

```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  its("is_organization_trail") { should eq true }
  it { should be_organization_trail }
end
```

**Test that the specified trail has a S3 Key Prefix.**

```ruby
describe aws_cloudtrail_trail('TRIAL_NAME') do
  its("s3_key_prefix") { should eq 'S3_KEY_PREFIX_NAME' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

The control will pass if the describe returns at least one result.

# Verify that at least one CloudTrail Trail exists.
```ruby
describe aws_cloudtrail_trail('TRAIL_NAME') do
  it { should exist }
end
```

### not exist

# Verify that CloudTrail Trail does not exists.
```ruby
describe aws_cloudtrail_trail('TRAIL_NAME') do
  it { should_not exist }
end
```

#### be_multi_region_trail
The test will pass if the identified trail is a multi-region trail.

```ruby
describe aws_cloudtrail_trail('TRAIL_NAME') do
  it { should be_multi_region_trail }
end
```

#### be_encrypted

The test will pass if the logs delivered by the identified trail are encrypted.

```ruby
describe aws_cloudtrail_trail('TRAIL_NAME') do
  it { should be_encrypted }
end
```

#### be_log_file_validation_enabled

The test will pass if the identified trail has log file integrity validation is enabled.

```ruby
describe aws_cloudtrail_trail('TRAIL_NAME') do
  it { should be_log_file_validation_enabled }
end
```

## AWS Permissions

{{% aws_permissions_principal action="CloudTrail:Client:DescribeTrailsResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awscloudtrail.html).
