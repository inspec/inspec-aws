+++
title = "aws_iam_account_alias resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_account_alias"
identifier = "inspec/resources/aws/aws_iam_account_alias resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_account_alias` InSpec audit resource to test properties of the AWS IAM account alias.

For additional information, including details on parameters and properties, see the [AWS documentation on Account Aliases](https://docs.aws.amazon.com/IAM/latest/UserGuide/console_account-alias.html).

## Syntax

An `aws_iam_account_alias` resource block may be used to perform tests on details of the AWS account alias.

```ruby
describe aws_iam_account_alias do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`alias`
: String containing the Alias of the account.

## Examples

**Check that the account alias has not be set.**

```ruby
describe aws_iam_account_alias do
  it { should_not exist }
end
```

**Test if the account alias starts with expected prefix.**

```ruby
describe aws_iam_account_alias do
  it           { should exist }
  its('alias') { should match /^chef-/ }
end
```

## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_account_alias do
  it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListAccountAliasesResponse" %}}
