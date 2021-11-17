---
title: About the aws_network_firewall_rule_groups Resource
platform: aws
---

# aws_network_firewall_rule_groups

Use the `aws_network_firewall_rule_groups` InSpec audit resource to test properties of multiple AWS Network Firewall rule groups.

The `AWS::NetworkFirewall::RuleGroup` resource defines a reusable collection of stateless or stateful network traffic filtering rules.

## Syntax

Ensure that the rule group exists.

    describe aws_network_firewall_rule_groups do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS Network Firewall Rule Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| names | The descriptive name of the rule group. | name |
| arns | The Amazon Resource Name (ARN) of the rule group. | arn |

## Examples

### Ensure a name is available.

    describe aws_network_firewall_rule_groups do
      its('names') { should include 'RULE_GROUP_NaAME' }
    end

### Ensure that the arn is available.

    describe aws_network_firewall_rule_groups do
        its('arns') { should include 'ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_firewall_rule_groups do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_firewall_rule_groups do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkFirewall:Client:ListRuleGroupsResponse` action with `Effect` set to `Allow`.
