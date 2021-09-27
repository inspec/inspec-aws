---
title: About the aws_cloud_watch_composite_alarm Resource
platform: aws
---

# aws_cloud_watch_composite_alarm

Use the `aws_cloud_watch_composite_alarm` InSpec audit resource to test properties of a single specific AWS CloudWatch CompositeAlarm.

The AWS::CloudWatch::CompositeAlarm type creates or updates a composite alarm. When you create a composite alarm, you specify a rule expression for the alarm that takes into account the alarm states of other alarms that you have created. The composite alarm goes into ALARM state only if all conditions of the rule are met.

## Syntax

Ensure that the config exists.

    describe aws_cloud_watch_composite_alarm(alarm_name: 'CompositeAlarmName') do
      it { should exist }
    end

## Parameters

`alarm_name` _(required)_

| Property | Description |
| --- | --- |
| alarm_name | The name of the alarm. |

For additional information, see the [AWS documentation on AWS CloudWatch CompositeAlarm.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-compositealarm.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| actions_enabled | Indicates whether actions should be executed during any changes to the alarm state. | actions_enabled |
| alarm_actions | The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN). | alarm_actions |
| alarm_arn | The Amazon Resource Name (ARN) of the alarm. | alarm_arn |
| alarm_configuration_updated_timestamp | The time stamp of the last update to the alarm configuration. | alarm_configuration_updated_timestamp |
| alarm_description | The description of the alarm. | alarm_description |
| alarm_name | The name of the alarm. | alarm_name |
| alarm_rule | The rule that this alarm uses to evaluate its alarm state. | alarm_rule |
| insufficient_data_actions | The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN). | insufficient_data_actions |
| ok_actions | The actions to execute when this alarm transitions to the OK state from any other state. Each action is specified as an Amazon Resource Name (ARN). | ok_actions |
| state_reason | An explanation for the alarm state, in text format. | state_reason |
| state_reason_data | An explanation for the alarm state, in JSON format. | state_reason_data |
| state_updated_timestamp | The time stamp of the last update to the alarm state. | state_updated_timestamp |
| state_value | The state value for the alarm. | state_value |

## Examples

### Ensure an actions is enabled.
    describe aws_cloud_watch_composite_alarm(alarm_name: 'CompositeAlarmName') do
      its('actions_enabled') { should eq true }
    end

### Ensure an alarm arn is available.
    describe aws_cloud_watch_composite_alarm(alarm_name: 'CompositeAlarmName') do
        its('alarm_arn') { should eq 'AlarmARN' }
    end

### Ensure an alarm name is available.
    describe aws_cloud_watch_composite_alarm(alarm_name: 'CompositeAlarmName') do
        its('alarm_name') { should eq 'AlarmName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloud_watch_composite_alarm(alarm_name: 'CompositeAlarmName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloud_watch_composite_alarm(alarm_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloud_watch_composite_alarm(alarm_name: 'CompositeAlarmName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:DescribeAlarmsOutput` action with `Effect` set to `Allow`.