---
title: About the aws_ec2_network_interface Resource
platform: aws
---

# aws_ec2_network_interface

Use the `aws_ec2_network_interface` InSpec audit resource to test properties of a single network interface in an Amazon EC2 instance for AWS CloudFormation.

The `AWS::EC2::NetworkInterface` resource describes a network interface in an Elastic Compute Cloud (EC2) instance for AWS CloudFormation.

## Syntax

Ensure that network interface ID exists.

    describe aws_ec2_network_interface(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should exist }
    end

## Parameters

`network_interface_id` _(required)_

The ID of the network interface.

For additional information, see the [AWS documentation on AWS EC2 network interface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface.html).

## Properties

| Property | Description |
| :---: | :--- |
| association (allocation_id) | The allocation ID. |
| association (association_id) | The association ID. |
| association (ip_owner_id) | The ID of the Elastic IP address owner. |
| association (public_dns_name) | The public DNS name. |
| association (public_ip) | The address of the Elastic IP address bound to the network interface. |
| association (customer_owned_ip) | The customer-owned IP address associated with the network interface. |
| association (carrier_ip) | The carrier IP address associated with the network interface. |
| attachment (attach_time) | The timestamp indicating when the attachment initiated. |
| attachment (attachment_id) | The ID of the network interface attachment. |
| attachment (delete_on_termination) | Indicates whether the network interface is deleted when the instance is terminated. |
| attachment (device_index) | The device index of the network interface attachment on the instance. |
| attachment (network_card_index) | The index of the network card. |
| attachment (instance_id) | The ID of the instance. |
| attachment (instance_owner_id) | The Amazon Web Services account ID of the owner of the instance. |
| attachment (status) | The attachment state. Valid Values: `attaching`, `attached`, `detaching`, `detached` |
| availability_zone | The availability zone. |
| description | A description. |
| groups | The security group. |
| interface_type | The type of network interface. |
| ipv_6_addresses | The IPv6 address. |
| mac_address | The MAC address. |
| network_interface_id | The ID of the network interface. |
| outpost_arn | The Amazon Resource Name (ARN) of the Outpost. |
| owner_id | The Amazon Web Services account ID of the owner of the network interface. |
| private_dns_name | The private DNS name. |
| private_ip_address | The IPv4 address of the network interface within the subnet. |
| ipv_4_prefixes | The IPv4 Prefix Delegation prefixes that are assigned to the network interface. |
| ipv_6_prefixes | The IPv6 Prefix Delegation prefixes that are assigned to the network interface. The IPv6 Prefix Delegation prefix. |
| requester_id | The alias or Amazon Web Services account ID of the principal or service that created the network interface. |
| requester_managed | Indicates whether the network interface is being managed by Amazon Web Services. |
| source_dest_check | Indicates whether source/destination checking is enabled. |
| status | The status of the network interface. |
| subnet_id | The ID of the subnet. |
| tag_set | Any tags assigned to the network interface. |
| vpc_id | The ID of the VPC. |

## Examples

### Ensure a network interface ID is available.

    describe aws_ec2_network_interface(network_interface_id: 'NETWORK_INTERFACE_ID') do
      its('network_interface_id') { should eq 'NETWORK_INTERFACE_ID' }
    end

### Ensure that the interface type is 'vpc'.

    describe aws_ec2_network_interface(network_interface_id: 'NETWORK_INTERFACE_ID') do
        its('interface_type') { should eq 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interface(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interface(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_network_interface(network_interface_id: 'NETWORK_INTERFACE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInterfacesResult` action with `Effect` set to `Allow`.
