---
title: About the aws_ec2_client_vpn_routes Resource
platform: aws
---

# aws_ec2_client_vpn_routes

Use the `aws_ec2_client_vpn_routes` InSpec audit resource to test the properties of multiple AWS EC2 client VPN routes.

The `AWS::EC2::ClientVpnRoute` specifies the network route to add to a client VPN endpoint.

## Syntax

Ensure that the client VPN endpoint exists.

    describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "VPN_ID") do
      it { should exist }
    end

## Parameters

`client_vpn_endpoint_id` _(required)_

The association between the client VPN endpoint ID and the route.

For additional information, see the [AWS documentation on AWS EC2 ClientVpnRoute.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnroute.html).

## Properties

| Property                 | Description                                                           | Field                  |
| :----------------------: | :-------------------------------------------------------------------: | :--------------------: |
| client_vpn_endpoint_ids  | The association between the client VPN endpoint ID and the route.     | client_vpn_endpoint_id |
| destination_cidrs        | The IPv4 address range, in CIDR notation, of the route destination.   | destination_cidr       |
| target_subnets           | The subnet ID to which you want to route traffic                      | target_subnet          |
| types                    | The route type.                                                       | type                   |
| origins                  | Indicates how the route associates with the client VPN endpoint, and the route is automatically added when the target network associates with the client VPN endpoint. | origin |
| status_codes             | The state of the client VPN endpoint route.                           | status.code |
| status_messages          | A message about the status of the client VPN endpoint route, if applicable.    | status.message |
| descriptions             | A brief description of the route.                                      | carrier_gateway_id |

## Examples

### Ensure a client VPN endpoint ID is available

    describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "VPN_ID") do
      its('client_vpn_endpoint_ids') { should include 'VPN_ID' }
    end

### Ensure that the status code is `active`

    describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "VPN_ID") do
        its('status_codes') { should include 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "VPN_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "VPN_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "VPN_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeClientVpnRoutesResult` action with `Effect` set to `Allow`.
