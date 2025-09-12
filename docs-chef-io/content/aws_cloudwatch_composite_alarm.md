+++
title = "aws_cloudwatch_composite_alarm resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudwatch_composite_alarm"
identifier = "inspec/resources/aws/aws_cloudwatch_composite_alarm resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_composite_alarm` InSpec audit resource to test properties of a single specific AWS CloudWatch composite alarm.

The `AWS::CloudWatch::CompositeAlarm` resource type creates or updates a composite alarm. When you create a composite alarm, you specify a rule expression for the alarm that takes into account the alarm states of other alarms that you have created. The composite alarm goes into ALARM state only if all conditions of the rule are met.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudWatch composite alarm.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-compositealarm.html).

## Syntax

Ensure that the config exists.

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
  it { should exist }
end
```

## Parameters

`alarm_name` _(required)_

: The name of the alarm.

## Properties

`actions_enabled`
: Indicates whether actions should be executed during any changes to the alarm state.

`alarm_actions`
: The actions to execute when this alarm transitions to the ALARM state from any other state. Each action is specified as an Amazon Resource Name (ARN).

`alarm_arn`
: The Amazon Resource Name (ARN) of the alarm.

`alarm_configuration_updated_timestamp`
: The time stamp of the last update to the alarm configuration.

`alarm_description`
: The description of the alarm.

`alarm_name`
: The name of the alarm.

`alarm_rule`
: The rule that this alarm uses to evaluate its alarm state.

`insufficient_data_actions`
: The actions to execute when this alarm transitions to the INSUFFICIENT_DATA state from any other state. Each action is specified as an Amazon Resource Name (ARN).

`ok_actions`
: The actions to execute when this alarm transitions to the OK state from any other state. Each action is specified as an Amazon Resource Name (ARN).

`state_reason`
: An explanation for the alarm state, in text format.

`state_reason_data`
: An explanation for the alarm state, in JSON format.

`state_updated_timestamp`
: The time stamp of the last update to the alarm state.

`state_value`
: The state value for the alarm.

## Examples

Ensure an actions is enabled:

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
  its('actions_enabled') { should eq true }
end
```

Ensure an alarm ARN is available:

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
    its('alarm_arn') { should eq 'ALARM_ARN' }
end
```

Ensure an alarm name is available:

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
    its('alarm_name') { should eq 'ALARM_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudwatch_composite_alarm(alarm_name: 'COMPOSITE_ALARM_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatch:Client:DescribeAlarmsOutput" %}}
