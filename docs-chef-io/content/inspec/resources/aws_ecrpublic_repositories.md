+++
title = "aws_ecrpublic_repositories Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ecrpublic_repositories"
identifier = "inspec/resources/aws/aws_ecrpublic_repositories Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecrpublic_repositories` InSpec audit resource to test the properties of all public repositories in an AWS Elastic Container Registry (ECR).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_ecrpublic_repositories` resource block declares the tests for all AWS ECR repositories in the default registry unless the registry ID is provided.

```ruby
describe aws_ecrpublic_repositories do
  it { should exist }
end
```

Repositories in a non-default registry can be tested by supplying the registry ID if the AWS user has necessary permissions on it.

```ruby
describe aws_ecrpublic_repositories(registry_id: '123456789012') do
  it { should exist }
end
```

## Parameters

The registry id is optional.

`registry_id` _(optional)_

: The 12-digit ID of the AWS Elastic Container Registry. If not provided, the [default](https://docs.aws.amazon.com/AmazonECRPublic/latest/APIReference/API_DescribeRepositories.html) registry is assumed.

## Properties

`arns`
: The Amazon Resource Name (ARN) that identifies the repository.

`names`
: The name of the repository.

`uris`
: The URI for the repository.

`created_at_dates`
: The date and time, in JavaScript date format, when the repository was created.

## Examples

**Ensure that there are exactly four public repositories in the default registry.**

```ruby
describe aws_ecrpublic_repositories do
  its("count") { should cmp 4 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the `describe` method returns at least one result.

```ruby
describe aws_ecrpublic_repositories.where( <property>: <value>) do
  it { should exist }
end
```

Use `should_not` to test for entities that should not exist.

```ruby
describe aws_ecrpublic_repositories.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECRPublic:Client:DescribeRepositoriesResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ECR Public](https://docs.aws.amazon.com/AmazonECRPublic/latest/APIReference/API_Repository.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
