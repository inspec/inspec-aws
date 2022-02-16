---
title: About the aws_network_firewall_firewall_policies Resource
platform: aws
---

# aws_network_firewall_firewall_policies

Use the `aws_network_firewall_firewall_policies` InSpec audit resource to test properties of multiple AWS Network Firewall Policy.

The firewall defines the configuration settings for an AWS Network Firewall firewall. The settings include the firewall policy, the subnets in your VPC to use for the firewall endpoints, and any tags that are attached to the firewall AWS resource.

## Syntax

Ensure that the policy exists.

    describe aws_network_firewall_firewall_policies do
      it { should exist }
    end

## Parameters

This resource does not require any required parameters.

For additional information, see the [AWS documentation on AWS Network Firewall Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

## Properties

| Property | Description | Fields | 
| --- | --- | --- |
| firewall_names | The descriptive name of the firewall. | firewall_name |
| firewall_arns | The Amazon Resource Name (ARN) of the firewall. | firewall_arn |

## Examples

### Ensure a policy name is available.

    describe aws_network_firewall_firewall_policies do
      its('names') { should include 'FIREWALL_NAME' }
    end

### Ensure that the policy arn is available.

    describe aws_network_firewall_firewall_policies do
        its('arns') { should include 'POLICY_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `List` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_firewall_firewall_policies do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_firewall_firewall_policies do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkFirewall:Client:ListFirewallPoliciesResponse` action with `Effect` set to `Allow`.
