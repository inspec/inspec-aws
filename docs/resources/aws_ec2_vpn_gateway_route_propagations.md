---
title: About the aws_ec2_transit_gateway_route_table_propagations Resource
platform: aws
---

# aws\_ec2\_transit_gateway_route\_table\_propagations

Use the `aws_ec2_transit_gateway_route_table_propagations` InSpec audit resource to test properties of a plural AWS EC2 VPNGatewayRoutePropagation.

The AWS::EC2::TransitGatewayRouteTablePropagation resource enables a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.

## Syntax

Ensure that a route table ID exists.

    describe aws_ec2_vpn_gateway_route_propagations do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| route_table_ids | The ID of the route table. | route_table_id |
| propagating_vgws_gateway_ids | The ID of the virtual private gateway. | propagating_vgws (gateway_id) |

## Examples

### Ensure a vpn gateway id is available.
    describe aws_ec2_vpn_gateway_route_propagations do
      its('vpn_gateway_id') { should include 'VPNGatewayID' }
    end

### Ensure a route table id is available.
    describe aws_ec2_vpn_gateway_route_propagations do
        its('route_table_id') { include eq 'RouteTableID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpn_gateway_route_propagations do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpn_gateway_route_propagations do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_vpn_gateway_route_propagations do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:describe_route_tables` action with `Effect` set to `Allow`.