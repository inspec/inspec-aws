---
title: About the aws_s3_bucket_policy Resource
platform: aws
---

# aws_s3_bucket_policy

Use the `aws_s3_bucket_policy` InSpec audit resource to test properties of the singular resource of AWS S3 BucketPolicy.

## Syntax

Ensure that a S3 bucket policy exists.

    describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
      it { should exist }
    end

## Parameters

`bucket` _(required)_

The bucket name for which to get the bucket policy.

For additional information, see the [AWS documentation on AWS S3 BucketPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html).

## Properties

| Property | Description |
| -- | --- |
| Effect | The effect of the policy. |
| Sid | The policy ID of the S3 bucket. |
| Condition | The policy condition of the S3 Bucket. |
| Action | The policy Action of the S3 Bucket. |
| Resource | The policy resource of the S3 Bucket. |
| Principal | The policy principal of the S3 Bucket. |

## Examples

### Ensure a policy is available.

    describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
      its('Sid') { should eq 'SID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_bucket_policy(bucket: 'BUCKET_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:GetBucketPolicyOutput` action with `Effect` set to `Allow`.