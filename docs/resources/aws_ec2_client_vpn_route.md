---
title: About the aws_ec2_client_vpn_route Resource
platform: aws
---

# aws_ec2_client_vpn_route

Use the `aws_ec2_client_vpn_route` InSpec audit resource to test properties of a single specific AWS EC2 Client VPN route.

The `AWS::EC2::ClientVpnRoute` specifies a network route to add to a Client VPN endpoint.

## Syntax

Ensure that the client VPN endpoint exists.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
      it { should exist }
    end

## Parameters

`client_vpn_endpoint_id` _(required)_

The ID of the Client VPN endpoint with which the route is associated.

`target_subnet` _(required)_

The ID of the subnet through which traffic is routed.

For additional information, see the [AWS documentation on AWS EC2 ClientVpnRoute.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnroute.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| client_vpn_endpoint_id | The ID of the Client VPN endpoint with which the route is associated. | carrier_gateway_id |
| destination_cidr | The IPv4 address range, in CIDR notation, of the route destination. | carrier_gateway_id |
| target_subnet | The ID of the subnet through which traffic is routed. | carrier_gateway_id |
| type | The route type. | carrier_gateway_id |
| origin | Indicates how the route was associated with the Client VPN endpoint. associate indicates that the route was automatically added when the target network was associated with the Client VPN endpoint. | carrier_gateway_id |
| status.code | The state of the Client VPN endpoint route. | carrier_gateway_id |
| status.message | A message about the status of the Client VPN endpoint route, if applicable. | carrier_gateway_id |
| description | A brief description of the route. | carrier_gateway_id |

## Examples

### Ensure a client VPN endpoint ID is available.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
      its('client_vpn_endpoint_id') { should eq 'CLIENT_VPN_ENDPOINT_ID' }
    end

### Ensure that the status code is `active`.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
        its('status.code') { should eq 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeClientVpnRoutesResult` action with `Effect` set to `Allow`.
