---
title: About the aws_ec2_client_vpn_authorization_rule Resource
platform: aws
---

# aws_ec2_client_vpn_authorization_rule

Use the `aws_ec2_client_vpn_authorization_rule` InSpec audit resource to test properties of a single specific AWS EC2 Client VPN authorization rule.

The `AWS::EC2::ClientVpnAuthorizationRule` specifies an ingress authorization rule to add to a Client VPN endpoint.

## Syntax

Ensure that the client VPN endpoint association rule exists.

    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
      it { should exist }
    end

## Parameters

`client_vpn_endpoint_id` _(required)_

The ID of the Client VPN endpoint.

`group_id` _(required)_

The ID of the Active Directory group to which the authorization rule grants access.

For additional information, see the [AWS documentation on AWS EC2 Client VPN authorization rule.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnauthorizationrule.html).

## Properties

| Property | Description |
| :---: | :--- |
| client_vpn_endpoint_id | The ID of the Client VPN endpoint with which the authorization rule is associated. |
| description | A brief description of the authorization rule. |
| group_id | The ID of the Active Directory group to which the authorization rule grants access. |
| access_all | Indicates whether the authorization rule grants access to all clients. |
| destination_cidr | The IPv4 address range, in CIDR notation, of the network to which the authorization rule applies. |
| status.code | The state of the authorization rule. |
| status.message | A message about the status of the authorization rule, if applicable. |

## Examples

### Ensure a client VPN endpoint ID is available.

    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
      its('client_vpn_endpoint_id') { should eq 'CLIENT_VPN_ENDPOINT_ID' }
    end

### Ensure that the status code is `active`.

    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
        its('status.code') { should eq 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_client_vpn_authorization_rule(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", group_id: "GROUP_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeClientVpnAuthorizationRulesResult` action with `Effect` set to `Allow`.
