+++
title = "aws_application_autoscaling_scalable_targets resource"

draft = false


[menu.aws]
title = "aws_application_autoscaling_scalable_targets"
identifier = "inspec/resources/aws/aws_application_autoscaling_scalable_targets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_application_autoscaling_scalable_targets` InSpec audit resource to test properties of multiple resourcese that Application Auto Scaling can scale.

For additional information, including details on parameters and properties, see the [AWS ApplicationAutoScaling ScalableTarget documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalabletarget.html).

## Syntax

```ruby
describe aws_application_autoscaling_scalable_targets( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

## Parameters

`service_namespace` _(required)_

: The namespace of the AWS service that provides the resource.

## Properties

`service_namespaces`
: The namespace of the AWS service that provides the resource.

`resource_ids`
: The identifier of the resource associated with the scalable target.

`scalable_dimensions`
: The scalable dimension associated with the scalable target.

`min_capacities`
: The minimum value to scale to in response to a scale-in activity.

`max_capacities`
: The maximum value to scale to in response to a scale-out activity.

`role_arns`
: The ARN of an IAM role that allows Application Auto Scaling to modify the scalable target on your behalf.

`creation_times`
: The Unix timestamp for when the scalable target was created.

`suspended_states`
: The suspended state of the scalable target.

## Examples

Ensure a service namespace is available:

```ruby
describe aws_application_autoscaling_scalable_targets( service_namespace: 'SERVICE_NAMESPACE' ) do
  its('service_namespace') { should include 'ec2' }
end
```

Verify the minimum scale capacity:

```ruby
describe aws_application_autoscaling_scalable_targets( service_namespace: 'SERVICE_NAMESPACE' ) do
    its('min_capacity') { should include 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_application_autoscaling_scalable_targets( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_application_autoscaling_scalable_targets( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ApplicationAutoScaling:Client:DescribeScalableTargetsResponse" %}}
