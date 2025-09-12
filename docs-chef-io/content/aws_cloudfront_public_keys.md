+++
title = "aws_cloudfront_public_keys resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudfront_public_keys"
identifier = "inspec/resources/aws/aws_cloudfront_public_keys resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_public_keys` InSpec audit resource to test properties of multiple AWS CloudFront public keys.

The `AWS::CloudFront::PublicKey` resource type creates a public key that you can use with signed URLs and signed cookies, or with field-level encryption.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront public key.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-publickey.html).

## Syntax

Ensure that the public key exists.

```ruby
describe aws_cloudfront_public_keys do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The identifier of the public key.

: **Field**: `id`

`created_times`
: The date and time when the public key was uploaded.

: **Field**: `created_time`

`caller_references`
: A string included in the request to help make sure that the request can’t be replayed.

: **Field**: `caller_reference`

`names`
: A name to help identify the public key.

: **Field**: `name`

`encoded_keys`
: The public key that you can use with signed URLs and signed cookies , or with field-level encryption.

: **Field**: `encoded_key`

`comments`
: A comment to describe the public key. The comment cannot be longer than 128 characters.

: **Field**: `comment`

## Examples

**Ensure a public key ID is available.**

```ruby
describe aws_cloudfront_public_keys do
  its('ids') { should include 'ID' }
end
```

**Ensure a public key name is available.**

```ruby
describe aws_cloudfront_public_keys do
    its('names') { should include 'PUBLIC_KEY_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_public_keys do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_public_keys do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListPublicKeysResult" %}}
