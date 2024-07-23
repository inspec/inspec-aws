+++
title = "aws_iam_inline_policy Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_inline_policy"
identifier = "inspec/resources/aws/aws_iam_inline_policy Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_inline_policy` InSpec audit resource to test properties of a single inline AWS IAM Policy embedded with IAM User, IAM Group or IAM Role. For managed policies, use the `aws_iam_policy` resource.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_iam_inline_policy` resource block identifies an inline policy by policy name and user/group/role by name

    # Find an inline policy by name and role name
```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
  it { should exist }
end
```

    # Find an inline policy by name and group name
```ruby
describe aws_iam_inline_policy(group_name: 'group-x', policy_name: 'policy-1') do
  it { should exist }
end
```

    # Find an inline policy by name and user name
```ruby
describe aws_iam_inline_policy(user_name: 'user-a', policy_name: 'policy-1') do
  it { should exist }
end
```

## Parameters

This resource requires `policy_name` and one of the `role_name`, `group_name` or `user_name` to be provided.

See AWS Documentation on inline policies for more details

- [get-role-policy](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/iam/get-role-policy.html)
- [get-group-policy](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/iam/get-group-policy.html)
- [get-user-policy](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/iam/get-user-policy.html)

## Properties

`policy`
: Returns the default version of the policy document after decoding as a Ruby hash. This hash contains the policy statements and is useful for performing checks that cannot be expressed using higher-level matchers like `have_statement`.

`statement_count`
: Returns the number of statements present in the `policy`.

## Examples

**Test that a policy does exist.**

```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
  it { should exist }
end
```

**Examine the policy statements.**

```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
**Verify that there is at least one statement allowing access to S3.**

  it { should have_statement(Action: 's3:PutObject', Effect: 'allow') }
```

```ruby
**have_statement does not expand wildcards. If you want to verify.**
**they are absent, an explicit check is required.**

it { should_not have_statement(Action: 's3:*') }
```

```ruby
**You can also check NotAction.**

it { should_not have_statement(NotAction: 'iam:*') }
    end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
it { should exist }
```

```ruby
it { should_not exist }
```

### have_statement

Examines the list of statements contained in the policy and passes if at least one of the statements matches. This matcher does _not_ interpret the policy in a request authorization context, as AWS does when a request processed. Rather, `have_statement` examines the literal contents of the IAM policy, and reports on what is present (or absent, when used with `should_not`).

`have_statement` accepts the following criteria to search for matching statements. If any statement matches all the criteria, the test is successful. All criteria may be used as Titlecase (as in the AWS examples) or lowercase, string or symbol.

- `Action` - Expresses the requested operation. Acceptable literal values are any AWS operation name, including the '\*' wildcard character. `Action` may also use a list of AWS operation names.
- `Effect` - Expresses if the operation is permitted. Acceptable values are 'Deny' and 'Allow'.
- `Sid` - A user-provided string identifier for the statement.
- `Resource` - Expresses the operation's target. Acceptable values are ARNs, including the '\*' wildcard. `Resource` may also use a list of ARN values.

Please note the following about the behavior of `have_statement`:

- `Action`, `Sid`, and `Resource` allow using a regular expression as the search critera instead of a string literal.
- it does not support wildcard expansion; to check for a wildcard value, check for it explicitly. For example, if the policy includes a statement with `"Action": "s3:*"` and the test checks for `Action: "s3:PutObject"`, the test _will not match_. You must write an additional test checking for the wildcard case.
- it supports searching list values. For example, if a statement contains a list of 3 resources, and a `have_statement` test specifes _one_ of those resources, it will match.
- `Action` and `Resource` allow using a list of string literals or regular expressions in a test, in which case _all_ must match on the _same_ statement for the test to match. Order is ignored.
- it does not support the `[Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)` or `Conditional` key, or any of `NotAction`, `Not[Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal)`, or `NotResource`.

Examples:

    # Verify there is no full-admin statement
```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
  it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*')}
end
```

    # Symbols and lowercase also allowed as criteria
```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
  # All 4 the same
  it { should_not have_statement('Effect' => 'Allow', 'Resource' => '*', 'Action' => '*')}
  it { should_not have_statement('effect' => 'Allow', 'resource' => '*', 'action' => '*')}
  it { should_not have_statement(Effect: 'Allow', Resource: '*', Action: '*')}
  it { should_not have_statement(effect: 'Allow', resource: '*', action: '*')}
end
```

    # Verify bob is allowed to manage things on S3 buckets that start with bobs-stuff
```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
  it { should have_statement(Effect: 'Allow',
                             # Using the AWS wildcard - this must match exactly
                             Resource: 'arn:aws:s3:::bobs-stuff*',
                             # Specify a list of actions - all must match, no others, order isn't important
                             Action: ['s3:PutObject', 's3:GetObject', 's3:DeleteObject'])}
```

```ruby
# Bob would make new buckets constantly if we let him.
it { should_not have_statement(Effect: 'Allow', Action: 's3:CreateBucket')}
it { should_not have_statement(Effect: 'Allow', Action: 's3:*')}
it { should_not have_statement(Effect: 'Allow', Action: '*')}
```

```ruby
# An alternative to checking for wildcards is to specify the
# statements you expect, then restrict statement count
its('statement_count') { should cmp 1 }
    end
```

    # Use regular expressions to examine the policy
```ruby
describe aws_iam_inline_policy(role_name: 'role-x', policy_name: 'policy-1') do
  # Check to see if anything mentions RDS at all.
  # This catches `rds:CreateDBinstance` and `rds:*`, but would not catch '*'.
  it { should_not have_statement(Action: /^rds:.+$/)}
```

```ruby
# This policy should refer to both sally and kim's s3 buckets.
# This will only match if there is a statement that refers to both resources.
it { should have_statement(Resource: [/arn:aws:s3.+:sally/, /arn:aws:s3.+:kim/]) }
# The following also matches on a statement mentioning only one of them
it { should have_statement(Resource: /arn:aws:s3.+:(sally|kim)/) }
    end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:GetUserPolicyResponse`, `IAM:Client:GetPolicyResponse`, and `IAM:Client:GetRolePolicyResponse` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).

aws_iam_inline_policy.md
