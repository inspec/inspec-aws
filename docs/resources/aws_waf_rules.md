---
title: About the aws_waf_rules resource
platform: aws
---

# aws_waf_rules

Use the `aws_waf_rules` Chef InSpec audit resource to test the properties of multiple AWS WAF (web application firewall) rules.

## Syntax

Ensure that a WAF rule exists.

    describe aws_waf_rules do
      it { should exist }
    end

## Parameters

No required parameters.

For additional information, see the [AWS documentation on the `AWS::WAF::Rule` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-rule.html).

## Properties

| Property | Description                         | Fields  |
|----------|-------------------------------------|---------|
| rule_ids | The unique identifier for the rule. | rule_id |
| names    | A friendly name or description of the rule. | name    |

## Examples

### Ensure a rule is available by rule ID.

    describe aws_waf_rules do
      its('rule_ids') { should include 'RULE_ID' }
    end

### Ensure a rule is available by name.

    describe aws_waf_rules do
        its('names') { should include 'RULE_NAMES' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_rules do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_rules do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_rules do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListRulesResponse` action with `Effect` set to `Allow`.
