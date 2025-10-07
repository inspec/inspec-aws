+++
title = "aws_ecr_repository_policy resource"

draft = false


[menu.aws]
title = "aws_ecr_repository_policy"
identifier = "inspec/resources/aws/aws_ecr_repository_policy resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecr_repository_policy` InSpec audit resource to test the policy configured for a single AWS Elastic Container Registry (ECR) repository.

New in InSpec AWS resource pack [1.11.0](https://github.com/inspec/inspec-aws/releases/tag/v1.11.0).

## Syntax

An `aws_ecr_repository_policy` resource block declares the tests for a single AWS ECR repository by repository name.

```ruby
describe aws_ecr_repository_policy(repository_name: 'my-repo') do
  it { should exist }
end
```

The value of the `repository_name` can be provided as a string.

```ruby
describe aws_ecr_repository_policy('my-repo') do
  it { should exist }
end
```

## Parameters

The repository name must be provided.

`repository_name` _(required)_

: The name of the ECR repository must satisfy the following constraints:

- Regex pattern `(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*`.
- Minimum 2 and maximum of 256 characters long.

: This can be passed either as a string or as a `repository_name: 'value'` key-value entry in a hash.

`have_statement`

: The `have_statement` examines the list of statements contained in the policy and passes if at least one of the statements matches.
  This matcher does _not_ interpret the policy in a request authorization context as AWS does when a request is processed. Rather, the `have_statement` examines the literal contents of the IAM policy and reports on what is present (or absent, when used with `should_not`).

: **Criteria**

: The `have_statement` accepts the following criteria to search for matching statements. A test is successful if any statement matches all the criteria. Criteria can be formatted in title case or lowercase, and as a string or symbol.

: `Action`
  : Expresses the requested operation. Acceptable literal values are any AWS operation name, including the '\*' wildcard character.
    `Action` may also use a list of AWS operation names.

: `Effect`
  : Expresses if the operation is permitted. Acceptable values are `'Deny'` and `'Allow'`.

: `Sid`
  : A user-provided string identifier for the statement.

: `Principal`
  : Expresses the operation's target. Acceptable values are Amazon Resource Names (ARNs), including the '\*' wildcard.
    `Principal` may also use a list of ARN values.

: Please note the following about the behavior of the `have_statement`:

: - The `Action`, `Sid`, and `Resource` criteria will allow a regular expression instead of a string literal.

- The `have_statement` does not support wildcard expansion; to check for a wildcard value, check for it explicitly. For example, if the policy includes a statement with `"Action": "s3:*"` and the test checks for `Action: "s3:PutObject"`, the test _will not match_. You must write an additional test checking for the wildcard case.
- The `have_statement` supports searching for list values. For example, if a statement contains a list of three resources and a `have_statement` test specifies _one_ of those resources, it will match.

## Examples

```ruby
describe aws_ecr_repository_policy('repo_name') do
  it { should exist }
  it { should have_statement(Action: "ecr:GetDownloadUrlForLayer", Effect: "Allow", Principal: "*", Sid: "new policy")}
  it { should_not have_statement(Action: /^rds:.+$/)}
end
```

Symbols, title case, and lowercase are all allowed as criteria.
The following four statements will return the same results:

```ruby
describe aws_ecr_repository_policy('repo_name') do
  it { should_not have_statement('Effect' => 'Allow', 'Principal' => '*', 'Action' => '*')}
  it { should_not have_statement('effect' => 'Allow', 'Principal' => '*', 'action' => '*')}
  it { should_not have_statement(Effect: 'Allow', Principal: '*', Action: '*')}
  it { should_not have_statement(effect: 'Allow', Principal: '*', action: '*')}
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECR:Client:GetRepositoryPolicyResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_Operations.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
