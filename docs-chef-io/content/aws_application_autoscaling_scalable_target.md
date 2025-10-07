+++
title = "aws_application_autoscaling_scalable_target resource"

draft = false


[menu.aws]
title = "aws_application_autoscaling_scalable_target"
identifier = "inspec/resources/aws/aws_application_autoscaling_scalable_target resource"
parent = "inspec/resources/aws"
+++

Use the `aws_application_autoscaling_scalable_target` InSpec audit resource to test properties of a resource that Application Auto Scaling can scale.

For additional information, including details on parameters and properties, see the [AWS ApplicationAutoScaling ScalableTarget documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalabletarget.html).

## Syntax

```ruby
describe aws_application_autoscaling_scalable_target( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

## Parameters

`service_namespace` _(required)_

: The namespace of the AWS service that provides the resource.

## Properties

`service_namespace`
: The namespace of the AWS service that provides the resource.

`resource_id`
: The identifier of the resource associated with the scalable target.

`scalable_dimension`
: The scalable dimension associated with the scalable target.

`min_capacity`
: The minimum value to scale to in response to a scale-in activity.

`max_capacity`
: The maximum value to scale to in response to a scale-out activity.

`role_arn`
: The ARN of an IAM role that allows Application Auto Scaling to modify the scalable target on your behalf.

`creation_time`
: The Unix timestamp for when the scalable target was created.

`suspended_state (dynamic_scaling_in_suspended)`
: Whether scale in by a target tracking scaling policy or a step scaling policy is suspended. Set the value to `true` if you don't want Application Auto Scaling to remove capacity when a scaling policy is triggered. The default is `false`.

`suspended_state (dynamic_scaling_out_suspended)`
: Whether scale out by a target tracking scaling policy or a step scaling policy is suspended. Set the value to `true` if you don't want Application Auto Scaling to add capacity when a scaling policy is triggered. The default is `false`.

`suspended_state (scheduled_scaling_suspended)`
: Whether scheduled scaling is suspended. Set the value to `true` if you don't want Application Auto Scaling to add or remove capacity by initiating scheduled actions. The default is `false`.

## Examples

Ensure a service namespace is available:

```ruby
describe aws_application_autoscaling_scalable_target( service_namespace: 'SERVICE_NAMESPACE' ) do
  its('service_namespace') { should eq 'ec2' }
end
```

Verify the min scale capacity:

```ruby
describe aws_application_autoscaling_scalable_target( service_namespace: 'SERVICE_NAMESPACE' ) do
    its('min_capacity') { should eq 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_application_autoscaling_scalable_target( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_application_autoscaling_scalable_target( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ApplicationAutoScaling:Client:DescribeScalableTargetsResponse" %}}
