+++
title = "aws_cloudwatch_composite_alarms Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatch_composite_alarms"
identifier = "inspec/resources/aws/aws_cloudwatch_composite_alarms Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_composite_alarms` InSpec audit resource to test properties of multiple AWS CloudWatch composite alarms.

The `AWS::CloudWatch::CompositeAlarm` resource type creates or updates a composite alarm. When you create a composite alarm, you specify a rule expression for the alarm that takes into account the alarm states of other alarms that you have created. The composite alarm goes into ALARM state only if all conditions of the rule are met.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudWatch composite alarm.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-compositealarm.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the alarms exists.

```ruby
describe aws_cloudwatch_composite_alarms do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`actions_enabled`
: Indicates whether actions should be executed during any changes to the alarm state.

: **Field**: `actions_enabled`

`alarm_actions`
: The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN).

: **Field**: `alarm_actions`

`alarm_arns`
: The Amazon Resource Name (ARN) of the alarm.

: **Field**: `alarm_arn`

`alarm_configuration_updated_timestamp`
: The time stamp of the last update to the alarm configuration.

: **Field**: `alarm_configuration_updated_timestamp`

`alarm_descriptions`
: The description of the alarm.

: **Field**: `alarm_description`

`alarm_names`
: The name of the alarm.

: **Field**: `alarm_name`

`alarm_rules`
: The rule that this alarm uses to evaluate its alarm state.

: **Field**: `alarm_rule`

`insufficient_data_actions`
: The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN).

: **Field**: `insufficient_data_actions`

`ok_actions`
: The actions to execute when this alarm transitions to the OK state from any other state. Each action is specified as an Amazon Resource Name (ARN).

: **Field**: `ok_actions`

`state_reasons`
: An explanation for the alarm state, in text format.

: **Field**: `state_reason`

`state_reason_data`
: An explanation for the alarm state, in JSON format.

: **Field**: `state_reason_data`

`state_updated_timestamp`
: The time stamp of the last update to the alarm state.

: **Field**: `state_updated_timestamp`

`state_values`
: The state value for the alarm.

: **Field**: `state_value`

## Examples

**Ensure an actions is enabled.**

```ruby
describe aws_cloudwatch_composite_alarms do
  its('actions_enabled') { should include true }
end
```

**Ensure an alarm arn is available.**

```ruby
describe aws_cloudwatch_composite_alarms do
    its('alarm_arns') { should include 'ALARM_ARN' }
end
```

**Ensure an alarm name is available.**

```ruby
describe aws_cloudwatch_composite_alarms do
    its('alarm_names') { should include 'ALARM_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatch_composite_alarms do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_cloudwatch_composite_alarms do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatch:Client:DescribeAlarmsOutput" %}}
