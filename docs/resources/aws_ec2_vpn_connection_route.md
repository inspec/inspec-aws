---
title: About the aws_ec2_vpn_connection_route Resource
platform: aws
---

# aws\_ec2\_vpn\_connection\_route

Use the `aws_ec2_vpn_connection_route` InSpec audit resource to test properties of a single specific AWS EC2 Function.

The AWS::EC2::VPNConnectionRoute resource specifies a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway..

## Syntax

Ensure that a VPN Connection ID exists.

    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'VPNConnectionID') do
      it { should exist }
    end

## Parameters

`vpn_connection_id` _(required)_

## Properties of the Required Parameter

| Property | Description|
| --- | --- |
| vpn_connection_id | The ID of the vpn connection ID. |

For additional information, see the [AWS documentation on AWS EC2 VPNConnectionRoute](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection-route.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| destination_cidr_block | The CIDR block associated with the local subnet of the customer data center. | destination_cidr_block |
| source | Indicates how the routes were provided. | source |
| state | The current state of the static route. | state |

## Examples

### Ensure a destination cidr block is available.
    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'VPNConnectionID') do
      its('destination_cidr_block') { should eq 'destination_cidr_block' }
    end

### Ensure that the state is `available`.
    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'VPNConnectionID') do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'VPNConnectionID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_vpn_connection_route(vpn_connection_id: 'VPNConnectionID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:describe_vpn_connections` action with `Effect` set to `Allow`.