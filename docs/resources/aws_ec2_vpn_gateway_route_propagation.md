---
title: About the aws_ec2_vpn_gateway_route_propagation Resource
platform: aws
---

# aws\_ec2\_vpn\_gateway\_route\_propagation

Use the `aws_ec2_vpn_gateway_route_propagation` InSpec audit resource to test if a virtual private gateway can propagate routes to a single AWS EC2 route table.

The `AWS::EC2::TransitGatewayRouteTablePropagation` resource enables a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.

## Syntax

Ensure that a route table ID exists.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'ROUTE_TABLE_ID') do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id` _(required)_

The ID of the route table.

For additional information, see the [AWS documentation on AWS EC2 VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html).

## Properties

| Property | Description |
| --- | --- |
| vpn_gateway_id | The ID of the virtual private gateway. |
| route_table_id | The ID of the route table. |

## Examples

### Ensure a VPN gateway ID is available.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'ROUTE_TABLE_ID') do
      its('vpn_gateway_id') { should eq 'VPN_GATEWAY_ID' }
    end

### Ensure a route table ID is available.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'ROUTE_TABLE_ID') do
        its('route_table_id') { should eq 'ROUTE_TABLE_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'ROUTE_TABLE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'ROUTE_TABLE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'ROUTE_TABLE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeRouteTablesResult` action with `Effect` set to `Allow`.