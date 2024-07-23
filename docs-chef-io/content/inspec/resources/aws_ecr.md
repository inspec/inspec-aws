+++
title = "aws_ecr Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ecr"
identifier = "inspec/resources/aws/aws_ecr Resource"
parent = "inspec/resources/aws"
+++

> WARNING: **This resource is deprecated. Please use one of the following resources instead.** 

- `aws_ecr_image`
- `aws_ecr_images`
- `aws_ecr_repository`
- `aws_ecr_repositories`

Use the `aws_ecr` InSpec audit resource to test properties of a single AWS Elastic Container Registry.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_ecr` resource block declares the tests for a single AWS ECR by repository name.

```ruby
describe aws_ecr(repository_name: aws_ecr_name) do
  it                       { should exist }
  its ('repository_name')  { should eq aws_ecr_name }
end
```

## Parameters

The ECR repository_name must be provided.

`repository_name` _(required)_

: The name of the repository
  This can be passed either as a string or as an `repository_name: 'value'` key-value entry in a hash.


## Properties

`registry_id`
: The AWS account ID associated with the registry.

`repository_arn`
: The Amazon Resource Name of the repository.

`repository_name`
: The name of the repository.

`repository_uri`
: The uri of the repository.

`image_tags`
: The tags associated with the image.

`image_digest`
: A sha256 hash of the image.

`image_size_in_bytes`
: The size of the image in bytes.

`image_pushed_at`
: The datetime as a string when the image was uploaded. 'yyyy-mm-dd hh:mm:ss tz'.

`image_uploaded_date`
: The date as a string when the image was uploaded. 'yyyy-mm-dd'.

## Examples

**Test that an ECR has the correct image properties.**

```ruby
describe aws_ecr(repository_name: aws_ecr_name).images do
  its ('image_tags')          { should include 'latest'}
  its ('image_digest')        { should eq 'sha256:6dce4a9c1635c4c9b6a2b645e6613fa0238182fe13929808ee2258370d0f3497'}
  its ('image_size_in_bytes') { should eq 764234}
  its ('image_uploaded_date') { should eq '2019-06-11'}
  its ('image_pushed_at')     { should eq '2019-06-11 15:08:29 +0100'}
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
it { should_not exist }
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ECR:Client:DescribeRepositoriesResponse` and `ECR:Client:DescribeImagesResponse` actions set to allow..

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ECR](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonelasticcontainerregistry.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
