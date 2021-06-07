---
title: About the aws_elasticloadbalancingv2_listener_rules Resource
platform: aws
---

# aws\_elasticloadbalancingv2\_listener\_rules

Use the `aws_elasticloadbalancingv2_listener_rules` InSpec audit resource to test properties of a plural Athena Work Groups.

The AWS::ElasticLoadBalancingV2::ListenerRule specifies a listener rule. The listener must be associated with an Application Load Balancer. Each rule consists of a priority, one or more actions, and one or more conditions.

## Syntax

Ensure that a rule_arns exists.
    describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'test1') do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on ELBv2 Listener Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html).

## Properties

| Property | Description|
| --- | --- |
| rule_arns | The Amazon Resource Names (ARN) of the rules. |
| priorities | The priority. |
| conditions | The conditions. Each rule can include zero or one of the following conditions: http-request-method , host-header , path-pattern , and source-ip , and zero or more of the following conditions: http-header and query-string. Information about a condition for a rule. Each rule can optionally include up to one of each of the following conditions: http-request-method , host-header , path-pattern , and source-ip . Each rule can also optionally include one or more of each of the following conditions: http-header and query-string . |
| actions | The actions. Each rule must include exactly one of the following types of actions: forward , redirect , or fixed-response , and it must be the last action to be performed. Information about an action. Each rule must include exactly one of the following types of actions: forward , fixed-response , or redirect , and it must be the last action to be performed. |
| is_defaults | Indicates whether this is the default rule. |

## Examples

### Ensure a rule_arns is available.
    describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'test1') do
      its('names') { should include 'test1' }
    end

### Verify the priority of the desired rule arn
    describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'test1') do
        its('priorities') { should include 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_elasticloadbalancingv2_listener_rules(rule_arns: 'test1') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elb_client_v2.describe_rules` action with `Effect` set to `Allow`.