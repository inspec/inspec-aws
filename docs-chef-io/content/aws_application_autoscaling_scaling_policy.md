+++
title = "aws_application_autoscaling_scaling_policy resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_application_autoscaling_scaling_policy"
identifier = "inspec/resources/aws/aws_application_autoscaling_scaling_policy resource"
parent = "inspec/resources/aws"
+++

Use the `aws_application_autoscaling_scaling_policy` InSpec audit resource to test properties of a single AWS Application Auto Scaling scaling policy.

For additional information, including details on parameters and properties, see the [AWS ApplicationAutoScaling ScalingPolicy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html).

## Syntax

Ensure a scaling policy exists.

```ruby
describe aws_application_autoscaling_scaling_policy( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

## Parameters

`service_namespace` _(required)_

: The namespace of the AWS service that provides the resource, or a custom-resource.

## Properties

`policy_arn`
: The Amazon Resource Name (ARN) of the scaling policy.

`policy_name`
: The name of the scaling policy.

`service_namespace`
: The namespace of the AWS service that provides the resource, or a custom-resource.

`resource_id`
: The identifier of the resource associated with the scaling policy. This string consists of the resource type and unique identifier.

`scalable_dimension`
: The scalable dimension. This string consists of the service namespace, resource type, and scaling property.

`policy_type`
: The Application Auto Scaling policy type.

`step_scaling_policy_configuration (adjustment_type)`
: Specifies how the `ScalingAdjustment` value in a `StepAdjustment` is interpreted (for example, an absolute number or a percentage). The valid values are `ChangeInCapacity` , `ExactCapacity` , and `PercentChangeInCapacity`.

`step_scaling_policy_configuration (step_adjustments)`
: A set of adjustments that enable you to scale based on the size of the alarm breach.

`step_scaling_policy_configuration (step_adjustments (metric_interval_lower_bound))`
: The lower bound for the difference between the alarm threshold and the CloudWatch metric.

`step_scaling_policy_configuration (step_adjustments (metric_interval_upper_bound))`
: The upper bound for the difference between the alarm threshold and the CloudWatch metric.

`step_scaling_policy_configuration (step_adjustments (scaling_adjustment))`
: The amount by which to scale, based on the specified adjustment type.

`step_scaling_policy_configuration (min_adjustment_magnitude)`
: The minimum value to scale by when the adjustment type is `PercentChangeInCapacity`.

`step_scaling_policy_configuration (cooldown)`
: The amount of time, in seconds, to wait for a previous scaling activity to take effect.

`step_scaling_policy_configuration (metric_aggregation_type)`
: The aggregation type for the CloudWatch metrics. Valid values are `Minimum`, `Maximum`, and `Average`.

`target_tracking_scaling_policy_configuration (target_value)`
: The target value for the metric.

`target_tracking_scaling_policy_configuration (predefined_metric_specification (predefined_metric_type))`
: The metric type. The `ALBRequestCountPerTarget` metric type applies only to Spot Fleet requests and ECS services.

`target_tracking_scaling_policy_configuration (predefined_metric_specification (resource_label))`
: Identifies the resource associated with the metric type. You can't specify a resource label unless the metric type is `ALBRequestCountPerTarget` and there is a target group attached to the Spot Fleet request or ECS service.

`target_tracking_scaling_policy_configuration (customized_metric_specification (metric_name))`
: The name of the metric.

`target_tracking_scaling_policy_configuration (customized_metric_specification (namespace))`
: The namespace of the metric.

`target_tracking_scaling_policy_configuration (customized_metric_specification (dimensions (name)))`
: The name of the dimension.

`target_tracking_scaling_policy_configuration (customized_metric_specification (dimensions (value)))`
: The value of the dimension.

`target_tracking_scaling_policy_configuration (customized_metric_specification (statistic))`
: The statistic of the metric.

`target_tracking_scaling_policy_configuration (customized_metric_specification (unit))`
: The unit of the metric.

`target_tracking_scaling_policy_configuration (scale_out_cooldown)`
: The amount of time, in seconds, to wait for a previous scale-out activity to take effect.

`target_tracking_scaling_policy_configuration (scale_in_cooldown)`
: The amount of time, in seconds, after a scale-in activity completes before another scale-in activity can start.

`target_tracking_scaling_policy_configuration (disable_scale_in)`
: Indicates whether scale in by the target tracking scaling policy is disabled.

`alarms (alarm_name)`
: The name of the alarm.

`alarms (alarm_arn)`
: The Amazon Resource Name (ARN) of the alarm.

`creation_time`
: The Unix timestamp for when the scaling policy was created.

## Examples

**Ensure a policy name is available.**

```ruby
describe aws_application_autoscaling_scaling_policy( service_namespace: 'SERVICE_NAMESPACE' ) do
  its('policy_name') { should eq 'POLICY_NAME' }
end
```

**Ensure a policy type is available.**

```ruby
describe aws_application_autoscaling_scaling_policy( service_namespace: 'SERVICE_NAMESPACE' ) do
    its('policy_type') { should eq "POLICY_TYPE" }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_application_autoscaling_scaling_policy( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

### be_available

Use `should` to check if the scalable policy is available.

```ruby
describe aws_application_autoscaling_scaling_policy( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ApplicationAutoScaling:Client:DescribeScalingPoliciesResponse" %}}
