+++
title = "aws_iam_groups resource"

draft = false


[menu.aws]
title = "aws_iam_groups"
identifier = "inspec/resources/aws/aws_iam_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_groups` InSpec audit resource to test properties of a collection of IAM groups.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM Groups](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html).

## Syntax

An `aws_iam_groups` resource block identifies a group by group name.

```ruby
describe aws_iam_groups('mygroup') do
  it { should exist }
end
```

Hash syntax for group name:

```ruby
describe aws_iam_groups(group_name: 'mygroup') do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`group_names`
: The group name.

`group_ids`
: The group ID.

`arns`
: The Amazon Resource Name of the group.

`users`
: Array of users associated with the group.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

`has_inline_policies`
: Boolean indicating whether or not the group has policies applied to it.

`inline_policy_names`
: The names of the policies (if any) which are applied to the group.

## Examples

Ensure group contains a certain user:

```ruby
describe aws_iam_groups do
  it                 { should exist }
  its('group_names') { should include 'prod-access-group' }
end
```

Ensure there are no groups with inline policies:

```ruby
describe aws_iam_groups.where(has_inline_policies: true) do
  its('group_names') { should be_empty }
end
```

## Matchers

### exist

The control will pass if a group with the given group name exists.

```ruby
describe aws_iam_groups do
  it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListGroupsResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
