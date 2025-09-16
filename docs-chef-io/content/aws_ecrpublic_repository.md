+++
title = "aws_ecrpublic_repository resource"

draft = false


[menu.aws]
title = "aws_ecrpublic_repository"
identifier = "inspec/resources/aws/aws_ecrpublic_repository resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecrpublic_repository` InSpec audit resource to test the properties of a single AWS Elastic Container Registry (ECR) public repository.

## Syntax

An `aws_ecrpublic_repository` resource block declares the tests for a single AWS ECR repository by repository name.

```ruby
describe aws_ecrpublic_repository(repository_name: 'my-repo') do
  it { should exist }
end
```

The value of the `repository_name` can be provided as a string.

```ruby
describe aws_ecrpublic_repository('my-repo') do
  it { should exist }
end
```

## Parameters

The repository name must be provided. The registry id is optional.

`repository_name` _(required)_

: The name of the ECR repository must satisfy the following constraints:

: - It must match the following regular expression: `(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*`.

- It must be between 2 and 256 characters long.

: The `repository_name` can be passed as a string or as a `repository_name: 'value'` key-value entry in a hash.

`registry_id` _(optional)_

: The 12-digit ID of the AWS Elastic Container Registry. If not provided, this resource will use the [default public registry](https://docs.aws.amazon.com/AmazonECRPublic/latest/APIReference/API_DescribeRepositories.html).

## Properties

`repository_name`
: The name of the repository.

`registry_id`
: The AWS account ID associated with the registry that contains the repository.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AmazonECRPublic/latest/APIReference/API_Repository.html)

## Examples

Test that ecr public repository 'public-repo' exists:

```ruby
describe aws_ecrpublic_repository('public-repo') do
  it { should exist }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECRPublic:Client:DescribeRepositoriesResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ECR Public](https://docs.aws.amazon.com/AmazonECRPublic/latest/APIReference/API_Repository.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
