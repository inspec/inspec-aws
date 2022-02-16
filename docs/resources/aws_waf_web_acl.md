---
title: About the aws_waf_web_acl resource
platform: aws
---

# aws_waf_web_acl

Use the `aws_waf_web_acl` InSpec audit resource to test the properties of a single AWS WAF web ACL.

The `AWS::WAFv2::WebACL` AWS resource defines a collection of rules to use to inspect and control web requests.

## Syntax

Ensure that a web ACL exists.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
      it { should exist }
    end

## Parameters

`web_acl_id` _(required)_

The unique identifier for the web ACL.

For additional information, see the [AWS documentation on the `AWS::WAFv2::WebACL` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-webacl.html).

## Properties

| Property | Description |
| :---: | :--- |
| web_acl_id | The unique identifier for the web ACL. |
| name | The name of the web ACL. |
| default_action.type | Specifies how you want AWS WAF to respond to requests that match the settings in a Rule. |
| rules | An array that contains the action for each Rule in a `WebACL`, the priority of the `Rule`, and the ID of the `Rule`. |
| rules_priorities | Specifies the order in which the Rules in a WebACL are evaluated. |
| rules_rule_ids | The RuleId for a Rule. |
| rules_actions | Specifies the action that CloudFront or AWS WAF takes when a web request matches the conditions in the Rule. |
| rules_action_types | Specifies how you want AWS WAF to respond to requests that match the settings in a Rule. |
| rules_override_actions | Use the OverrideAction to test your RuleGroup. |
| rules_override_action_types | The type of the OverrideAction to test your RuleGroup. |
| rules_types | The rule type, either `REGULAR`, as defined by Rule, `RATE_BASED`, as defined by RateBasedRule, or `GROUP`, as defined by RuleGroup. |
| rules_excluded_rules | An array of rules to exclude from a rule group. |
| rules_excluded_rules_rule_ids | The unique identifier for the rule to exclude from the rule group. |
| web_acl_arn | Tha Amazon Resource Name (ARN) of the web ACL. |

## Examples

### Ensure a web ACL is available.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
      its('web_acl_id') { should eq 'WEB_ACL_ID' }
    end

### Ensure a web ACL name is available.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
        its('name') { should eq 'WEB_ACL_NAME' }
    end

### Ensure a web ACL rule type is `REGULAR`.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
        its('rules_types') { should include 'REGULAR' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_web_acl(web_acl_id: 'WEB_ACL_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:GetWebACLResponse` action with `Effect` set to `Allow`.
