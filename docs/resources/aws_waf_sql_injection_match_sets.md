---
title: About the aws_waf_sql_injection_match_sets resource
platform: aws
---

# aws_waf_sql_injection_match_sets

Use the `aws_waf_sql_injection_match_sets` Chef InSpec audit resource to test the properties of multiple AWS WAF `SqlInjectionMatchSet` objects.

## Syntax

Ensure that a `SqlInjectionMatchSet` object exists.

    describe aws_waf_sql_injection_match_sets do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on the `AWS::WAF::SqlInjectionMatchSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sqlinjectionmatchset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| sql_injection_match_set_ids | A unique identifier for a `SqlInjectionMatchSet`. | sql_injection_match_set_id |
| names | The name of the `SqlInjectionMatchSet`. | name |

## Examples

### Ensure an injection match set is available.

    describe aws_waf_sql_injection_match_sets do
      its('sql_injection_match_set_ids') { should include 'SQL_INJECTION_MATCH_SET_ID' }
    end

### Ensure an injection match set is available.

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
