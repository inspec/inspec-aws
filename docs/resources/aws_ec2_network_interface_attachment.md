---
title: About the aws_ec2_network_interface_attachment Resource
platform: aws
---

# aws_ec2_network_interface_attachment

Use the `aws_ec2_network_interface_attachment` InSpec audit resource to test properties of a single specific AWS EC2 network interface attachment.

The `AWS::EC2::NetworkInterfaceAttachment` resource attaches an elastic network interface (ENI) to an Amazon EC2 instance. You can use this resource type to attach additional network interfaces to an instance without interruption.

## Syntax

Ensure that network interface attachment exists.

    describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should exist }
    end

## Parameters

`network_interface_id` _(required)_

The ID of the network interface.

For additional information, see the [AWS documentation on AWS EC2 network interface attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface-attachment.html).

## Properties

| Property | Description |
| --- | --- |
| attach_time | The timestamp indicating when the attachment initiated. |
| attachment_id | The ID of the network interface attachment. |
| delete_on_termination | Indicates whether the network interface is deleted when the instance is terminated. |
| device_index | The device index of the network interface attachment on the instance. | d
| network_card_index | The index of the network card. |
| instance_id | The ID of the instance. |
| instance_owner_id | The Amazon Web Services account ID of the owner of the instance. |
| status | The attachment state. |

## Examples

### Ensure aN attachment ID is available.

    describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
      its('attachment_id') { should eq 'ATTACHMENT_ID' }
    end

### Ensure that the status is `available`.

    describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
        its('status') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_interface_attachment(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInterfacesResult` action with `Effect` set to `Allow`.
