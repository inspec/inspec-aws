+++
title = "aws_ssm_activations Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ssm_activations"
identifier = "inspec/resources/aws/aws_ssm_activations Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_activations` InSpec audit resource to test properties of a collection of AWS SSM Activations.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 Ensure you have exactly 3 activations

```ruby
describe aws_ssm_activations do
  its('activation_ids.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`activation_ids`
: Provides  ID created by Systems Manager when you submitted the activation.

`created_dates`
: Provides the date the activation was created.

`default_instance_names`
: Provides the name for the managed instance when it is created.

`descriptions`
: Provides a user defined description of the activation.

`expiration_dates`
: Provides the date when this activation can no longer be used to register managed instances.

`expired`
: Whether or not the activation is expired.

`iam_roles`
: Provides the Amazon Identity and Access Management (IAM) role to assign to the managed instance.

`registration_limits`
: Provides the maximum number of managed instances that can be registered with this activation.

`registrations_count`
: Provides the number of managed instances already registered with this activation.

`tags`
: Provides the tags assigned to the activation.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_Activation.html)

## Examples

**Ensure an Activation ID of a SSM Activation exists.**

```ruby
describe aws_ssm_activations do
  its('activation_ids') { should include 'activation-id' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ssm_activations.where( <property>: <value> ) do
  it { should exist }
end
```

```ruby
describe aws_ssm_activations.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeActivationsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Systems Manager](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awssystemsmanager.html).