---
title: About the aws_ssm_activation Resource
platform: aws
---

# aws\_ssm\_activation

Use the `aws_ssm_activation` InSpec audit resource to test properties of a ssm activation.

## Syntax

 An `aws_ssm_activation` resource block uses the parameter to select a ssm activation.

    describe aws_ssm_activation(activation_id: 'ssm-activation-id-1234') do
      it { should exist }
    end


#### Parameters

##### activation_id _(required)_

This resource accepts a single parameter, the SSM Activation ID.
This can be passed either as a string or as a `activation_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on SSM Activations](https://docs.aws.amazon.com/systems-manager/latest/userguide/activations.html).


## Properties

|Property                     | Description|
| ---                         | --- |
|activation\_id               | Provides  ID created by Systems Manager when you submitted the activation. |
|created\_date                | Provides the date the activation was created. |
|default\_instance\_name      | Provides the name for the managed instance when it is created. |
|description                  | Provides a user defined description of the activation. |
|expiration\_date             | Provides the date when this activation can no longer be used to register managed instances. |
|expired                      | Whether or not the activation is expired. |
|iam\_role                    | Provides the Amazon Identity and Access Management (IAM) role to assign to the managed instance. |
|registration\_limit          | Provides the maximum number of managed instances that can be registered with this activation. |
|registrations\_count         | Provides the number of managed instances already registered with this activation. |
|tags                         | Provides the tags assigned to the activation. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Activation.html)

## Examples

##### Check the Activation ID of a SSM Activation

    describe aws_ssm_activation(activation_id: 'ssm-activation-id-1234') do
      its('activation_id')  { should eq 'ssm-activation-id-1234' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ssm_activation(activation_id: 'ssm-activation-id-1234') do
      it { should exist }
    end

    describe aws_ssm_activation(activation_id: 'ssm-activation-id-6789') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ssm:DescribeActivations` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).