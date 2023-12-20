+++
title = "aws_cloudfront_realtime_log_config Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudfront_realtime_log_config"
identifier = "inspec/resources/aws/aws_cloudfront_realtime_log_config Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_realtime_log_config` InSpec audit resource to test properties of a single specific AWS CloudFront real-time log configuration.

The `AWS::CloudFront::RealtimeLogConfig` resource creates a real-time log configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront RealtimeLogConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the config exists.

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: The unique name of this real-time log configuration.

## Properties

`arn`
: The Amazon Resource Name (ARN) of this real-time log configuration.

`name`
: The unique name of this real-time log configuration.

`sampling_rate`
: The sampling rate for this real-time log configuration.

`end_points`
: Contains information about the Amazon Kinesis data stream where you are sending real-time log data for this real-time log configuration.

`end_points_stream_types`
: The type of data stream where you are sending real-time log data. The only valid value is Kinesis.

`end_points_kinesis_stream_config_role_arns`
: The Amazon Resource Name (ARN) of an Identity and Access Management (IAM) role that CloudFront can use to send real-time log data to your Kinesis data stream.

`end_points_kinesis_stream_config_stream_arns`
: The Amazon Resource Name (ARN) of the Kinesis data stream where you are sending real-time log data.

`fields`
: A list of fields that are included in each real-time log record.

## Examples

**Ensure an ARN is available.**

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
  its('arn') { should eq 'ARN' }
end
```

**Ensure a name is available.**

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
    its('name') { should eq 'CONFIG_NAME' }
end
```

**Ensure a stream type is `Kinesis`.**

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
    its('end_points_stream_types') { should include 'Kinesis' }
end
```

**Ensure a stream ARN is available.**

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
    its('end_points_kinesis_stream_config_stream_arns') { should include 'STREAM_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:GetRealtimeLogConfigResult" %}}
