---
title: About the aws_ec2_network_interfaces Resource
platform: aws
---

# aws_ec2_network_interfaces

Use the `aws_ec2_network_interfaces` InSpec audit resource to test properties of multiple network interfaces in an Amazon EC2 instance for AWS CloudFormation.

The `AWS::EC2::NetworkInterface` resource describes a network interface in an Elastic Compute Cloud (EC2) instance for AWS CloudFormation.

## Syntax

Ensure that network interface ID exists.

    describe aws_ec2_network_interfaces do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 network interface](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-network-interface.html).

## Properties

| Property | Description| Field |
| --- | --- | --- |
| attachments | The attachment. | attachment |
| availability_zones | The Availability Zone. | availability_zone |
| descriptions | A description. | description |
| groups | The security group. | groups |
| interface_types | The type of network interface. | interface_type |
| ipv_6_addresses | The IPv6 address. | ipv_6_addresses |
| mac_addresses | The MAC address. | mac_address |
| network_interface_ids | The ID of the network interface. | network_interface_id |
| outpost_arns | The Amazon Resource Name (ARN) of the Outpost. | outpost_arn |
| owner_ids | The Amazon Web Services account ID of the owner of the network interface. | owner_id |
| private_dns_names | The private DNS name. | private_dns_name |
| private_ip_addresses | The IPv4 address of the network interface within the subnet. | private_ip_address |
| ipv_4_prefixes | The IPv4 Prefix Delegation prefixes that are assigned to the network interface. | ipv_4_prefixes |
| ipv_6_prefixes | The IPv6 Prefix Delegation prefixes that are assigned to the network interface. The IPv6 Prefix Delegation prefix. | ipv_6_prefixes |
| requester_ids | The alias or Amazon Web Services account ID of the principal or service that created the network interface. | requester_id |
| requester_managed | Indicates whether the network interface is being managed by Amazon Web Services. | requester_managed |
| source_dest_checks | Indicates whether source/destination checking is enabled. | source_dest_check |
| statuses | The status of the network interface. | status |
| subnet_ids | The ID of the subnet. | subnet_id |
| tag_sets | Any tags assigned to the network interface. | tag_set |
| vpc_ids | The ID of the VPC. | vpc_id |

## Examples

### Ensure a network interface ID is available.

    describe aws_ec2_network_interfaces do
      its('network_interface_ids') { should include 'NetworkInterfaceId' }
    end

### Ensure that an availability zone is available.

    describe aws_ec2_network_interfaces do
        its('availability_zones') { should include "us-east-2a" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_network_interfaces do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_network_interfaces do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeNetworkInterfacesResult` action with `Effect` set to `Allow`.
