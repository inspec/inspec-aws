---
title: About the aws_cloudwatch_alarm Resource
platform: aws
---

# aws\_cloudwatch\_alarm

Use the `aws_cloudwatch_alarm` InSpec audit resource to test properties of a single Cloudwatch Alarm.

Cloudwatch Alarms are currently identified using the metric name and metric namespace. Future work may allow other approaches to identifying alarms.

<br>

## Syntax

An `aws_cloudwatch_alarm` resource block searches for a Cloudwatch Alarm, specified by several search options. If more than one Alarm matches, an error occurs.

    # Look for a specific alarm
    aws_cloudwatch_alarm(
      metric_name: 'my-metric-name',
      metric_namespace: 'my-metric-namespace',
    ) do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Ensure an Alarm has at least one alarm action

    describe aws_cloudwatch_alarm(
      metric_name: 'my-metric-name',
      metric_namespace: 'my-metric-namespace',
    ) do
      its('alarm_actions') { should_not be_empty }
    end

<br>

## Properties

* `alarm_actions`

## Property Examples

### alarm\_actions

`alarm_actions` returns a list of strings. Each string is the ARN of an action that will be taken should the alarm be triggered.

    # Ensure that the alarm has at least one action
    describe aws_cloudwatch_alarm(
      metric_name: 'bed-metric',
      metric_namespace: 'my-metric-namespace',
    ) do
      its('alarm_actions') { should_not be_empty }
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if a Cloudwatch Alarm could be found. Use `should_not` if you expect zero matches.

    # Expect good metric
    describe aws_cloudwatch_alarm(
      metric_name: 'good-metric',
      metric_namespace: 'my-metric-namespace',
    ) do
      it { should exist }
    end

    # Disallow alarms based on bad-metric
    describe aws_cloudwatch_alarm(
      metric_name: 'bed-metric',
      metric_namespace: 'my-metric-namespace',
    ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudwatch:DescribeAlarmsForMetric` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html).
