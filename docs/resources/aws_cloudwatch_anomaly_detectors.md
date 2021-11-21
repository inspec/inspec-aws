---
title: About the aws_cloudwatch_anomaly_detectors Resource
platform: aws
---

# aws_cloudwatch_anomaly_detectors

Use the `aws_cloudwatch_anomaly_detectors` InSpec audit resource to test properties of multiple AWS CloudWatch anomaly detectors.

The `AWS::CloudWatch::AnomalyDetector` type specifies an anomaly detection band for a certain metric and statistic. The band represents the expected "normal" range for the metric values. Anomaly detection bands can be used for visualization of a metric's expected values, and for alarms.

## Syntax

Ensure that the anomaly detector exists.

    describe aws_cloudwatch_anomaly_detectors do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS CloudWatch AnomalyDetector.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-anomalydetector.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| namespaces | The namespace of the metric associated with the anomaly detection model. | namespace |
| metric_names | The name of the metric associated with the anomaly detection model. | metric_name |
| dimensions | The metric dimensions associated with the anomaly detection model. | dimensions |
| stats | The statistic associated with the anomaly detection model. | stat |
| configurations | The configuration. | start_time |
| state_values | he current status of the anomaly detector's training. The possible values are TRAINED, PENDING_TRAINING and TRAINED_INSUFFICIENT_DATA. | state_value |

## Examples

### Ensure a namespace is available.

    describe aws_cloudwatch_anomaly_detectors do
      its('namespaces') { should include 'NAMESPACE' }
    end

### Ensure a metric name is available.

    describe aws_cloudwatch_anomaly_detectors do
        its('metric_names') { should include 'METRIC_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_anomaly_detectors do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_anomaly_detectors do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudwatch_anomaly_detectors do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:DescribeAnomalyDetectorsOutput` action with `Effect` set to `Allow`.
