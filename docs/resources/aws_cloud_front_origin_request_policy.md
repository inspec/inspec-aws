---
title: About the aws_cloud_front_origin_request_policy Resource
platform: aws
---

# aws_cloud_front_origin_request_policy

Use the `aws_cloud_front_origin_request_policy` InSpec audit resource to test properties of a single specific AWS CloudFront Origin Request Policy.

## Syntax

Ensure that the custom resource exists.

    describe aws_cloud_front_origin_request_policy(id: 'ID') do
      it { should exist }
    end

## Parameters

`id` _(required)_

| Property | Description |
| --- | --- |
| id | The unique identifier for the origin request policy. |

For additional information, see the [AWS documentation on AWS CloudFormation CachePolicy.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-cachepolicy.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| origin_request_policy.id| The unique identifier for the origin request policy.  | origin_request_policy.id |
| origin_request_policy.last_modified_time | The date and time when the origin request policy was last modified. | last_modified_time |
| etag | The current version of the origin request policy. | etag |

## Examples

### Ensure a id is available.
    describe aws_cloud_front_origin_request_policy(id: 'ID') do
      its('id') { should eq 'ID' }
    end

### Verify the max ttl of the policy.
    describe aws_cloud_front_origin_request_policy(id: 'ID') do
        its('etag') { should eq 'ETAG' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloud_front_origin_request_policy(id: 'ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloud_front_origin_request_policy(id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloud_front_origin_request_policy(id: 'ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetOriginRequestPolicyResult` action with `Effect` set to `Allow`.