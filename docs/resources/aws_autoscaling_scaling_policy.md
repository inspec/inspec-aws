---
title: About the aws_autoscaling_scaling_policy Resource
platform: aws
---

# aws\_autoscaling\_scaling\_policy

Use the `aws_autoscaling_scaling_policy` InSpec audit resource to test properties of a single specific AutoScaling Scaling Policy.

The AWS::AutoScaling::ScalingPolicy resource specifies an Amazon EC2 Auto Scaling scaling policy so that the Auto Scaling group can change the number of instances available for your application in response to changing demand.

## Syntax

Ensure that an auto scaling group name exists.
    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test1') do
      it { should exist }
    end

## Parameters

`auto_scaling_group_name` _(required)_

For additional information, see the [AWS documentation on AutoScaling Scaling Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description|
| --- | --- |
| auto_scaling_group_name |  The name of the Auto Scaling group. |
| policy_name | The names of one or more policies. If you omit this parameter, all policies are described. |
| policy_arn | The arn of the Auto Scaling group. |
| policy_type | One or more policy types. The valid values are SimpleScaling, StepScaling, and TargetTrackingScaling. |
| adjustment_type | The adjustment type of the Auto Scaling group. |
| min_adjustment_step | The min adjustment step of the Auto Scaling group. |
| min_adjustment_magnitude | The min adjustment magnitude of the Auto Scaling group. |
| scaling_adjustment | The scaling adjustment of the Auto Scaling group. |
| cooldown | The cooldown of the Auto Scaling group. |
| step_adjustments | The step adjustments of the Auto Scaling group. |
| metric_aggregation_type | The metric aggregation type of the Auto Scaling group. |
| estimated_instance_warmup | The estimated instance warmup of the Auto Scaling group. |
| target_tracking_configuration | The target tracking configuration of the Auto Scaling group. |
| enabled | The enabled of the Auto Scaling group. |
| alarms | The alarms of the Auto Scaling group. |

## Examples

### Ensure an auto scaling group name is available.
    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test1') do
      its('auto_scaling_group_name') { should eq 'test1' }
    end

### Ensure that the policy_type is available.
    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test1') do
        its('policy_type') { should eq 'TargetTrackingScaling' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the auto scaling group name is available.

    describe aws_autoscaling_scaling_policy(auto_scaling_group_name: 'test1') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `autoscaling:client:describe_policies` action with `Effect` set to `Allow`.