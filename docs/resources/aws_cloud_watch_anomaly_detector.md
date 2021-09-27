---
title: About the aws_cloud_watch_anomaly_detector Resource
platform: aws
---

# aws_cloud_watch_anomaly_detector

Use the `aws_cloud_watch_anomaly_detector` InSpec audit resource to test properties of a single specific AWS CloudWatch AnomalyDetector.

The AWS::CloudWatch::AnomalyDetector type specifies an anomaly detection band for a certain metric and statistic. The band represents the expected "normal" range for the metric values. Anomaly detection bands can be used for visualization of a metric's expected values, and for alarms.

## Syntax

Ensure that the anomaly detector exists.

    describe aws_cloud_watch_anomaly_detector(metric_name: 'MetricName') do
      it { should exist }
    end

## Parameters

`metric_name` _(required)_

| Property | Description |
| --- | --- |
| metric_name | The name of the metric associated with the anomaly detection model. |

For additional information, see the [AWS documentation on AWS CloudWatch AnomalyDetector.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-anomalydetector.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| namespace | The namespace of the metric associated with the anomaly detection model. | namespace |
| metric_name | The name of the metric associated with the anomaly detection model. | metric_name |
| dimensions | The metric dimensions associated with the anomaly detection model. | dimensions |
| dimensions_names | The name of the dimension. | name |
| dimensions_values | The value of the dimension. | value |
| stat | The statistic associated with the anomaly detection model. | stat |
| configuration_start_time | The start time of the range to exclude. | start_time |
| configuration_end_time | The end time of the range to exclude. | end_time |
| configuration.metric_timezone | The time zone to use for the metric. | metric_timezone |
| state_value | he current status of the anomaly detector's training. The possible values are TRAINED, PENDING_TRAINING and TRAINED_INSUFFICIENT_DATA. | state_value |

## Examples

### Ensure a namespace is available.
    describe aws_cloud_watch_anomaly_detector(metric_name: 'MetricName') do
      its('namespace') { should eq 'Namespace' }
    end

### Ensure a name is available.
    describe aws_cloud_watch_anomaly_detector(metric_name: 'MetricName') do
        its('name') { should eq 'ConfigName' }
    end

### Ensure a dimension name is available.
    describe aws_cloud_watch_anomaly_detector(metric_name: 'MetricName') do
        its('dimensions_names') { should include 'DimensionName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloud_watch_anomaly_detector(metric_name: 'MetricName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloud_watch_anomaly_detector(metric_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloud_watch_anomaly_detector(metric_name: 'MetricName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:DescribeAnomalyDetectorsOutput` action with `Effect` set to `Allow`.