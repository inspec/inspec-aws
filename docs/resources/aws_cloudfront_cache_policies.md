---
title: About the aws_cloudfront_cache_policies Resource
platform: aws
---

# aws_cloudfront_cache_policies

Use the `aws_cloudfront_cache_policies` InSpec audit resource to test properties of the plural AWS CloudFront CachePolicy.

The AWS::CloudFront::CachePolicy describes the cache policy.

## Syntax

Ensure that the custom resource exists.

    describe aws_cloudfront_cache_policies do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFormation CachePolicy.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cachepolicy.html).

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
| enable_accept_encoding_gzips | A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin. | enable_accept_encoding_gzip |
| enable_accept_encoding_brotlis | A flag that can affect whether the Accept-Encoding HTTP header is included in the cache key and included in requests that CloudFront sends to the origin. | enable_accept_encoding_brotli |
| header_behaviors | Determines whether any HTTP headers are included in the cache key and automatically included in requests that CloudFront sends to the origin. | header_behavior |
| cookie_behavior | Determines whether any cookies in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. | cookie_behavior |
| query_string_behaviors | Determines whether any URL query strings in viewer requests are included in the cache key and automatically included in requests that CloudFront sends to the origin. | query_string_behavior |

## Examples

### Ensure a id is available.
    describe aws_cloudfront_cache_policies do
      its('ids') { should include 'ID' }
    end

### Verify the max ttl of the policy.
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