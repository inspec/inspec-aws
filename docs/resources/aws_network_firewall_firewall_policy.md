---
title: About the aws_network_firewall_firewall_policy Resource
platform: aws
---

# aws_network_firewall_firewall_policy

Use the `aws_network_firewall_firewall_policy` InSpec audit resource to test properties of a single specific AWS Network Firewall Policy.

The firewall defines the configuration settings for an AWS Network Firewall firewall. The settings include the firewall policy, the subnets in your VPC to use for the firewall endpoints, and any tags that are attached to the firewall AWS resource.

## Syntax

Ensure that the firewall exists.

    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
      it { should exist }
    end

## Parameters

`firewall_policy_name` _(required)_

| Property | Description |
| --- | --- |
| firewall_name | The descriptive name of the firewall. |

For additional information, see the [AWS documentation on AWS Network Firewall Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| update_token | A token used for optimistic locking. | update_token |
| firewall_policy_response.firewall_policy_name | The descriptive name of the firewall policy. | firewall_policy_name |
| firewall_policy_response.firewall_policy_arn | The Amazon Resource Name (ARN) of the firewall policy. | firewall_policy_arn |
| firewall_policy_response.firewall_policy_id | The unique identifier for the firewall policy. | firewall_policy_id |
| firewall_policy_response.description | A description of the firewall policy. | description |
| firewall_policy_response.firewall_policy_status | The current status of the firewall policy. | firewall_policy_status |
| firewall_policy_response.tags | The key:value pairs to associate with the resource. | tags |
| firewall_policy.stateless_rule_group_references | References to the stateless rule groups that are used in the policy. | stateless_rule_group_references |
| firewall_policy.stateless_rule_group_references.first.resource_arn | The Amazon Resource Name (ARN) of the stateless rule group. | resource_arn |
| firewall_policy.stateless_rule_group_references.first.priority | An integer setting that indicates the order in which to run the stateless rule groups in a single FirewallPolicy. | priority |
| firewall_policy.stateless_default_actions | The actions to take on a fragmented UDP packet if it doesn't match any of the stateless rules in the policy. | stateless_default_actions |
| firewall_policy.stateless_fragment_default_actions | The actions to take on a fragmented UDP packet if it doesn't match any of the stateless rules in the policy. | stateless_fragment_default_actions |]
| firewall_policy.stateless_custom_actions | The custom action definitions that are available for use in the firewall policy's StatelessDefaultActions setting. | stateless_custom_actions | |
| firewall_policy.stateless_custom_actions.first.action_name | The descriptive name of the custom action. | action_name |
| firewall_policy.stateless_custom_actions.first.action_definition.publish_metric_action.dimensions | The value to use in an Amazon CloudWatch custom metric dimension. | dimensions |
| firewall_policy.stateful_rule_group_references | References to the stateless rule groups that are used in the policy. | stateful_rule_group_references |
| firewall_policy.stateful_rule_group_references.first.resource_arn | The Amazon Resource Name (ARN) of the stateful rule group. | resource_arn |

## Examples

### Ensure a update token is available.
    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
      its('update_token') { should eq 'Update_Token' }
    end

### Ensure a policy name is available.
    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
        its('firewall_policy_response.firewall_policy_name') { should eq 'FirewallPolicyName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_network_firewall_firewall_policy(firewall_policy_name: 'FirewallPolicyName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkFirewall:Client:DescribeFirewallPolicyResponse` action with `Effect` set to `Allow`.
