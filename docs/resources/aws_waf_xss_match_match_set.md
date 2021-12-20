---
title: About the aws_waf_xss_match_set resource
platform: aws
---

# aws_waf_xss_match_set

Use the `aws_waf_xss_match_set` InSpec audit resource to test the properties of a single AWS WAF `XssMatchSet` object.

## Syntax

Ensure that an `XssMatchSet` object exists.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      it { should exist }
    end

## Parameters

`xss_match_set_id` _(required)_

A unique identifier for an `XssMatchSet`.

For additional information, see the [AWS documentation on the `AWS::WAF::XssMatchSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-xssmatchset.html).

## Properties

| Property | Description |
| --- | --- |
| xss_match_set_id | A unique identifier for an `XssMatchSet`. |
| name | The name of the `XssMatchSet`. |
| xss_match_tuples | Specifies the parts of web requests that you want to inspect for cross-site scripting attacks. |
| xss_match_tuples_field_to_match_types | The part of the web request that you want AWS WAF to search for a specified string. |
| xss_match_tuples_field_to_match_data | When the value of Type is HEADER , enter the name of the header that you want AWS WAF to search, for example, User-Agent or Referer. |
| xss_match_tuples_text_transformations | Text transformations eliminate some of the unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. |

## Examples

### Ensure an `XssMatchSet` object is available.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      its('xss_match_set_id') { should eq 'XSS_MATCH_SET_ID' }
    end

### Verify the name of an `XssMatchSet` object.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
        its('name') { should eq 'XSS_MATCH_SET_NAME' }
    end

### Verify an `XssMatchSet` object has a type of `URI`.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
        its('xss_match_tuples_field_to_match_types') { should include 'URI' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:GetXssMatchSetResponse` action with `Effect` set to `Allow`.
