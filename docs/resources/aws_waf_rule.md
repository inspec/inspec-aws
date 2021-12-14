---
title: About the aws_waf_rule resource
platform: aws
---

# aws_waf_rule

Use the `aws_waf_rule` InSpec audit resource to test the properties of the singular resource of AWS WAF Rule.

## Syntax

Ensure that a WAF rule exists.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
      it { should exist }
    end

## Parameters

`rule_id` _(required)_

A unique identifier for a WAF Rule.

For additional information, see the [AWS documentation on AWS WAF Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-rule.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| rule_id | A unique identifier for a Rule. | rule_id |
| name | The name of the Rule. | name |
| metric_name | The name of the metrics for this Rule. | metric_name |
| predicates_negated | Set Negated to False if you want AWS WAF to allow, block, or count requests based on the settings in the specified ByteMatchSet , IPSet , SqlInjectionMatchSet , XssMatchSet , RegexMatchSet , GeoMatchSet , or SizeConstraintSet . | negated |
| predicates_type | The type of predicate in a Rule , such as ByteMatch or IPSet . | type |
| predicates_data_id | A unique identifier for a predicate in a Rule , such as ByteMatchSetId or IPSetId. | data_id |

## Examples

### Ensure a rule is available.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
      its('rule_id') { should eq 'RULE_ID' }
    end

### Ensure a rule name is available..

    describe aws_waf_rule(rule_id: 'RULE_ID') do
        its('name') { should eq 'RULE_ID_NAME' }
    end

### Ensure an a metric name type is `METRIC_NAME`.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
        its('metric_name') { should include 'METRIC_NAME' }
    end

### Verify the type of data ID should be 'DATA_ID'.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
        its('predicates_data_id') { should include 'DATA_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_rule(rule_id: 'RULE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:GetRuleResponse` action with `Effect` set to `Allow`.