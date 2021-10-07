---
title: About the aws_network_manager_global_network Resource
platform: aws
---

# aws_network_manager_global_network

Use the `aws_network_manager_global_network` InSpec audit resource to test properties of a specific AWS Network Manager global network.

The `AWS::NetworkManager::GlobalNetwork` resource describes one or more global networks.

## Syntax

Ensure that Global Network ID exists.

    describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should exist }
    end

## Parameters

`global_network_id` _(required)_

The ID of the global network.

For additional information, see the [AWS documentation on AWS Network Manager Global Network](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-globalnetwork.html).

## Properties

| Property | Description |
| --- | --- |
| global_network_id | The ID of the global network. |
| global_network_arn | The Amazon Resource Name (ARN) of the global network. |
| description | The description of the global network. |
| created_at | The date and time that the global network was created. |
| state | The state of the global network. |
| tags | The tags for the global network. |

## Examples

### Ensure a global network ID is available.

    describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
      its('global_network_id') { should eq 'GLOBAL_NETWORK_ID' }
    end

### Ensure that the state is `AVAILABLE`.

    describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
        its('state') { should eq 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_network_manager_global_network(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:DescribeGlobalNetworksResponse` action with `Effect` set to `Allow`.
