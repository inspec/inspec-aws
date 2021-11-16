---
title: About the aws_network_firewall_firewalls Resource
platform: aws
---

# aws_network_firewall_firewalls

Use the `aws_network_firewall_firewalls` InSpec audit resource to test properties of multiple AWS Network Firewall firewalls.

The firewall defines the configuration settings for an AWS Network Firewall firewall. The settings include the firewall policy, the subnets in your VPC to use for the firewall endpoints, and any tags that are attached to the firewall AWS resource.

## Syntax

Ensure that the firewall exists.

    describe aws_network_firewall_firewalls do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS Network Firewall Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| firewall_names | The descriptive name of the firewall. | firewall_name |
| firewall_arns | The Amazon Resource Name (ARN) of the firewall. | firewall_arn |

## Examples

### Ensure a firewall name is available.

    describe aws_network_firewall_firewalls do
      its('firewall_names') { should include 'FIREWALL_NAME' }
    end

### Ensure that the firewall ARN is `FIREWALL_ARN`.

    describe aws_network_firewall_firewalls do
        its('firewall_arns') { should include 'FIREWALL_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_firewall_firewalls do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_firewall_firewalls do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_network_firewall_firewalls do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkFirewall:Client:DescribeFirewallResponse` action with `Effect` set to `Allow`.
