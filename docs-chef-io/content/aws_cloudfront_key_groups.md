+++
title = "aws_cloudfront_key_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudfront_key_groups"
identifier = "inspec/resources/aws/aws_cloudfront_key_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_key_groups` InSpec audit resource to test properties of multiple AWS CloudFront key groups.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront key group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-keygroup.html).

## Syntax

Ensure that the key group exists.

```ruby
describe aws_cloudfront_key_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The identifier for the key group.

: **Field**: `id`

`last_modified_times`
: The date and time when the key group was last modified.

: **Field**: `last_modified_time`

`names`
: A name to identify the key group.

: **Field**: `name`

`items`
: A list of the identifiers of the public keys in the key group.

: **Field**: `items`

`comments`
: A comment to describe the key group. The comment cannot be longer than 128 characters.

: **Field**: `comment`

## Examples

Ensure an ID is available:

```ruby
describe aws_cloudfront_key_groups do
  its('ids') { should include 'ID' }
end
```

Ensure that the key group name is available:

```ruby
describe aws_cloudfront_key_groups do
    its('names') { should include 'KEY_GROUP_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_key_groups do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_cloudfront_key_groups do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListKeyGroupsResult" %}}
