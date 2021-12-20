---
title: About the aws_waf_xss_match_sets resource
platform: aws
---

# aws_waf_xss_match_sets

Use the `aws_waf_xss_match_sets` InSpec audit resource to test the properties of multiple AWS WAF `XssMatchSet` objects.

## Syntax

Ensure that any `XssMatchSet` object exists.

    describe aws_waf_xss_match_sets do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on the `AWS::WAF::XssMatchSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-xssmatchset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| xss_match_set_ids | A unique identifier for an `XssMatchSet`. | xss_match_set_id |
| names | The name of the `XssMatchSet`. | name |

## Examples

### Verify an `XssMatchSet` object is available by ID.

    describe aws_waf_xss_match_sets do
      its('xss_match_set_ids') { should include 'XSS_MATCH_SET_ID' }
    end

### Verify an `XssMatchSet` object name is available.

    describe aws_waf_xss_match_sets do
        its('names') { should include 'XSS_MATCH_SET_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_xss_match_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_xss_match_sets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListXssMatchSetsResponse` action with `Effect` set to `Allow`.
