---
title: About the aws_ec2_client_vpn_target_network_associations Resource
platform: aws
---

# aws_ec2_client_vpn_target_network_associations

Use the `aws_ec2_client_vpn_target_network_associations` InSpec audit resource to test properties of multiple AWS EC2 Client VPN target network associations.

The `AWS::EC2::ClientVpnTargetNetworkAssociation` specifies a target network to associate with a Client VPN endpoint.

## Syntax

Ensure that the client vpn target network association exists.

    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
      it { should exist }
    end

## Parameters

`client_vpn_endpoint_id` _(required)_

The ID of the Client VPN endpoint.

For additional information, see the [AWS documentation on AWS EC2 ClientVpnTargetNetworkAssociation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpntargetnetworkassociation.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| association_ids | The ID of the association. | association_id |
| vpc_ids | The ID of the VPC in which the target network (subnet) is located. | vpc_id |
| target_network_ids | The ID of the subnet specified as the target network. | target_network_id |
| client_vpn_endpoint_ids | The ID of the Client VPN endpoint with which the target network is associated. | client_vpn_endpoint_id |
| status_codes | The state of the target network association. | status.code |
| status_messages | A message about the status of the target network association, if applicable. | status.message |
| security_groups | The IDs of the security groups applied to the target network association. | security_groups |

## Examples

### Ensure an association exists.

    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
      its('association_ids') { should include 'ASSOCIATION_ID' }
    end

### Ensure that the status code is `active`.

    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
        its('status_code') { should include 'active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_client_vpn_target_network_associations(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeClientVpnTargetNetworksResult` action with `Effect` set to `Allow`.
