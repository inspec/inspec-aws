+++
title = "aws_autoscaling_scaling_policies resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_autoscaling_scaling_policies"
identifier = "inspec/resources/aws/aws_autoscaling_scaling_policies resource"
parent = "inspec/resources/aws"
+++

Use the `aws_autoscaling_scaling_policies` InSpec audit resource to test properties of multiple Amazon EC2 Auto Scaling scaling policies.

For additional information, including details on parameters and properties, see the [AWS AutoScaling Scaling Policy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html).

## Syntax

Ensure that an auto scaling group name exists.

```ruby
describe aws_autoscaling_scaling_policies do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`auto_scaling_group_names`
: The name of an Auto Scaling group.

`policy_names`
: The names of one or more policies. If you omit this parameter, all policies are described.

`policy_arns`
: The ARN of the Auto Scaling group.

`policy_types`
: One or more policy types. The valid values are `SimpleScaling`, `StepScaling`, and `TargetTrackingScaling`.

`adjustment_types`
: The adjustment type of the Auto Scaling group.

`min_adjustment_steps`
: The minimum adjustment step of the Auto Scaling group.

`min_adjustment_magnitudes`
: The minimum adjustment magnitude of the Auto Scaling group.

`scaling_adjustments`
: The scaling adjustment of the Auto Scaling group.

`cooldowns`
: The cooldown period of the Auto Scaling group.

`step_adjustments`
: The step adjustments of the Auto Scaling group.

`metric_aggregation_types`
: The aggregation type for CloudWatch metrics of the Auto Scaling group.

`estimated_instance_warmups`
: The estimated warmup time of the Auto Scaling group until a new instance can contribute to CloudWatch metrics.

`target_tracking_configurations`
: The target tracking configuration of the Auto Scaling group.

## Examples

**Ensure an auto scaling group name is available.**

```ruby
describe aws_autoscaling_scaling_policies do
  its('auto_scaling_group_names') { should include 'AUTO_SCALING_GROUP_NAME' }
end
```

**Ensure that the policy types are available.**

```ruby
describe aws_autoscaling_scaling_policies do
    its('policy_types') { should include 'POLICY_TYPE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_autoscaling_scaling_policies do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_autoscaling_scaling_policies do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_autoscaling_scaling_policies do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="AutoScaling:client:PoliciesType" %}}
