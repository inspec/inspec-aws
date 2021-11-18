---
title: About the aws_cloudwatch_metric_streams Resource
platform: aws
---

# aws_cloudwatch_metric_streams

Use the `aws_cloudwatch_metric_streams` InSpec audit resource to test properties of multiple AWS CloudWatch metric streams.

## Syntax

Ensure that the metric streams exists.

    describe aws_cloudwatch_metric_streams do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudWatch metric stream.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-metricstream.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| arns | The ARN of the metric stream. | arn |
| creation_date | The date that the metric stream was originally created. | creation_date |
| last_update_date | The date that the configuration of this metric stream was most recently updated. | last_update_date |
| names | The name of the metric stream.| name |
| firehose_arns | The ARN of the Kinesis Firehose delivery stream that is used for this metric stream. | firehose_arn |
| states | The current state of this stream. Valid values are running and stopped . | state |
| output_formats | The output format of this metric stream. Valid values are 'json' and 'opentelemetry0.7' | output_format |

## Examples

### Ensure an ARN is available.

    describe aws_cloudwatch_metric_streams do
      its('arns') { should include 'ARN' }
    end

### Ensure a Firehose ARN is available.

    describe aws_cloudwatch_metric_streams do
        its('firehose_arns') { should include 'FIREHOSE_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_metric_streams do
      it { should exist }
    end

Use `should_not` to test that the entity does not exist.

    describe aws_cloudwatch_metric_streams do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListMetricStreamsOutput` action with `Effect` set to `Allow`.
