---
title: About the aws_cloudwatch_metric_stream Resource
platform: aws
---

# aws_cloudwatch_metric_stream

Use the `aws_cloudwatch_metric_stream` InSpec audit resource to test properties of the plural AWS CloudWatch Metric Stream.

## Syntax

Ensure that the identity exists.

    describe aws_cloudwatch_metric_stream (metric_stream_name:  'MetricStreamName' ) do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront CloudFrontOriginAccessIdentity.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-monitoring.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| arn | The ARN of the metric stream. | arn |
| creation_date | The date that the metric stream was originally created. | creation_date |
| last_update_date | The date that the configuration of this metric stream was most recently updated. | last_update_date |
| names | The name of the metric stream.| name |
| firehose_arn | The ARN of the Kinesis Firehose delivery stream that is used for this metric stream. | firehose_arn |
| state | The current state of this stream. Valid values are running and stopped . | state |
| output_format | The output format of this metric stream. Valid values are json and opentelemetry0.7 | output_format |



## Examples

### Ensure an arns is available.
    describe aws_cloudwatch_metric_stream (metric_stream_name:  'MetricStreamName' ) do
      its('arn') { should eq 'ARN' }
    end

### Ensure a firehose_arn is available.
    describe aws_cloudwatch_metric_stream (metric_stream_name:  'MetricStreamName' ) do
        its('firehose_arn') { should eq 'FIREHOSEARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_metric_stream (metric_stream_name:  'MetricStreamName' ) do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_metric_stream (metric_stream_name:  'MetricStreamName' ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetMetricStreamsOutput` action with `Effect` set to `Allow`.