+++
title = "aws_cloudwatch_metric_streams Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatch_metric_streams"
identifier = "inspec/resources/aws/aws_cloudwatch_metric_streams Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_metric_streams` InSpec audit resource to test properties of multiple AWS CloudWatch metric streams.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudWatch metric stream.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-metricstream.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the metric streams exists.

```ruby
describe aws_cloudwatch_metric_streams do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`arns`
: The ARN of the metric stream.

: **Field**: `arn`

`creation_date`
: The date that the metric stream was originally created.

: **Field**: `creation_date`

`last_update_date`
: The date that the configuration of this metric stream was most recently updated.

: **Field**: `last_update_date`

`names`
: The name of the metric stream.

: **Field**: `name`

`firehose_arns`
: The ARN of the Kinesis Firehose delivery stream that is used for this metric stream.

: **Field**: `firehose_arn`

`states`
: The current state of this stream. Valid values are running and stopped .

: **Field**: `state`

`output_formats`
: The output format of this metric stream. Valid values are 'json' and 'opentelemetry0.7'.

: **Field**: `output_format`

## Examples

**Ensure an ARN is available.**

```ruby
describe aws_cloudwatch_metric_streams do
  its('arns') { should include 'ARN' }
end
```

**Ensure a Firehose ARN is available.**

```ruby
describe aws_cloudwatch_metric_streams do
    its('firehose_arns') { should include 'FIREHOSE_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatch_metric_streams do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_cloudwatch_metric_streams do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListMetricStreamsOutput" %}}
