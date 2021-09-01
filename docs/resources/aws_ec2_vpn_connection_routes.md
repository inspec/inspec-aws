---
title: About the aws_ec2_vpn_connection_routes Resource
platform: aws
---

# aws_ec2_vpn_connection_routes

Use the `aws_ec2_vpn_connection_routes` InSpec audit resource to test properties of a plural AWS EC2 VPN Connection Route.

The AWS::EC2::VPNConnectionRoute resource specifies a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway. The static route allows traffic to be routed from the virtual private gateway to the VPN customer gateway.

## Syntax

Ensure that VPN Connection ID exists.

    describe aws_ec2_vpn_connection_routes do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 VPN Connection Route.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection-route.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| destination_cidr_blocks | The CIDR block associated with the local subnet of the customer data center. | destination_cidr_block |
| sources | Indicates how the routes were provided. | source |
| states | The current state of the static route. | state |

## Examples

### Ensure a destination cidr block is available.
    describe aws_ec2_vpn_connection_routes do
      its('destination_cidr_blocks') { should eq ['192.168.10.0/24'] }
    end

### Ensure that the states is `available`.
    describe aws_ec2_vpn_connection_routes do
        its('states') { should eq ['available'] }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpn_connection_routes do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpn_connection_routes do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpnConnectionsResult` action with `Effect` set to `Allow`.