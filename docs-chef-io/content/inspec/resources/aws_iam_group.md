+++
title = "aws_iam_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_group"
identifier = "inspec/resources/aws/aws_iam_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_group` InSpec audit resource to test properties of a single IAM group.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM Groups](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_iam_group` resource block identifies a group by group name.

```ruby
describe aws_iam_group('mygroup') do
  it { should exist }
end
```

    # Hash syntax for group name
```ruby
describe aws_iam_group(group_name: 'mygroup') do
  it { should exist }
end
```

## Parameters

`group_name` _(required)_

: This resource accepts a single parameter, the Group Name which uniquely identifies the IAM Group. 
  This can be passed either as a string or as a `group_name: 'value'` key-value entry in a hash.

## Properties

`group_name`
: The group name.

`group_id`
: The group ID.

`arn`
: The Amazon Resource Name of the group.

`users`
: Array of users associated with the group.

`inline_policy_names`
: A list of inline policy names associated with the group.

## Examples

**Ensure group contains a certain user.**

```ruby
describe aws_iam_group('admin-group') do
  its('users') { should include 'deployment-service-account')}
end
```

## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_group('AnExistingGroup') do
  it { should exist }
end
```

```ruby
describe aws_iam_group('ANonExistentGroup') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:GetGroupResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
