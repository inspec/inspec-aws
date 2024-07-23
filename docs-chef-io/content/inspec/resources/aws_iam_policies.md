+++
title = "aws_iam_policies Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_policies"
identifier = "inspec/resources/aws/aws_iam_policies Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_policies` InSpec audit resource to test properties of a collection of AWS IAM Policies.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM Policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

`aws_iam_policies` Resource returns a collection of IAM Policies and allows testing of that collection.

```ruby
describe aws_iam_policies do
  its('policy_names') { should include('test-policy-1') }
end
```

## Parameters

`only_attached` _(optional)_

: This resource allows filtering by only_attached.
  When `OnlyAttached` is `true`, the returned list contains only the policies that are attached to an IAM user, group, or role. When `OnlyAttached` is `false`, or when the parameter is not included, all policies are returned.


`scope` _(optional)_

: This resource allows filtering by scope.
  To list only AWS managed policies, set `Scope` to `AWS`. To list only the customer managed policies in your AWS account, set `Scope` to `Local`. If scope is not supplied `ALL` policies are returned.

## Properties

`arns`
: The ARN identifier of the specified policy.

`policy_ids`
: The policy ids.

`policy_names`
: The policy names.

`attachment_counts`
: The count of attached entities for each policy.

`attached_groups`
: The list of group names of the groups attached to each policy.

`attached_roles`
: The list of role names of the roles attached to each policy.

`attached_users`
: The list of usernames of the users attached to each policy.

`default_version_ids`
: The 'default_version_id' value of each policy.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a policy exists.**

```ruby
describe aws_iam_policies do
  its('policy_names') { should include('test-policy-1') }
end
```

**Allow at most 100 IAM Policies on the account.**

```ruby
describe aws_iam_policies do
  its('entries.count') { should be <= 100}
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_policies.where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe aws_iam_policies.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListPoliciesResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
