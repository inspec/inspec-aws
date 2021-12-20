---
title: About the aws_waf_sql_injection_match_set resource
platform: aws
---

# aws_waf_sql_injection_match_set

Use the `aws_waf_sql_injection_match_set` InSpec audit resource to test the properties of a single AWS WAF `SqlInjectionMatchSet` object.

## Syntax

Ensure that a `SqlInjectionMatchSet` object exists.

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
      it { should exist }
    end

## Parameters

`sql_injection_match_set_id` _(required)_

A unique identifier for a `SqlInjectionMatchSet` object.

For additional information, see the [AWS documentation on the `AWS::WAF::SqlInjectionMatchSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sqlinjectionmatchset.html).

## Properties

| Property | Description |
| --- | --- |
| sql_injection_match_set_id | A unique identifier for a `SqlInjectionMatchSet`. |
| name | The name of the `SqlInjectionMatchSet`. |
| sql_injection_match_tuples | Specifies the parts of web requests that you want to inspect for cross-site scripting attacks. |
| sql_injection_match_tuples_field_to_match_types | The part of the web request that you want AWS WAF to search for a specified string. |
| sql_injection_match_tuples_field_to_match_data | When the value of Type is `HEADER`, enter the name of the header that you want AWS WAF to search, for example, `User-Agent` or `Referer`. |
| sql_injection_match_tuples_text_transformations | Text transformations eliminate some of the unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. |

## Examples

### Ensure an injection match set is available.

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
      its('sql_injection_match_set_id') { should eq 'SQL_INJECTION_MATCH_SET_ID' }
    end

### Ensure an injection match set is available..

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
        its('name') { should eq 'SQL_INJECTION_MATCH_SET_NAME' }
    end

### Ensure an injection match set type is `HEADER`.

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
        its('sql_injection_match_tuples_field_to_match_types') { should include 'HEADER' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_sql_injection_match_set(sql_injection_match_set_id: 'SQL_INJECTION_MATCH_SET_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:GetSqlInjectionMatchSetResponse` action with `Effect` set to `Allow`.
