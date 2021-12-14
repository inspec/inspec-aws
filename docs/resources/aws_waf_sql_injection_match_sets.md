---
title: About the aws_waf_sql_injection_match_sets resource
platform: aws
---

# aws_waf_sql_injection_match_sets

Use the `aws_waf_sql_injection_match_sets` InSpec audit resource to test the properties of the plural resource of AWS WAF SqlInjectionMatchSet.

## Syntax

Ensure that injection match set exists.

    describe aws_waf_sql_injection_match_sets do
      it { should exist }
    end

## Parameters

No parameters required.

For additional information, see the [AWS documentation on AWS WAF SqlInjectionMatchSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sqlinjectionmatchset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| sql_injection_match_set_ids | A unique identifier for a SqlInjectionMatchSet. | sql_injection_match_set_id |
| names | The name of the SqlInjectionMatchSet. | name |

## Examples

### Ensure an injection match set is available.

    describe aws_waf_sql_injection_match_sets do
      its('sql_injection_match_set_ids') { should include 'SQL_INJECTION_MATCH_SET_ID' }
    end

### Ensure an injection match set is available..

    describe aws_waf_sql_injection_match_sets do
        its('names') { should include 'SQL_INJECTION_MATCH_SET_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_sql_injection_match_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_sql_injection_match_sets do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_sql_injection_match_sets do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListSqlInjectionMatchSetsResponse` action with `Effect` set to `Allow`.
