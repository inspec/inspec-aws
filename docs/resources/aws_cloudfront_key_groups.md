---
title: About the aws_cloudfront_key_groups Resource
platform: aws
---

# aws_cloudfront_key_groups

Use the `aws_cloudfront_key_groups` InSpec audit resource to test properties of multiple AWS CloudFront key groups.

## Syntax

Ensure that the key group exists.

    describe aws_cloudfront_key_groups do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront key group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-keygroup.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| ids | The identifier for the key group. | id |
| last_modified_times | The date and time when the key group was last modified. | last_modified_time |
| names | A name to identify the key group. | name |
| items | A list of the identifiers of the public keys in the key group. | items |
| comments | A comment to describe the key group. The comment cannot be longer than 128 characters. | comment |

## Examples

### Ensure an ID is available.

    describe aws_cloudfront_key_groups do
      its('ids') { should include 'ID' }
    end

### Ensure that the key group name is available.

    describe aws_cloudfront_key_groups do
        its('names') { should include 'KEY_GROUP_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_key_groups do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_cloudfront_key_groups do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:ListKeyGroupsResult` action with `Effect` set to `Allow`.
