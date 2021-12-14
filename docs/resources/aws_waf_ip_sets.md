---
title: About the aws_waf_ip_sets resource
platform: aws
---

# aws_waf_ip_sets

Use the `aws_waf_ip_sets` InSpec audit resource to test the properties of the plural resource of AWS WAF IPSet.

## Syntax

Ensure that ip set exists.

    describe aws_waf_ip_sets do
      it { should exist }
    end

## Parameters

`ip_set_id` _(required)_

The IPSetId for an IPSet.

For additional information, see the [AWS documentation on AWS WAF IPSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| ip_set_ids | The IPSetId for an IPSet. | ip_set_id |
| names | A friendly name or description of the IPSet. | name |

## Examples

### Ensure a ip set is available.

    describe aws_waf_ip_sets do
      its('ip_set_id') { should include 'WEB_ACL_ID' }
    end

### Ensure a ip set name is available..

    describe aws_waf_ip_sets do
        its('name') { should include 'WEB_ACL_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_ip_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_ip_sets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListIPSetsResponse` action with `Effect` set to `Allow`.