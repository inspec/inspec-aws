---
title: About the aws_cloudfront_origin_access_identity Resource
platform: aws
---

# aws_cloudfront_origin_access_identity

Use the `aws_cloudfront_origin_access_identity` InSpec audit resource to test properties of a single specific AWS CloudFront origin access identity.

An origin access identity is a special CloudFront user that you can associate with Amazon S3 origins, so that you can secure all or just some of your Amazon S3 content.

## Syntax

Ensure that the identity exists.

    describe aws_cloudfront_origin_access_identity(id: 'ID') do
      it { should exist }
    end

## Parameters

`id` _(required)_

The ID for the origin access identity.

For additional information, see the [AWS documentation on AWS CloudFront CloudFrontOriginAccessIdentity.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cloudfrontoriginaccessidentity.html).

## Properties

| Property | Description |
| --- | --- |
| id | The ID for the origin access identity. |
| s3_canonical_user_id | The Amazon S3 canonical user ID for the origin access identity, used when giving the origin access identity read permission to an object in Amazon S3. |
| cloud_front_origin_access_identity_config.caller_reference | A unique value (for example, a date-time stamp) that ensures that the request can't be replayed. |
| cloud_front_origin_access_identity_config.comment | A comment to describe the origin access identity. |

## Examples

### Test that an ID is available.

    describe aws_cloudfront_origin_access_identity(id: 'ID') do
      its('id') { should eq 'ID' }
    end

### Test that an s3 canonical user ID is available.

    describe aws_cloudfront_origin_access_identity(id: 'ID') do
        its('s3_canonical_user_id') { should eq 'S3_CANONICAL_USER_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_origin_access_identity(id: 'ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_origin_access_identity(id: 'ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_origin_access_identity(id: 'ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetCloudFrontOriginAccessIdentityResult` action with `Effect` set to `Allow`.
