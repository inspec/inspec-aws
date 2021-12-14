---
title: About the aws_waf_xss_match_set resource
platform: aws
---

# aws_waf_xss_match_set

Use the `aws_waf_xss_match_set` InSpec audit resource to test the properties of the singular resource of AWS WAF XssMatchSet.

## Syntax

Ensure that xss match set exists.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      it { should exist }
    end

## Parameters

`xss_match_set_id` _(required)_

A unique identifier for an XssMatchSet.

For additional information, see the [AWS documentation on AWS WAF XssMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-xssmatchset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| xss_match_set_id | A unique identifier for an XssMatchSet. | xss_match_set_id |
| name | The name of the XssMatchSet. | name |
| xss_match_tuples | Specifies the parts of web requests that you want to inspect for cross-site scripting attacks. | xss_match_tuples |
| xss_match_tuples_field_to_match_types | The part of the web request that you want AWS WAF to search for a specified string. | xss_match_tuples (field_to_match (type)) |
| xss_match_tuples_field_to_match_data | When the value of Type is HEADER , enter the name of the header that you want AWS WAF to search, for example, User-Agent or Referer. | xss_match_tuples (field_to_match (data)) |
| xss_match_tuples_text_transformations | Text transformations eliminate some of the unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. | xss_match_tuples (text_transformation) |

## Examples

### Ensure a xss match set is available.

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
      its('xss_match_set_id') { should eq 'XSS_MATCH_SET_ID' }
    end

### Ensure a xss match setl name is available..

    describe aws_waf_xss_match_set(xss_match_set_id: 'XSS_MATCH_SET_ID') do
        its('name') { should eq 'XSS_MATCH_SET_NAME' }
    end

### Ensure a xss match set type is `URI`.

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
