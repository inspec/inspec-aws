---
title: About the aws_ec2_transit_gateway_route_table_propagations Resource
platform: aws
---

# aws\_ec2\_transit_gateway_route\_table\_propagations

Use the `aws_ec2_transit_gateway_route_table_propagations` InSpec audit resource to test properties of multiple propagation routes between Transit Gateway attachments and a Transit Gateway route table.

The `AWS::EC2::TransitGatewayRouteTablePropagation` resource enables the specified attachment to propagate routes to the specified propagation route table.

## Syntax

Ensure that a Transit Gateway route table id exists.

    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id` _(required)_

The ID of the Transit Gateway route table.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| transit_gateway_attachment_ids | A list of the attachment IDs. | transit_gateway_attachment_id |
| resource_ids | A list of the resource IDs. | resource_id |
| resource_types | A list of the resource types. | resource_type |
| states | A list of the resource states. | state |

## Examples

### Ensure that a Transit Gateway attachment ID is available.

    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
      its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ROUTE_TABLE_ID' }
    end

### Ensure that a propagation route is `enabled`.

    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
        its('states') { should include 'enabled' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that an entity exists.

    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
      it { should exist }
    end

Use `should_not` to test an entity does not exist.

    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if an entity is available.

    describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:GetTransitGatewayRouteTablePropagationsResult` action with `Effect` set to `Allow`.