---
title: About the aws_ec2_transit_gateway_route_table_propagation Resource
platform: aws
---

# aws\_ec2\_transit_gateway_route\_table\_propagation

Use the `aws_ec2_transit_gateway_route_table_propagation` InSpec audit resource to test properties of a propagation route between a Transit Gateway attachment and a Transit Gateway route table.

The `AWS::EC2::TransitGatewayRouteTablePropagation` resource enables the specified attachment to propagate routes to the specified propagation route table.

## Syntax

Ensure that a Transit Gateway route table id exists.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id` _(required)_

The ID of the Transit Gateway route table.

`transit_gateway_attachment_id` _(required)_

The ID of the attachment.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html).

## Properties

| Property | Description |
| --- | --- |
| transit_gateway_attachment_id | The ID of the attachment. |
| resource_id | The ID of the resource. |
| resource_type | The type of resource. |
| state | The state of the resource. |

## Examples

### Ensure a Transit Gateway attachment ID is available.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
      its('transit_gateway_attachment_id') { should eq 'TRANSIT_GATEWAY_ROUTE_TABLE_ID' }
    end

### Ensure that the state is `enabled`.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
        its('state') { should eq 'enabled' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:GetTransitGatewayRouteTablePropagationsResult` action with `Effect` set to `Allow`.
