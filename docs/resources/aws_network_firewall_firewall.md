---
title: About the aws_network_firewall_firewall Resource
platform: aws
---

# aws_network_firewall_firewall

Use the `aws_network_firewall_firewall` InSpec audit resource to test properties of a single specific AWS Network Firewall firewall.

The firewall defines the configuration settings for an AWS Network Firewall firewall. The settings include the firewall policy, the subnets in your VPC to use for the firewall endpoints, and any tags that are attached to the firewall AWS resource.

## Syntax

Ensure that the firewall exists.

    describe aws_network_firewall_firewall(firewall_name: "FIREWALL_NAME") do
      it { should exist }
    end

## Parameters

`firewall_name` _(required)_

The descriptive name of the firewall.

For additional information, see the [AWS documentation on AWS Network Firewall Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

## Properties

| Property | Description |
| :---: | :--- |
| firewall.firewall_name | The descriptive name of the firewall. |
| firewall.firewall_arn | The Amazon Resource Name (ARN) of the firewall. |
| firewall.firewall_policy_arn | The Amazon Resource Name (ARN) of the firewall policy. |
| firewall.vpc_id | The unique identifier of the VPC where the firewall is in use. |
| firewall.subnet_mappings | The public subnets that Network Firewall is using for the firewall. |
| firewall.subnet_mappings.first.subnet_id | The unique identifier for the subnet. |
| firewall.delete_protection | A flag indicating whether it is possible to delete the firewall. |
| firewall.subnet_change_protection | A setting indicating whether the firewall is protected against changes to the subnet associations. Use this setting to protect against accidentally modifying the subnet associations for a firewall that is in use.  |
| firewall.firewall_policy_change_protection | A setting indicating whether the firewall is protected against a change to the firewall policy association. Use this setting to protect against accidentally modifying the firewall policy for a firewall that is in use.  |
| firewall.description | A description of the firewall. |
| firewall.firewall_id | The unique identifier for the firewall. |
| firewall.tags | A key:value pair associated with an AWS resource. |
| firewall_status.status | The readiness of the configured firewall to handle network traffic across all of the Availability Zones where you've configured it. |
| firewall_status.configuration_sync_state_summary | The configuration sync state for the firewall. |
| firewall_status.sync_states | The subnets that you've configured for use by the Network Firewall firewall. |
| firewall_status.sync_states["AvailabilityZone"].attachment.subnet_id | The unique identifier of the subnet that you've specified to be used for a firewall endpoint. |
| firewall_status.sync_states["AvailabilityZone"].attachment.endpoint_id | The identifier of the firewall endpoint that Network Firewall has instantiated in the subnet. |
| firewall_status.sync_states["AvailabilityZone"].attachment.status | The current status of the firewall endpoint in the subnet. |
| firewall_status.sync_states["AvailabilityZone"].config | The configuration status of the firewall endpoint in a single VPC subnet. |
| firewall_status.sync_states["AvailabilityZone"].config["ResourceName"].sync_status | Indicates whether this object is in sync with the version indicated in the update token. |
| firewall_status.sync_states["AvailabilityZone"].config["ResourceName"].update_token | The current version of the object that is either in sync or pending synchronization. |


## Examples

### Ensure a firewall name is available.

    describe aws_network_firewall_firewall(firewall_name: "FIREWALL_NAME") do
      its('firewall.firewall_name') { should eq 'IAMFleetRole' }
    end

### Ensure that the status is `READY`.

    describe aws_network_firewall_firewall(firewall_name: "FIREWALL_NAME") do
        its('firewall_status.status') { should eq 'READY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_firewall_firewall(firewall_name: "FIREWALL_NAME") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_firewall_firewall(firewall_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_network_firewall_firewall(firewall_name: "FIREWALL_NAME") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkFirewall:Client:DescribeFirewallResponse` action with `Effect` set to `Allow`.
