+++
title = "aws_application_autoscaling_scaling_policies resource"

draft = false


[menu.aws]
title = "aws_application_autoscaling_scaling_policies"
identifier = "inspec/resources/aws/aws_application_autoscaling_scaling_policies resource"
parent = "inspec/resources/aws"
+++

Use the `aws_application_autoscaling_scaling_policies` InSpec audit resource to test properties of multiple AWS Application Auto Scaling scaling policies.

For additional information, including details on parameters and properties, see the [AWS ApplicationAutoScaling ScalingPolicy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html).

## Syntax

Ensure a scaling policy exists.

```ruby
describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

## Parameters

`service_namespace` _(required)_

: The namespace of the AWS service that provides the resource, or a custom-resource.

## Properties

`policy_arns`
: The Amazon Resource Name (ARN) of the scaling policy.

`policy_names`
: The name of the scaling policy.

`service_namespaces`
: The namespace of the AWS service that provides the resource, or a custom-resource.

`resource_ids`
: The identifier of the resource associated with the scaling policy. This string consists of the resource type and unique identifier.

`scalable_dimensions`
: The scalable dimension. This string consists of the service namespace, resource type, and scaling property.

`policy_types`
: The scaling policy type.

`step_scaling_policy_configurations`
: A step scaling policy.

`target_tracking_scaling_policy_configurations`
: A target tracking scaling policy.

`alarms`
: The CloudWatch alarms associated with the scaling policy.

`creation_times`
: The Unix timestamp for when the scaling policy was created.

## Examples

Ensure a policy name is available:

```ruby
describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
  its('policy_names') { should include 'POLICY_NAME' }
end
```

Ensure a policy type is available:

```ruby
describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
    its('policy_types') { should include "POLICY_TYPE" }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should exist }
end
```

### be_available

Use `should` to check if the scalable policy is available.

```ruby
describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ApplicationAutoScaling:Client:DescribeScalingPoliciesResponse" %}}
