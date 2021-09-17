---
title: About the aws_cloudfront_origin_access_identities Resource
platform: aws
---

# aws_cloudfront_origin_access_identities

Use the `aws_cloudfront_origin_access_identities` InSpec audit resource to test properties of the plural AWS CloudFront CloudFrontOriginAccessIdentity.

The request to create a new origin access identity (OAI). An origin access identity is a special CloudFront user that you can associate with Amazon S3 origins, so that you can secure all or just some of your Amazon S3 content.

## Syntax

Ensure that the identity exists.

    describe aws_cloudfront_origin_access_identities do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront CloudFrontOriginAccessIdentity.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cloudfrontoriginaccessidentity.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| ids | The ID for the origin access identity. | id |
| s3_canonical_user_ids | The Amazon S3 canonical user ID for the origin access identity, used when giving the origin access identity read permission to an object in Amazon S3. | s3_canonical_user_id |
| caller_references | A unique value (for example, a date-time stamp) that ensures that the request can't be replayed. | caller_reference |
| comments | A comment to describe the origin access identity. | comment |

## Examples

### Ensure an id is available.
    describe aws_cloudfront_origin_access_identities do
      its('ids') { should include 'ID' }
    end

### Ensure a s3 canonical user id is available.
    describe aws_cloudfront_origin_access_identities do
        its('s3_canonical_user_ids') { should include 'S3CanonicalUserID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_origin_access_identities do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_origin_access_identities do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListCloudFrontOriginAccessIdentitiesResult` action with `Effect` set to `Allow`.