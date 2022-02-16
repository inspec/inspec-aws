---
title: About the aws_cloudwatch_alarm Resource
platform: aws
---

# aws_cloudwatch_alarm

Use the `aws_cloudwatch_alarm` InSpec audit resource to test properties of a single CloudWatch Alarm.

**If more than one Alarm matches, an error will be raised.**

## Syntax

##### Ensure an Alarm exists.

      aws_cloudwatch_alarm(metric_name: 'METRIC_NAME', metric_namespace: 'METRIC_NAMESPACE') do
        it { should exist }
      end
      
#### Parameters

`metric_name` _(required)_

The metric name used by this alarm. This must be passed as a `metric_name: 'value'` key-value entry in a hash.

`metric_namespace` _(required)_

The metric namespace used by this alarm. This must be passed as a `metric_namespace: 'value'` key-value entry in a hash.

`dimensions` _(optional)_

The dimensions associated with this alarm. This must be passed as an array of hashes `dimensions: [{key:'value'}]`.

## Properties

| Property | Description |
| :---: | :--- |
|alarm_actions    | The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN).  |
|alarm_name       | The name of the alarm. |
|metric_name      | The name of the metric. |
|metric_namespace | The namespace of the metric. |

## Examples

##### Ensure an Alarm has at least one alarm action

    aws_cloudwatch_alarm(metric_name: 'METRIC_NAME', metric_namespace: 'METRIC_NAMESPACE') do
      its('alarm_actions') { should_not be_empty }
    end
    
##### Ensure an Alarm with Dimensions exists

    describe aws_cloudwatch_alarm(metric_name: 'METRIC_NAME', metric_namespace: 'METRIC_NAMESPACE', dimensions: [{key: 'value'}]) do
      it { should exist }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    aws_cloudwatch_alarm(metric_name: 'METRIC_NAME', metric_namespace: 'METRIC_NAMESPACE') do
      it { should exist }
    end

    aws_cloudwatch_alarm(metric_name: 'METRIC_NAME', metric_namespace: 'METRIC_NAMESPACE') do
      it { should_not exist }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:DescribeAlarmsForMetricOutput` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html).
