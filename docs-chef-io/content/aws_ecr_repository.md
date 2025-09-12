+++
title = "aws_ecr_repository resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ecr_repository"
identifier = "inspec/resources/aws/aws_ecr_repository resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecr_repository` InSpec audit resource to test the properties of a single AWS Elastic Container Registry (ECR) repository.
This resource is available in InSpec AWS resource pack version **[1.11.0](https://github.com/inspec/inspec-aws/releases/tag/v1.11.0)** onwards.

## Syntax

An `aws_ecr_repository` resource block declares the tests for a single AWS ECR repository by repository name.

```ruby
describe aws_ecr_repository(repository_name: 'my-repo') do
  it { should exist }
end
```

The value of the `repository_name` can be provided as a string.  

```ruby
describe aws_ecr_repository('my-repo') do
  it { should exist }
end
```

## Parameters

The repository name must be provided. The registry id is optional.

`repository_name` _(required)_

: The name of the ECR repository must satisfy the following constraints:

- Regex pattern `(?:[a-z0-9]+(?:[._-][a-z0-9]+)*/)*[a-z0-9]+(?:[._-][a-z0-9]+)*`.
- Minimum 2 and maximum of 256 characters long.

: This can be passed either as a string or as a `repository_name: 'value'` key-value entry in a hash.

`registry_id` _(optional)_

: The 12-digit ID of the AWS Elastic Container Registry. If not provided, the [default](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_DescribeRepositories.html) registry is assumed.  

## Properties

`repository_name`
: The name of the repository.

`image_tag_mutability`
: The tag mutability settings for the repository. Valid values are `MUTABLE` or `IMMUTABLE`.

`registry_id`
: The AWS account ID associated with the registry that contains the repository.

`tags`
: An hash with each key-value pair corresponding to a tag associated with the entity.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_Repository.html)

## Examples

**Test that image tags are `IMMUTABLE` in an ECR repository.**

```ruby
describe aws_ecr_repository('my-repo') do
  its('image_tag_mutability') { should eq 'IMMUTABLE' }
end
```

**Test that images are scanned for vulnerabilities at a push to repository.**

```ruby
describe aws_ecr_repository(repository_name: 'my-repo') do
  its('image_scanning_configuration.scan_on_push') { should eq true}
end
```

**Test that an ECR repository has a certain tag.**

```ruby
describe aws_ecr_repository('my-repo') do
  its('tags') { should include('environment' => 'dev') }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

```ruby
describe aws_ecr_repository(repository_name: 'my-repo') do
    it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECR:Client:DescribeRepositoriesResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ECR](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_Operations.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
