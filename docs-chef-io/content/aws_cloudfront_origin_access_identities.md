+++
title = "aws_cloudfront_origin_access_identities resource"

draft = false


[menu.aws]
title = "aws_cloudfront_origin_access_identities"
identifier = "inspec/resources/aws/aws_cloudfront_origin_access_identities resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_origin_access_identities` InSpec audit resource to test properties of multiple AWS CloudFront origin access identities.

An origin access identity is a special CloudFront user that you can associate with Amazon S3 origins, so that you can secure all or just some of your Amazon S3 content.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront CloudFrontOriginAccessIdentity.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cloudfrontoriginaccessidentity.html).

## Syntax

Ensure that the identity exists.

```ruby
describe aws_cloudfront_origin_access_identities do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The ID for the origin access identity.

: **Field**: `id`

`s3_canonical_user_ids`
: The Amazon S3 canonical user ID for the origin access identity, used when giving the origin access identity read permission to an object in Amazon S3.

: **Field**: `s3_canonical_user_id`

`caller_references`
: A unique value (for example, a date-time stamp) that ensures that the request can't be replayed.

: **Field**: `caller_reference`

`comments`
: A comment to describe the origin access identity.

: **Field**: `comment`

## Examples

Test that an ID is available:

```ruby
describe aws_cloudfront_origin_access_identities do
  its('ids') { should include 'ID' }
end
```

Test that an s3 canonical user ID is available:

```ruby
describe aws_cloudfront_origin_access_identities do
    its('s3_canonical_user_ids') { should include 'S3_CANONICAL_USER_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_origin_access_identities do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_origin_access_identities do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:ListCloudFrontOriginAccessIdentitiesResult" %}}
