---
title: About the aws_elasticloadbalancingv2_listener_rules Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_rules

Use the `aws_elasticloadbalancingv2_listener_rules` InSpec audit resource to test properties of multiple listener rules associated with an Application Load Balancer.

Each rule consists of a priority, one or more actions, and one or more conditions.

## Syntax

Ensure that a listener ARN exists.

    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

## Parameters

`listener_arn`  _(required)_

The ARN of the listener.

For additional information, see the [AWS documentation on ELBv2 Listener Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html).

## Properties

| Property | Description | Fields |
| --- | ---    | ---    |
| rule_arns    | The Amazon Resource Name (ARN) of the rule. | rule_arns    |
| priorities   | The rule priority. | priorities   |
| conditions   | The conditions for listener rules. Each rule can include zero or one of the following conditions: `http-request-method` , `host-header` , `path-pattern` , and `source-ip`, and zero or more of the following conditions: `http-header` and `query-string`. | conditions   |
| actions      | The actions for listener rules. Each rule includes exactly one of the following types of actions: `forward`, `redirect`, or `fixed-response`. | actions      |
| is_defaults  | Indicates whether this is the default rule. | is_defaults  |

## Examples

### Ensure a listener ARN is available.

    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
      its('rule_arns') { should include 'RULE_ARN' }
    end

### Verify the priority of the desired rule ARN.

    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
        its('priorities') { should include 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElasticLoadBalancingV2:Client:DescribeRulesOutput` action with `Effect` set to `Allow`.