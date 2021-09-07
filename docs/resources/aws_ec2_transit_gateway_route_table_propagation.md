---
title: About the aws_ec2_transit_gateway_route_table_propagation Resource
platform: aws
---

# aws\_ec2\_transit_gateway_route\_table\_propagation

Use the `aws_ec2_transit_gateway_route_table_propagation` InSpec audit resource to test properties of a single specific AWS EC2 TransitGatewayRouteTablePropagation.

The AWS::EC2::TransitGatewayRouteTablePropagation resource enables the specified attachment to propagate routes to the specified propagation route table.

## Syntax

Ensure that a transit gateway route table id exists.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TransitGatewayRouteTableId', transit_gateway_attachment_id: "TransitGatewayAttachmentId") do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id transit_gateway_attachment_id` _(required)_

## Properties of the Required Parameter

| Property | Description|
| --- | --- |
| transit_gateway_route_table_id | The ID of the transit gateway route table. |
| transit_gateway_attachment_id | The ID of the attachment. |

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| transit_gateway_attachment_id | The ID of the attachment. | transit_gateway_attachment_id |
| resource_id | The ID of the resource. | resource_id |
| resource_type | The type of resource. | resource_type |
| state | The state of the resource. | state |

## Examples

### Ensure a transit gateway attachment id is available.
    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TransitGatewayRouteTableId', transit_gateway_attachment_id: "TransitGatewayAttachmentId") do
      its('transit_gateway_attachment_id') { should eq 'TransitGatewayRouteTableId' }
    end

### Ensure that the state is `enabled`.
    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TransitGatewayRouteTableId', transit_gateway_attachment_id: "TransitGatewayAttachmentId") do
        its('state') { should eq 'enabled' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TransitGatewayRouteTableId', transit_gateway_attachment_id: "TransitGatewayAttachmentId") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TransitGatewayRouteTableId', transit_gateway_attachment_id: "TransitGatewayAttachmentId") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:get_transit_gateway_route_table_propagations` action with `Effect` set to `Allow`.