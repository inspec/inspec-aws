---
title: About the aws_ec2_client_vpn_route Resource
platform: aws
---

# aws_ec2_client_vpn_route

Use the `aws_ec2_client_vpn_route` InSpec audit resource to test the properties of a single specific AWS EC2 client VPN route.

The `AWS::EC2::ClientVpnRoute` specifies a network route to add to a client VPN endpoint.

## Syntax

Ensure that the client VPN endpoint exists.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "VPN_ID", target_subnet: "SUBNET_ID") do
      it { should exist }
    end

## Parameters

`client_vpn_endpoint_id` _(required)_

The association between the client VPN endpoint ID and the route.

`target_subnet` _(required)_

The subnet ID to which traffic is routed.

For additional information, see the [AWS documentation on AWS EC2 ClientVpnRoute.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnroute.html).

## Properties

| Property               | Description                                                           | Field              |
| :--------------------: | :-------------------------------------------------------------------: | :----------------: |
| client_vpn_endpoint_id | The association between the client VPN endpoint ID and the route.     | carrier_gateway_id |
| destination_cidr       | The IPv4 address range, in CIDR notation, of the route destination.   | carrier_gateway_id |
| target_subnet          | The subnet ID to which you want to route traffic.                     | carrier_gateway_id |
| type                   | The route type.                                                       | carrier_gateway_id |
| origin                 | Indicates how the route associates with the client VPN endpoint, and the route is automatically added when the target network associates with the client VPN endpoint. | carrier_gateway_id |
| status.code            | The state of the client VPN endpoint route.                           | carrier_gateway_id |
| status.message         | A message about the status of the client VPN endpoint route, if applicable. | carrier_gateway_id |
| description            | A brief description of the route.                                     | carrier_gateway_id |

## Examples

### Ensure a client VPN endpoint ID is available

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "VPN_ID", target_subnet: "SUBNET_ID") do
      its('client_vpn_endpoint_id') { should eq 'VPN_ID' }
    end

### Ensure that the status code is `active`

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "VPN_ID", target_subnet: "SUBNET_ID") do
        its('status.code') { should eq 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "VPN_ID", target_subnet: "SUBNET_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "VPN_ID", target_subnet: "SUBNET_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "VPN_ID", target_subnet: "SUBNET_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeClientVpnRoutesResult` action with `Effect` set to `Allow`.
