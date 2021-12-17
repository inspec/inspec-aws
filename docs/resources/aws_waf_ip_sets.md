---
title: About the aws_waf_ip_sets resource
platform: aws
---

# aws_waf_ip_sets

Use the `aws_waf_ip_sets` Chef InSpec audit resource to test the properties of multiple AWS Web Application Firewall (WAF) IP sets.

## Syntax

Ensure that IP set exists.

    describe aws_waf_ip_sets do
      it { should exist }
    end

## Parameters

`ip_set_id` _(required)_

The ID for an IP set.

For additional information, see the [AWS documentation on `AWS::WAF::IPSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-ipset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| ip_set_ids | The IPSetId for an IPSet. | ip_set_id |
| names | A friendly name or description of the IPSet. | name |

## Examples

### Ensure an IP set is available.

    describe aws_waf_ip_sets do
      its('ip_set_ids') { should include 'IP_SET_ID' }
    end

### Ensure an IP set name is available.

    describe aws_waf_ip_sets do
        its('names') { should include 'IP_SET_NAME' }
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
