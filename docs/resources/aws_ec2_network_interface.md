---
title: About the aws_ec2_network_interface Resource
platform: aws
---

# aws_ec2_network_interface

Use the `aws_ec2_network_interface` InSpec audit resource to test properties of a single specific AWS EC2 Network Interface.

The AWS::EC2::NetworkInterface resource describes a network interface in an Elastic Compute Cloud (EC2) instance for AWS CloudFormation.

## Syntax

Ensure that Network Interface Id exists.

    describe aws_ec2_network_interface(network_interface_id: 'NetworkInterfaceId') do
      it { should exist }
    end

## Parameters

`network_interface_id` _(required)_

| Property | Description |
| --- | --- | --- |
| network_interface_id | The ID of the network interface. |

For additional information, see the [AWS documentation on AWS EC2 Network Interface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| association.allocation_id | The allocation ID. | association (allocation_id) |
| association.association_id | The association ID. | association (association_id) |
| association.ip_owner_id | The ID of the Elastic IP address owner. | association (ip_owner_id) |
| association.public_dns_name | The public DNS name. | association (public_dns_name) |
| association.public_ip | The address of the Elastic IP address bound to the network interface. | association (public_ip) |
| association.customer_owned_ip | The customer-owned IP address associated with the network interface. | association (customer_owned_ip) |
| association.carrier_ip | The carrier IP address associated with the network interface. | association (carrier_ip) |
| attachment.attach_time | The timestamp indicating when the attachment initiated. | attachment (attach_time) |
| attachment.attachment_id | The ID of the network interface attachment. | attachment (attachment_id) |
| attachment.delete_on_termination | Indicates whether the network interface is deleted when the instance is terminated. | attachment (delete_on_termination) |
| attachment.device_index | The device index of the network interface attachment on the instance. | attachment (device_index) |
| attachment.network_card_index | The | attachment (network_card_index) |
| attachment.instance_id | The ID of the instance. | attachment (instance_id) |
| attachment.instance_owner_id | The Amazon Web Services account ID of the owner of the instance. | attachment (instance_owner_id) |
| attachment.status | The attachment state. | attachment (status) |
| availability_zone | The Availability Zone. | availability_zone |
| description | A description. | description |
| groups | The security group. | groups |
| interface_type | The type of network interface. | interface_type |
| ipv_6_addresses | The IPv6 address. | ipv_6_addresses |
| mac_address | The MAC address. | mac_address |
| network_interface_id | The ID of the network interface. | network_interface_id |
| outpost_arn | The Amazon Resource Name (ARN) of the Outpost. | outpost_arn |
| owner_id | The Amazon Web Services account ID of the owner of the network interface. | owner_id |
| private_dns_name | The private DNS name. | private_dns_name |
| private_ip_address | The IPv4 address of the network interface within the subnet. | private_ip_address |
| ipv_4_prefixes | The IPv4 Prefix Delegation prefixes that are assigned to the network interface. | ipv_4_prefixes |
| ipv_6_prefixes | The IPv6 Prefix Delegation prefixes that are assigned to the network interface. The IPv6 Prefix Delegation prefix. | ipv_6_prefixes |
| requester_id | The alias or Amazon Web Services account ID of the principal or service that created the network interface. | requester_id |
| requester_managed | Indicates whether the network interface is being managed by Amazon Web Services. | requester_managed |
| source_dest_check | Indicates whether source/destination checking is enabled. | source_dest_check |
| status | The status of the network interface. | status |
| subnet_id | The ID of the subnet. | subnet_id |
| tag_set | Any tags assigned to the network interface. | tag_set |
| vpc_id | The ID of the VPC. | vpc_id |

## Examples

### Ensure a Network Interface Id is available.
    describe aws_ec2_network_interface(network_interface_id: 'NetworkInterfaceId') do
      its('network_interface_id') { should eq 'NetworkInterfaceId' }
    end

### Ensure that the interface type is 'vpc'.
    describe aws_ec2_network_interface(network_interface_id: 'NetworkInterfaceId') do
        its('interface_type') { should eq 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interface(network_interface_id: 'NetworkInterfaceId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interface(network_interface_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_interface(network_interface_id: 'NetworkInterfaceId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInterfacesResult` action with `Effect` set to `Allow`.