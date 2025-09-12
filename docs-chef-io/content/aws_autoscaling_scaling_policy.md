+++
title = "aws_autoscaling_scaling_policy resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_autoscaling_scaling_policy"
identifier = "inspec/resources/aws/aws_autoscaling_scaling_policy resource"
parent = "inspec/resources/aws"
+++

Use the `aws_autoscaling_scaling_policy` InSpec audit resource to test properties of a single Amazon EC2 Auto Scaling scaling policy.

For additional information, including details on parameters and properties, see the [AWS AutoScaling Scaling Policy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html).

## Syntax

Ensure that an auto scaling group name exists.

```ruby
describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'AUTO_SCALING_GROUP_NAME') do
  it { should exist }
end
```

## Parameters

`auto_scaling_group_name` _(required)_

: The name or Amazon Resource Name (ARN) of the Auto Scaling group that has a scaling policy.

## Properties

`auto_scaling_group_name`
: The name of the Auto Scaling group.

`policy_name`
: The names of one or more policies. If you omit this parameter, all policies are described.

`policy_arn`
: The ARN of the Auto Scaling group.

`policy_type`
: One or more policy types. The valid values are `SimpleScaling`, `StepScaling`, and `TargetTrackingScaling`.

`adjustment_type`
: The adjustment type of the Auto Scaling group.

`min_adjustment_step`
: The minimum adjustment step of the Auto Scaling group.

`min_adjustment_magnitude`
: The minimum adjustment magnitude of the Auto Scaling group.

`scaling_adjustment`
: The scaling adjustment of the Auto Scaling group.

`cooldown`
: The cooldown period of the Auto Scaling group.

`step_adjustments`
: The step adjustments of the Auto Scaling group.

`metric_aggregation_type`
: The aggregation type for CloudWatch metrics of the Auto Scaling group.

`estimated_instance_warmup`
: The estimated warmup time of the Auto Scaling group until a new instance can contribute to CloudWatch metrics.

`target_tracking_configuration`
: The target tracking configuration of the Auto Scaling group.

`enabled`
: Whether the scaling policy is enabled or disabled.

`alarms`
: The alarms of the Auto Scaling group.

## Examples

**Ensure an auto scaling group name is available.**

```ruby
describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'AUTO_SCALING_GROUP_NAME') do
  its('auto_scaling_group_name') { should eq 'AUTO_SCALING_GROUP_NAME' }
end
```

**Ensure that the policy type is available.**

```ruby
describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'AUTO_SCALING_GROUP_NAME') do
    its('policy_type') { should eq 'TargetTrackingScaling' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'AUTO_SCALING_GROUP_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'AUTO_SCALING_GROUP_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the auto scaling group name is available.

```ruby
describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'AUTO_SCALING_GROUP_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="AutoScaling:client:PoliciesType" %}}
