---
title: About the aws_autoscaling_scaling_policies Resource
platform: aws
---

# aws\_autoscaling\_scaling\_policies

Use the `aws_autoscaling_scaling_policies` InSpec audit resource to test properties of multiple Amazon EC2 Auto Scaling scaling policies.

## Syntax

Ensure that an auto scaling group name exists.

    describe aws_autoscaling_scaling_policies do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS AutoScaling Scaling Policy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-policy.html).

## Properties

| Property | Description|
| --- | --- |
| auto_scaling_group_names |  The name of an Auto Scaling group. |
| policy_names | The names of one or more policies. If you omit this parameter, all policies are described. |
| policy_arns | The ARN of the Auto Scaling group. |
| policy_types | One or more policy types. The valid values are `SimpleScaling`, `StepScaling`, and `TargetTrackingScaling`. |
| adjustment_types | The adjustment type of the Auto Scaling group. |
| min_adjustment_steps | The minimum adjustment step of the Auto Scaling group. |
| min_adjustment_magnitudes | The minimum adjustment magnitude of the Auto Scaling group. |
| scaling_adjustments | The scaling adjustment of the Auto Scaling group. |
| cooldowns | The cooldown period of the Auto Scaling group. |
| step_adjustments | The step adjustments of the Auto Scaling group. |
| metric_aggregation_types | The aggregation type for CloudWatch metrics of the Auto Scaling group. |
| estimated_instance_warmups | The estimated warmup time of the Auto Scaling group until a new instance can contribute to CloudWatch metrics. |
| target_tracking_configurations | The target tracking configuration of the Auto Scaling group. |

## Examples

### Ensure an auto scaling group name is available.

    describe aws_autoscaling_scaling_policies do
      its('auto_scaling_group_names') { should include 'AUTO_SCALING_GROUP_NAME' }
    end

### Ensure that the policy types are available.

    describe aws_autoscaling_scaling_policies do
        its('policy_types') { should include 'POLICY_TYPE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_autoscaling_scaling_policies do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_autoscaling_scaling_policies do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.
    describe aws_autoscaling_scaling_policies do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `AutoScaling:client:PoliciesType` action with `Effect` set to `Allow`.
