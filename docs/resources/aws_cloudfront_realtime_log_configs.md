---
title: About the aws_cloudfront_realtime_log_configs Resource
platform: aws
---

# aws_cloudfront_realtime_log_configs

Use the `aws_cloudfront_realtime_log_configs` InSpec audit resource to test multiple AWS CloudFront real-time log configurations.

The `AWS::CloudFront::RealtimeLogConfig` resource creates a real-time log configuration.

## Syntax

Ensure that the config exists.

    describe aws_cloudfront_realtime_log_configs do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront RealtimeLogConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| arns | The Amazon Resource Name (ARN) of this real-time log configuration. | arn |
| names | The unique name of this real-time log configuration. | name |
| sampling_rates | The sampling rate for this real-time log configuration. | sampling_rate |
| end_points | Contains information about the Amazon Kinesis data stream where you are sending real-time log data for this real-time log configuration. | end_points |
| fields | A list of fields that are included in each real-time log record. | fields |

## Examples

### Ensure an ARN is available.

    describe aws_cloudfront_realtime_log_configs do
      its('arns') { should include 'ARN' }
    end

### Ensure a name is available.

    describe aws_cloudfront_realtime_log_configs do
        its('names') { should include 'CONFIG_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_realtime_log_configs do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_realtime_log_configs do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_realtime_log_configs do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListRealtimeLogConfigsResult` action with `Effect` set to `Allow`.
