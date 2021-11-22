---
title: About the aws_cloudfront_public_keys Resource
platform: aws
---

# aws_cloudfront_public_keys

Use the `aws_cloudfront_public_keys` InSpec audit resource to test properties of multiple AWS CloudFront public keys.

The `AWS::CloudFront::PublicKey` resource type creates a public key that you can use with signed URLs and signed cookies, or with field-level encryption.

## Syntax

Ensure that the public key exists.

    describe aws_cloudfront_public_keys do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront public key.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-publickey.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| ids | The identifier of the public key. | id |
| created_times | The date and time when the public key was uploaded. | created_time |
| caller_references | A string included in the request to help make sure that the request can’t be replayed. | caller_reference |
| names | A name to help identify the public key. | name |
| encoded_keys | The public key that you can use with signed URLs and signed cookies , or with field-level encryption. | encoded_key |
| comments | A comment to describe the public key. The comment cannot be longer than 128 characters. | comment |

## Examples

### Ensure a public key ID is available.

    describe aws_cloudfront_public_keys do
      its('ids') { should include 'ID' }
    end

### Ensure a public key name is available.

    describe aws_cloudfront_public_keys do
        its('names') { should include 'PUBLIC_KEY_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_public_keys do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_public_keys do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListPublicKeysResult` action with `Effect` set to `Allow`.
