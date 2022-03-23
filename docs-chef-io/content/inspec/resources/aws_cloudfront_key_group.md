+++
title = "aws_cloudfront_key_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudfront_key_group"
identifier = "inspec/resources/aws/aws_cloudfront_key_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_key_group` InSpec audit resource to test properties of a single AWS CloudFront key group.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront key group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-keygroup.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the key group exists.

```ruby
describe aws_cloudfront_key_group(id: "ID") do
  it { should exist }
end
```

## Parameters

`id` _(required)_

: The identifier for the key group.

## Properties

`id`
: The identifier for the key group.

`last_modified_time`
: The date and time when the key group was last modified.

`key_group_config.name`
: A name to identify the key group.

`key_group_config.items`
: A list of the identifiers of the public keys in the key group.

`key_group_config.comment`
: A comment to describe the key group. The comment cannot be longer than 128 characters.

## Examples

**Ensure an ID is available.**

```ruby
describe aws_cloudfront_key_group(id: "ID") do
  its('id') { should eq 'ID' }
end
```

**Ensure that the key group name is available.**

```ruby
describe aws_cloudfront_key_group(id: "ID") do
    its('key_group_config.name') { should eq 'KEY_GROUP_NAME' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_key_group(id: "ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_key_group(id: "ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudfront_key_group(id: "ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% aws_permissions_principal action="CloudFront:Client:GetKeyGroupResult" %}}
