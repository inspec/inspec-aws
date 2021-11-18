---
title: About the aws_cloudfront_public_key Resource
platform: aws
---

# aws_cloudfront_public_key

Use the `aws_cloudfront_public_key` InSpec audit resource to test properties of a single AWS CloudFront public key.

The `AWS::CloudFront::PublicKey` resource type creates a public key that you can use with signed URLs and signed cookies, or with field-level encryption.

## Syntax

Ensure that the public key exists.

    describe aws_cloudfront_public_key(id: "PUBLIC_KEY_ID") do
      it { should exist }
    end

## Parameters

`id` _(required)_

The identifier of the public key.

For additional information, see the [AWS documentation on AWS Logs public key.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-publickey.html).

## Properties

| Property | Description |
| --- | --- |
| id | The identifier of the public key. |
| created_time | The date and time when the public key was uploaded. |
| public_key_config.caller_reference | A string included in the request to help make sure that the request can’t be replayed. |
| public_key_config.name | A name to help identify the public key. |
| public_key_config.encoded_key | The public key that you can use with signed URLs and signed cookies , or with field-level encryption. |
| public_key_config.comment | A comment to describe the public key. The comment cannot be longer than 128 characters. |

## Examples

### Ensure a public key ID is available.

    describe aws_cloudfront_public_key(id: "PUBLIC_KEY_ID") do
      its('id') { should eq 'ID' }
    end

### Ensure a public key name is available.

    describe aws_cloudfront_public_key(id: "PUBLIC_KEY_ID") do
        its('public_key_config.name') { should eq 'PUBLIC_KEY_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_public_key(id: "PUBLIC_KEY_ID") do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_cloudfront_public_key(id: "PUBLIC_KEY_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_public_key(id: "PUBLIC_KEY_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetPublicKeyResult` action with `Effect` set to `Allow`.
