---
title: About the aws_ec2_vpn_gateway_route_propagations Resource
platform: aws
---

# aws_ec2_vpn_gateway_route_propagations

Use the `aws_ec2_vpn_gateway_route_propagations` InSpec audit resource to test properties of a plural AWS EC2 Network Interface Attachment.

The AWS::EC2::VPNGatewayRoutePropagation resource enables a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.

## Syntax

Ensure that Network Interface Attachment exists.

    describe aws_ec2_network_interface_attachments do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 VPN Gateway Route Propagation.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html).

## Properties

| Property | Description|
| --- | --- |
| attach_times | The timestamp indicating when the attachment initiated. | attach_time |
| attachment_ids | The ID of the network interface attachment. | attachment_id |
| delete_on_terminations | Indicates whether the network interface is deleted when the instance is terminated. | delete_on_termination |
| device_indexes | The device index of the network interface attachment on the instance. | device_index |
| network_card_indexes | The index of the network card. | network_card_index |
| instance_ids | The ID of the instance. | instance_id |
| instance_owner_ids | The Amazon Web Services account ID of the owner of the instance. | instance_owner_id |
| statuses | The attachment state. | status |

## Examples

### Ensure a attachment id is available.
    describe aws_ec2_network_interface_attachment(network_interface_id: 'NetworkInterfaceId') do
      its('attachment_ids') { should include 'AttachmentID' }
    end

### Ensure that the status is `available`.
    describe aws_ec2_network_interface_attachment(network_interface_id: 'NetworkInterfaceId') do
        its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interface_attachments do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interface_attachments do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpnConnectionsResult` action with `Effect` set to `Allow`.