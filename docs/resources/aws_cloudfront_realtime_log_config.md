---
title: About the aws_cloudfront_realtime_log_config Resource
platform: aws
---

# aws_cloudfront_realtime_log_config

Use the `aws_cloudfront_realtime_log_config` InSpec audit resource to test properties of a single specific AWS CloudFront real-time log configuration.

The `AWS::CloudFront::RealtimeLogConfig` resource creates a real-time log configuration.

## Syntax

Ensure that the config exists.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
      it { should exist }
    end

## Parameters

`name` _(required)_

The unique name of this real-time log configuration.

For additional information, see the [AWS documentation on AWS CloudFront RealtimeLogConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-realtimelogconfig.html).

## Properties

| Property | Description |
| :---: | :--- |
| arn | The Amazon Resource Name (ARN) of this real-time log configuration. |
| name | The unique name of this real-time log configuration. |
| sampling_rate | The sampling rate for this real-time log configuration. |
| end_points | Contains information about the Amazon Kinesis data stream where you are sending real-time log data for this real-time log configuration. |
| end_points_stream_types | The type of data stream where you are sending real-time log data. The only valid value is Kinesis. |
| end_points_kinesis_stream_config_role_arns | The Amazon Resource Name (ARN) of an Identity and Access Management (IAM) role that CloudFront can use to send real-time log data to your Kinesis data stream. |
| end_points_kinesis_stream_config_stream_arns | The Amazon Resource Name (ARN) of the Kinesis data stream where you are sending real-time log data. |
| fields | A list of fields that are included in each real-time log record. |

## Examples

### Ensure an ARN is available.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
      its('arn') { should eq 'ARN' }
    end

### Ensure a name is available.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
        its('name') { should eq 'CONFIG_NAME' }
    end

### Ensure a stream type is `Kinesis`.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
        its('end_points_stream_types') { should include 'Kinesis' }
    end

### Ensure a stream ARN is available.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
        its('end_points_kinesis_stream_config_stream_arns') { should include 'STREAM_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_realtime_log_config(name: 'CONFIG_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetRealtimeLogConfigResult` action with `Effect` set to `Allow`.
