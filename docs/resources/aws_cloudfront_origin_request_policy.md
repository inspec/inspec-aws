---
title: About the aws_cloudfront_origin_request_policy Resource
platform: aws
---

# aws_cloudfront_origin_request_policy

Use the `aws_cloudfront_origin_request_policy` InSpec audit resource to test properties of a single specific AWS CloudFront origin request policy.

## Syntax

Ensure that the origin request policy exists.

    describe aws_cloudfront_origin_request_policy(id: 'ID') do
      it { should exist }
    end

## Parameters

`id` _(required)_

The unique identifier for the origin request policy.

For additional information, see the [AWS documentation on AWS CloudFront origin request policy.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-originrequestpolicy.html).

## Properties

| Property | Description |
| --- | --- |
| id| The unique identifier for the origin request policy.  |
| last_modified_time | The date and time when the origin request policy was last modified. |
| origin_request_policy_config.comment|  A comment to describe the origin request policy. |
| origin_request_policy_config.name|  A unique name to identify the origin request policy. |
| origin_request_policy_config.headers_config.header_behavior|  Determines whether any HTTP headers are included in requests that CloudFront sends to the origin. |
| origin_request_policy_config.headers_config.headers.quantity|  The number of header names in the Items list. |
| origin_request_policy_config.headers_config.headers.items|  A list of HTTP header names. |
| origin_request_policy_config.cookies_config.cookie_behavior|  Determines whether cookies in viewer requests are included in requests that CloudFront sends to the origin. |
| origin_request_policy_config.cookies_config.cookies.quantity|  The number of cookie names in the Items list. |
| origin_request_policy_config.cookies_config.cookies.items|  A list of cookie names. |
| origin_request_policy_config.query_strings_config.query_string_behavior|  Determines whether any URL query strings in viewer requests are included in requests that CloudFront sends to the origin. |
| origin_request_policy_config.query_strings_config.query_strings.quantity|  The number of query string names in the Items list. |
| origin_request_policy_config.query_strings_config.query_strings.items|  A list of query string names. |

## Examples

### Test that an ID is available.

    describe aws_cloudfront_origin_request_policy(id: 'ID') do
      its('id') { should eq 'ID' }
    end

### Verify the number of cookies.

    describe aws_cloudfront_origin_request_policy(id: 'ID') do
        its('origin_request_policy_config.cookies_config.cookies.quantity') { should eq 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_origin_request_policy(id: 'ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_origin_request_policy(id: 'ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_origin_request_policy(id: 'ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetOriginRequestPolicyResult` action with `Effect` set to `Allow`.
