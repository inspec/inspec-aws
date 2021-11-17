---
title: About the aws_network_manager_global_networks Resource
platform: aws
---

# aws_network_manager_global_networks

Use the `aws_network_manager_global_networks` InSpec audit resource to test properties of a single specific AWS Network Manager global network.

The `AWS::NetworkManager::GlobalNetwork` resource describes one or more global networks.

## Syntax

Ensure that Global Network ID exists.

    describe aws_network_manager_global_networks do
      it { should exist }
    end

## Parameters

The resource does not require any parameters.

For additional information, see the [AWS documentation on AWS Network Manager Global Network](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-globalnetwork.html).

## Properties

| Property | Description | Description |
| --- | --- | --- |
| global_network_ids | The ID of the global network. | global_network_id |
| global_network_arns | The Amazon Resource Name (ARN) of the global network. | global_network_arn |
| descriptions | The description of the global network. | description |
| created_at | The date and time that the global network was created. | created_at |
| states | The state of the global network. | state |
| tags | The tags for the global network. | tags |

## Examples

### Ensure a Global Network ID is available.
    describe aws_network_manager_global_networks do
      its('global_network_ids') { should include 'GLOBAL_NETWORK_ID' }
    end

### Ensure that the state is `AVAILABLE`.
    describe aws_network_manager_global_networks do
        its('states') { should include 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_global_networks do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_global_networks do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:DescribeGlobalNetworksResponse` action with `Effect` set to `Allow`.
