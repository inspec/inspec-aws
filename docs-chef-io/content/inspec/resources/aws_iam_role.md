+++
title = "aws_iam_role Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_role"
identifier = "inspec/resources/aws/aws_iam_role Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_role` InSpec audit resource to test properties of an AWS IAM Role.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_iam_role` resource block declares the tests for a single AWS IAM Role by Role Name.

```ruby
describe aws_iam_role(role_name: 'my-role') do
    it { should exist }
end
```

## Parameters

`role_name` _(required)_

: This resource accepts a single parameter, the Role Name which uniquely identifies the Role.
  This can be passed either as a string or as a `role_name: 'value'` key-value entry in a hash.

## Properties

`path`
: The path to the role.

`role_name`
: The name of the role.

`role_id`
: The id of the role.

`arn`
: The Amazon Resource Name (ARN) specifying the role.

`create_date`
: The date and time, in ISO 8601 date-time format , when the role was created.

`assume_role_policy_document`
: The policy that grants an entity permission to assume the role.

`description`
: The description of the role.

`max_session_duration`
: The maximum session duration (in seconds) for the specified role. Anyone who uses the AWS CLI, or API to assume the role can specify the duration using the optional DurationSeconds API parameter or duration-seconds CLI parameter.

`permissions_boundary_type`
: The permissions boundary usage type that indicates what type of IAM resource is used as the permissions boundary for an entity. This data type can only have a value of Policy .

`permissions_boundary_arn`
: The ARN of the policy used to set the permissions boundary for the user or role.

`inline_policies`
: A list of inline policy names associated with the described role.

`attached_policy_names`
: A list of attached policy names associated with the described role.

`attached_policy_arns`
: A list of attached policy ARNs associated with the described role.

## Examples

**Test that an IAM Role exists.**

```ruby
describe aws_iam_role(role_name: aws_iam_role_name) do
    it               { should exist }
    its('role_name') { should eq aws_iam_role_name }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}


### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_role('AnExistingRole') do
  it { should exist }
end
```

```ruby
describe aws_iam_role('ANonExistentRole') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:GetRoleResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).

