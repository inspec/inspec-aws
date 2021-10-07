---
title: About the aws_cloudfront_cache_policies Resource
platform: aws
---

# aws_cloudfront_cache_policies

Use the `aws_cloudfront_cache_policies` InSpec audit resource to test properties of multiple AWS CloudFront cache policies.

The `AWS::CloudFront::CachePolicy` resource describes the CloudFront cache policy.

## Syntax

Ensure that the custom resource exists.

    describe aws_cloudfront_cache_policies do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS CloudFront cache policy.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cache policy.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| types | The type for the cache policy. | type |
| ids | The unique identifier for the cache policy. | id |
| last_modified_times | The date and time when the cache policy was last modified. | last_modified_time |
| comments | A comment to describe the cache policy. | comment |
| names | A unique name to identify the cache policy. | name |
| default_ttls | The default amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated. | default_ttl |
| max_ttls | The maximum amount of time, in seconds, that objects stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated. | max_ttl |
| min_ttls | The minimum amount of time, in seconds, that you want objects to stay in the CloudFront cache before CloudFront sends another request to the origin to see if the object has been updated. | min_ttl |

## Examples

### Test that an ID is available.

    describe aws_cloudfront_cache_policies do
      its('ids') { should include 'ID' }
    end

### Verify the maximum TTL of the policy.

    describe aws_cloudfront_cache_policies do
        its('max_ttls') { should include 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_cache_policies do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_cache_policies do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListCachePoliciesResult` action with `Effect` set to `Allow`.
