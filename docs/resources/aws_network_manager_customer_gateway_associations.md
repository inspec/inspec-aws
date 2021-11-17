---
title: About the aws_network_manager_customer_gateway_associations Resource
platform: aws
---

# aws_network_manager_customer_gateway_associations

Use the `aws_network_manager_customer_gateway_associations` InSpec audit resource to test properties of multiple AWS Network Manager customer gateway associations.

The `AWS::NetworkManager::CustomerGatewayAssociation` resource specifies an association between a customer gateway, a device, and optionally, a link.

## Syntax

Ensure that the customer gateway association exists.

    describe aws_network_manager_customer_gateway_associations(global_network_id: "GLOBAL_NETWORK_ID") do
      it { should exist }
    end

## Parameters

`global_network_id` _(required)_

The ID of the global network.

For additional information, see the [AWS documentation on AWS Network Manager Customer Gateway Association.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-customergatewayassociation.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| customer_gateway_arns | The Amazon Resource Name (ARN) of the customer gateway. | customer_gateway_arn |
| global_network_ids | The ID of the global network. | global_network_id |
| device_ids | The ID of the device.| device_id |
| link_ids | The ID of the link. | link_id |
| states | The association state. | state |

## Examples

### Ensure a customer gateway arn is available.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID') do
      its('customer_gateway_arns') { should include 'CustomerGatewayARN' }
    end

### Ensure that the state is `active`.
    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID') do
        its('states') { should include 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_customer_gateway_association(global_network_id: "dummy") do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:GetCustomerGatewayAssociationsResponse` action with `Effect` set to `Allow`.
