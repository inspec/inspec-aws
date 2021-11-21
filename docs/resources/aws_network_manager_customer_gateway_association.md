---
title: About the aws_network_manager_customer_gateway_association Resource
platform: aws
---

# aws_network_manager_customer_gateway_association

Use the `aws_network_manager_customer_gateway_association` InSpec audit resource to test properties of a single specific AWS Network Manager customer gateway association.

The `AWS::NetworkManager::CustomerGatewayAssociation` resource specifies an association between a customer gateway, a device, and optionally, a link.

## Syntax

Ensure that the customer gateway association exists.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
      it { should exist }
    end

## Parameters

`global_network_id` _(required)_

The ID of the global network.

`customer_gateway_arn` _(required)_

The Amazon Resource Name (ARN) of the customer gateway.

For additional information, see the [AWS documentation on AWS Network Manager Customer Gateway Association.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkmanager-customergatewayassociation.html).

## Properties

| Property | Description |
| --- | --- |
| customer_gateway_arn | The Amazon Resource Name (ARN) of the customer gateway. |
| global_network_id | The ID of the global network. |
| device_id | The ID of the device.|
| link_id | The ID of the link. |
| state | The association state. |

## Examples

### Ensure a customer gateway arn is available.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
      its('customer_gateway_arn') { should eq 'CustomerGatewayARN' }
    end

### Ensure that the state is `active`.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
        its('state') { should eq 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_network_manager_customer_gateway_association(global_network_id: 'GLOBAL_NETWORK_ID', customer_gateway_arn: 'CUSTOMER_GATEWAY_ARN') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `NetworkManager:Client:GetCustomerGatewayAssociationsResponse` action with `Effect` set to `Allow`.
