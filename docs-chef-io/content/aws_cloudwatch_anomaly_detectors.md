+++
title = "aws_cloudwatch_anomaly_detectors resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudwatch_anomaly_detectors"
identifier = "inspec/resources/aws/aws_cloudwatch_anomaly_detectors resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_anomaly_detectors` InSpec audit resource to test properties of multiple AWS CloudWatch anomaly detectors.

The `AWS::CloudWatch::AnomalyDetector` type specifies an anomaly detection band for a certain metric and statistic. The band represents the expected "normal" range for the metric values. Anomaly detection bands can be used for visualization of a metric's expected values, and for alarms.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudWatch AnomalyDetector.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-anomalydetector.html).

## Syntax

Ensure that the anomaly detector exists.

```ruby
describe aws_cloudwatch_anomaly_detectors do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`namespaces`
: The namespace of the metric associated with the anomaly detection model.

: **Field**: `namespace`

`metric_names`
: The name of the metric associated with the anomaly detection model.

: **Field**: `metric_name`

`dimensions`
: The metric dimensions associated with the anomaly detection model.

: **Field**: `dimensions`

`stats`
: The statistic associated with the anomaly detection model.

: **Field**: `stat`

`configurations`
: The configuration.

: **Field**: `start_time`

`state_values`
: he current status of the anomaly detector's training. The possible values are TRAINED, PENDING_TRAINING and TRAINED_INSUFFICIENT_DATA.

: **Field**: `state_value`

## Examples

**Ensure a namespace is available.**

```ruby
describe aws_cloudwatch_anomaly_detectors do
  its('namespaces') { should include 'NAMESPACE' }
end
```

**Ensure a metric name is available.**

```ruby
describe aws_cloudwatch_anomaly_detectors do
    its('metric_names') { should include 'METRIC_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatch_anomaly_detectors do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudwatch_anomaly_detectors do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudwatch_anomaly_detectors do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatch:Client:DescribeAnomalyDetectorsOutput" %}}
