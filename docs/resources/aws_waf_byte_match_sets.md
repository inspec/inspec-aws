---
title: About the aws_waf_byte_match_sets resource
platform: aws
---

# aws_waf_byte_match_sets

Use the `aws_waf_byte_match_sets` Chef InSpec audit resource to test the properties of multiple AWS (Web Application Firewall) WAF byte match sets.

## Syntax

### Ensure that a byte match set exists.

    describe aws_waf_byte_match_sets do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

For additional information, see the [AWS documentation on the `AWS::WAF::ByteMatchSet` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-bytematchset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| byte_match_set_ids | The unique identifier for the ByteMatchSet. | byte_match_set_id |
| names | The name of the ByteMatchSet. | name |

## Examples

### Ensure a byte match set is available.

    describe aws_waf_byte_match_sets do
      its('byte_match_set_ids') { should include 'BYTE_MATCH_SET_ID' }
    end

### Ensure a byte match set name is available.

    describe aws_waf_byte_match_sets do
        its('names') { should include 'BYTE_MATCH_SET_NAME' }
    end

## Matchers

This Chef InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_byte_match_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_byte_match_sets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListByteMatchSetsResponse` action with `Effect` set to `Allow`.
