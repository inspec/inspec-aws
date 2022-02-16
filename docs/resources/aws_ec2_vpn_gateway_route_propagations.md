---
title: About the aws_ec2_vpn_gateway_route_propagations Resource
platform: aws
---

# aws_ec2_vpn_gateway_route_propagations

Use the `aws_ec2_vpn_gateway_route_propagations` InSpec audit resource to test if virtual private gateways can propagate routes to multiple AWS EC2 route tables.

The `AWS::EC2::VPNGatewayRoutePropagation` resource enables a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.

## Syntax

Ensure that a route table exists.

    describe aws_ec2_vpn_gateway_route_propagations do
      it { should exist }
    end

## Parameters

This resource does not require any required parameters.

For additional information, see the [AWS documentation on AWS EC2 VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| route_table_ids | The ID of the route table. | route_table_id |
| propagating_vgws_gateway_ids | The ID of the virtual private gateway. | propagating_vgws_gateway_ids |

## Examples

### Ensure a VPN gateway ID is available.

    describe aws_ec2_vpn_gateway_route_propagations do
      its('propagating_vgws_gateway_ids') { should include 'VPN_GATEWAY_ID' }
    end

### Ensure a route table ID is available.

    describe aws_ec2_vpn_gateway_route_propagations do
        its('route_table_ids') { should include 'ROUTE_TABLE_ID' }
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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeRouteTablesResult` action with `Effect` set to `Allow`.
