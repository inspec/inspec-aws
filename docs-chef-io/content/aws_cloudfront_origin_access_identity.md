+++
title = "aws_cloudfront_origin_access_identity resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudfront_origin_access_identity"
identifier = "inspec/resources/aws/aws_cloudfront_origin_access_identity resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudfront_origin_access_identity` InSpec audit resource to test properties of a single specific AWS CloudFront origin access identity.

An origin access identity is a special CloudFront user that you can associate with Amazon S3 origins, so that you can secure all or just some of your Amazon S3 content.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFront CloudFrontOriginAccessIdentity.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cloudfrontoriginaccessidentity.html).

## Syntax

Ensure that the identity exists.

```ruby
describe aws_cloudfront_origin_access_identity(id: 'ID') do
  it { should exist }
end
```

## Parameters

`id` _(required)_

: The ID for the origin access identity.

## Properties

`id`
: The ID for the origin access identity.

`s3_canonical_user_id`
: The Amazon S3 canonical user ID for the origin access identity, used when giving the origin access identity read permission to an object in Amazon S3.

`cloud_front_origin_access_identity_config.caller_reference`
: A unique value (for example, a date-time stamp) that ensures that the request can't be replayed.

`cloud_front_origin_access_identity_config.comment`
: A comment to describe the origin access identity.

## Examples

Test that an ID is available:

```ruby
describe aws_cloudfront_origin_access_identity(id: 'ID') do
  its('id') { should eq 'ID' }
end
```

Test that an s3 canonical user ID is available:

```ruby
describe aws_cloudfront_origin_access_identity(id: 'ID') do
    its('s3_canonical_user_id') { should eq 'S3_CANONICAL_USER_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudfront_origin_access_identity(id: 'ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudfront_origin_access_identity(id: 'ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudfront_origin_access_identity(id: 'ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFront:Client:GetCloudFrontOriginAccessIdentityResult" %}}
