---
title: About the aws_ssm_activations Resource
platform: aws
---

# aws\_ssm\_activations

Use the `aws_ssm_activations` InSpec audit resource to test properties of a collection of AWS SSM Activations.

## Syntax

 Ensure you have exactly 3 activations

    describe aws_ssm_activations do
      its('activation_ids.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on SSM](https://docs.aws.amazon.com/systems-manager/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|activation\_ids              | Provides  ID created by Systems Manager when you submitted the activation. |
|created\_dates               | Provides the date the activation was created. |
|default\_instance\_names     | Provides the name for the managed instance when it is created. |
|descriptions                 | Provides a user defined description of the activation. |
|expiration\_dates            | Provides the date when this activation can no longer be used to register managed instances. |
|expired                      | Whether or not the activation is expired. |
|iam\_roles                   | Provides the Amazon Identity and Access Management (IAM) role to assign to the managed instance. |
|registration\_limits         | Provides the maximum number of managed instances that can be registered with this activation. |
|registrations\_count         | Provides the number of managed instances already registered with this activation. |
|tags                         | Provides the tags assigned to the activation. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Activation.html)

## Examples

##### Ensure an Activation ID of a SSM Activation exists
    describe aws_ssm_activations do
      its('activation_ids') { should include 'activation-id' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_activations.where( <property>: <value> ) do
      it { should exist }
    end

    describe aws_ssm_activations.where( <property>: <value> ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:DescribeActivations` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).