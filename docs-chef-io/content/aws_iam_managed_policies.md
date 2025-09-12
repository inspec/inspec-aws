+++
title = "aws_iam_managed_policies resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_managed_policies"
identifier = "inspec/resources/aws/aws_iam_managed_policies resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_managed_policies` InSpec audit resource to test the properties of a collection of AWS IAM managed policies.

## Syntax

The `aws_iam_managed_policies` resource returns a collection of IAM managed policies and allows testing of that collection.

```ruby
describe aws_iam_managed_policies do
  its('policy_names') { should include('POLICY_NAME') }
end
```

This resource allows filtering by scope, which are:

- To list only AWS-managed policies, set `scope` to `AWS`.
- To list only the customer-managed policies in your AWS account, set `scope` to `Local`.
- If a scope is not provided or if `scope` is set to `ALL`, all policies are returned.

```ruby
describe aws_iam_managed_policies(scope: 'AWS') do
  it { should exist }
end
```

```ruby
describe aws_iam_managed_policies(scope: 'Local') do
  it { should exist }
end
```

```ruby
describe aws_iam_managed_policies(scope: 'ALL') do
  it { should exist }
end
```

See the [AWS documentation on IAM Managed Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html) for additional information.

## Parameters

`scope` _(optional)_

`scope` accepts three possible values, `AWS`, `Local`, or `ALL`:

- `AWS` returns AWS-managed policies.
- `Local` returns customer-managed policies.
- `ALL` returns all policies.

: Specify a scope by passing a key-value entry in a hash: `scope: 'VALUE'`.

: If ommitted, all policies are returned.

## Properties

`arns`
: A list of the ARN identifiers of the policies.

: **Field**: `arn`

`policy_ids`
: A list of the stable and unique strings identifying the policies.

: **Field**: `policy_id`

`policy_names`
: A list of the friendly names (not ARN) identifying the policies.

: **Field**: `policy_name`

`attachment_counts`
: A list of the counts of attached entities for each policy.

: **Field**: `attachment_count`

`attached_groups`
: A list of the list of group names of the groups attached to each policy.

: **Field**: `attached_group`

`default_version_ids`
: A list of the identifier for the default version of the policy.

: **Field**: `default_version_id`

## Examples

Ensure a specific policy exists:

```ruby
describe aws_iam_managed_policies do
  its('policy_names') { should include('POLICY_NAME') }
end
```

Allow at most 100 IAM Policies on the account:

```ruby
describe aws_iam_managed_policies do
  its('polict_ids.count') { should be <= 100}
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control passes if the describe returns at least one result.

Use `should` to test the entity should exist.

```ruby
describe aws_iam_managed_policies.where( PROPERTY: PROPERTY_VALUE) do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_managed_policies.where( PROPERTY: PROPERTY_VALUE) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="iam:ListPolicies" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
