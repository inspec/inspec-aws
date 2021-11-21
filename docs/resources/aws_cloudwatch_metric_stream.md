---
title: About the aws_cloudwatch_metric_stream Resource
platform: aws
---

# aws_cloudwatch_metric_stream

Use the `aws_cloudwatch_metric_stream` InSpec audit resource to test properties of a single AWS CloudWatch metric stream.

## Syntax

Ensure that the metric stream exists.

    describe aws_cloudwatch_metric_stream(metric_stream_name: 'METRIC_STREAM_NAME') do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudWatch metric stream.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-metricstream.html).

## Properties

| Property | Description |
| --- | --- |
| arn | The ARN of the metric stream. |
| creation_date | The date that the metric stream was originally created. |
| last_update_date | The date that the configuration of this metric stream was most recently updated. |
| names | The name of the metric stream.|
| firehose_arn | The ARN of the Kinesis Firehose delivery stream that is used for this metric stream. |
| state | The current state of this stream. Valid values are running and stopped. |
| output_format | The output format of this metric stream. Valid values are `json` and `opentelemetry0.7`. |

## Examples

### Ensure an ARN is available.

    describe aws_cloudwatch_metric_stream (metric_stream_name: 'METRIC_STREAM_NAME' ) do
      its('arn') { should eq 'ARN' }
    end

### Ensure a firehose_ARN is available.

    describe aws_cloudwatch_metric_stream (metric_stream_name: 'METRIC_STREAM_NAME' ) do
        its('firehose_arn') { should eq 'FIREHOSE_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_metric_stream (metric_stream_name: 'METRIC_STREAM_NAME' ) do
      it { should exist }
    end

Use `should_not` to test that the entity does not exist.

    describe aws_cloudwatch_metric_stream (metric_stream_name: 'METRIC_STREAM_NAME' ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetMetricStreamsOutput` action with `Effect` set to `Allow`.
