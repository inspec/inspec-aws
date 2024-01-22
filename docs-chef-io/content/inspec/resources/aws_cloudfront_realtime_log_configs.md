+++
title = "aws_cloudfront_realtime_log_configs Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudfront_realtime_log_configs"
identifier = "inspec/resources/aws/aws_cloudfront_realtime_log_configs Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_realtime_log_configs` InSpec audit resource to test multiple AWS CloudFront real-time log configurations.

The `AWS::CloudFront::RealtimeLogConfig` resource creates a real-time log configuration.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront RealtimeLogConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the config exists.

```ruby
describe aws_cloudfront_realtime_log_configs do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`arns`
: The Amazon Resource Name (ARN) of this real-time log configuration.

: **Field**: `arn`

`names`
: The unique name of this real-time log configuration.

: **Field**: `name`

`sampling_rates`
: The sampling rate for this real-time log configuration.

: **Field**: `sampling_rate`

`end_points`
: Contains information about the Amazon Kinesis data stream where you are sending real-time log data for this real-time log configuration.

: **Field**: `end_points`

`fields`
: A list of fields that are included in each real-time log record.

: **Field**: `fields`

## Examples

**Ensure an ARN is available.**

```ruby
describe aws_cloudfront_realtime_log_configs do
  its('arns') { should include 'ARN' }
end
```

**Ensure a name is available.**

```ruby
describe aws_cloudfront_realtime_log_configs do
    its('names') { should include 'CONFIG_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_realtime_log_configs do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_realtime_log_configs do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudfront_realtime_log_configs do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListRealtimeLogConfigsResult" %}}
