---
title: About the aws_cloudfront_key_group Resource
platform: aws
---

# aws_cloudfront_key_group

Use the `aws_cloudfront_key_group` InSpec audit resource to test properties of a single AWS CloudFront key group.

## Syntax

Ensure that the key group exists.

    describe aws_cloudfront_key_group(id: "ID") do
      it { should exist }
    end

## Parameters

`id` _(required)_

The identifier for the key group.

For additional information, see the [AWS documentation on AWS CloudFront key group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-keygroup.html).

## Properties

| Property | Description |
| --- | --- |
| id | The identifier for the key group. |
| last_modified_time | The date and time when the key group was last modified. |
| key_group_config.name | A name to identify the key group. |
| key_group_config.items | A list of the identifiers of the public keys in the key group. |
| key_group_config.comment | A comment to describe the key group. The comment cannot be longer than 128 characters. |

## Examples

### Ensure an ID is available.

    describe aws_cloudfront_key_group(id: "ID") do
      its('id') { should eq 'ID' }
    end

### Ensure that the key group name is available.

    describe aws_cloudfront_key_group(id: "ID") do
        its('key_group_config.name') { should eq 'KEY_GROUP_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudfront_key_group(id: "ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudfront_key_group(id: "ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudfront_key_group(id: "ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:GetKeyGroupResult` action with `Effect` set to `Allow`.
