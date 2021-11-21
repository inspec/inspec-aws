---
title: About the aws_cloudwatch_composite_alarms Resource
platform: aws
---

# aws_cloudwatch_composite_alarms

Use the `aws_cloudwatch_composite_alarms` InSpec audit resource to test properties of multiple AWS CloudWatch composite alarms.

The `AWS::CloudWatch::CompositeAlarm` resource type creates or updates a composite alarm. When you create a composite alarm, you specify a rule expression for the alarm that takes into account the alarm states of other alarms that you have created. The composite alarm goes into ALARM state only if all conditions of the rule are met.

## Syntax

Ensure that the alarms exists.

    describe aws_cloudwatch_composite_alarms do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudWatch composite alarm.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-compositealarm.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| actions_enabled | Indicates whether actions should be executed during any changes to the alarm state. | actions_enabled |
| alarm_actions | The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN). | alarm_actions |
| alarm_arns | The Amazon Resource Name (ARN) of the alarm. | alarm_arn |
| alarm_configuration_updated_timestamp | The time stamp of the last update to the alarm configuration. | alarm_configuration_updated_timestamp |
| alarm_descriptions | The description of the alarm. | alarm_description |
| alarm_names | The name of the alarm. | alarm_name |
| alarm_rules | The rule that this alarm uses to evaluate its alarm state. | alarm_rule |
| insufficient_data_actions | The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN). | insufficient_data_actions |
| ok_actions | The actions to execute when this alarm transitions to the OK state from any other state. Each action is specified as an Amazon Resource Name (ARN). | ok_actions |
| state_reasons | An explanation for the alarm state, in text format. | state_reason |
| state_reason_data | An explanation for the alarm state, in JSON format. | state_reason_data |
| state_updated_timestamp | The time stamp of the last update to the alarm state. | state_updated_timestamp |
| state_values | The state value for the alarm. | state_value |

## Examples

### Ensure an actions is enabled.

    describe aws_cloudwatch_composite_alarms do
      its('actions_enabled') { should include true }
    end

### Ensure an alarm arn is available.

    describe aws_cloudwatch_composite_alarms do
        its('alarm_arns') { should include 'ALARM_ARN' }
    end

### Ensure an alarm name is available.

    describe aws_cloudwatch_composite_alarms do
        its('alarm_names') { should include 'ALARM_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_composite_alarms do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_cloudwatch_composite_alarms do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:DescribeAlarmsOutput` action with `Effect` set to `Allow`.