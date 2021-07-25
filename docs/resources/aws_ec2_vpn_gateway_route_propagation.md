---
title: About the aws_ec2_vpn_gateway_route_propagation Resource
platform: aws
---

# aws\_ec2\_vpn\_gateway\_route\_propagation

Use the `aws_ec2_vpn_gateway_route_propagation` InSpec audit resource to test properties of a single specific AWS EC2 VPNGatewayRoutePropagation.

The AWS::EC2::TransitGatewayRouteTablePropagation resource enables a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.

## Syntax

Ensure that a route table ID exists.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'RouteTableID') do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id` _(required)_

## Properties of the Required Parameter

| Property | Description|
| --- | --- |
| route_table_id | The ID of the route table. |

For additional information, see the [AWS documentation on AWS EC2 VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| vpn_gateway_id | The ID of the virtual private gateway. | vpn_gateway_id |
| route_table_id | The ID of the route table. | route_table_id |

## Examples

### Ensure a vpn gateway id is available.
    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'RouteTableID') do
      its('vpn_gateway_id') { should eq 'VPNGatewayID' }
    end

### Ensure a route table id is available.
    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'RouteTableID') do
        its('route_table_id') { should eq 'RouteTableID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'RouteTableID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_vpn_gateway_route_propagation(route_table_id: 'RouteTableID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:describe_route_tables` action with `Effect` set to `Allow`.