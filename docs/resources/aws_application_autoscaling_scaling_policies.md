---
title: About the aws_application_autoscaling_scaling_policies Resource
platform: aws
---

# aws_application_autoscaling_scaling_policies

Use the `aws_application_autoscaling_scaling_policies` InSpec audit resource to test properties of multiple AWS Application Auto Scaling scaling policies.

## Syntax

Ensure a scaling policy exists.

    describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
      it { should exist }
    end

## Parameters

`service_namespace` _(required)_

The namespace of the AWS service that provides the resource, or a custom-resource.

For additional information, see the [AWS ApplicationAutoScaling ScalingPolicy documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-applicationautoscaling-scalingpolicy.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| policy_arns | The Amazon Resource Name (ARN) of the scaling policy. | policy_arn |
| policy_names | The name of the scaling policy. | policy_name |
| service_namespaces | The namespace of the AWS service that provides the resource, or a custom-resource. | service_namespace |
| resource_ids | The identifier of the resource associated with the scaling policy. This string consists of the resource type and unique identifier. | resource_id |
| scalable_dimensions | The scalable dimension. This string consists of the service namespace, resource type, and scaling property. | scalable_dimension |
| policy_types | The scaling policy type. | policy_type |
| step_scaling_policy_configurations | A step scaling policy. | step_scaling_policy_configuration |
| target_tracking_scaling_policy_configurations | A target tracking scaling policy. | target_tracking_scaling_policy_configuration |
| alarms | The CloudWatch alarms associated with the scaling policy. | alarms |
| creation_times | The Unix timestamp for when the scaling policy was created. | creation_time |

## Examples

### Ensure a policy name is available.

    describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
      its('policy_names') { should include 'POLICY_NAME' }
    end

### Ensure a policy type is available.

    describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
        its('policy_types') { should include "POLICY_TYPE" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
      it { should exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_application_autoscaling_scaling_policies( service_namespace: 'SERVICE_NAMESPACE' ) do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ApplicationAutoScaling:Client:DescribeScalingPoliciesResponse` action with `Effect` set to `Allow`.
