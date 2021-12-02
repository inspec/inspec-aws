---
title: About the aws_ec2_vpc_peering_connection Resource
platform: aws
---

# aws_ec2_vpc_peering_connection

Use the `aws_ec2_vpc_peering_connection` InSpec audit resource to test properties of a single specific AWS EC2 VPC Peering Connection.

The AWS::EC2::VPCPeeringConnection resource requests a VPC peering connection between two VPCs: a requester VPC that you own and an accepter VPC with which to create the connection.

## Syntax

Ensure that VPC Peering Connection ID exists.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
      it { should exist }
    end

## Parameters

`vpc_peering_connection_id` _(required)_

The ID of the VPC peering connection.

For additional information, see the [AWS documentation on AWS EC2 VPC Peering Connection.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| accepter_vpc_info.cidr_block | The IPv4 CIDR block for the VPC. | accepter_vpc_info.cidr_block |
| accepter_vpc_info.ipv_6_cidr_block_set | The IPv6 CIDR block for the VPC. | accepter_vpc_info.ipv_6_cidr_block_set |
| accepter_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block | The IPv6 CIDR block. | accepter_vpc_info.ipv_6_cidr_block_set[0].ipv_6_cidr_block |
| accepter_vpc_info.cidr_block_set | The IPv4 CIDR block for the VPC. | accepter_vpc_info.cidr_block_set |
| accepter_vpc_info.cidr_block_set.first.cidr_block| The IPv4 CIDR block. | accepter_vpc_info.cidr_block_set[0].cidr_block |
| accepter_vpc_info.owner_id| The ID of the Amazon Web Services account that owns the VPC. | accepter_vpc_info.owner_id |
| accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc | Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC. | accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc |
| accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc | Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC peering connection. | accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc |
| accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link | Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC peering connection. | accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link |
| accepter_vpc_info.vpc_id | The ID of the VPC. | accepter_vpc_info.vpc_id |
| accepter_vpc_info.region | The Region in which the VPC is located. | accepter_vpc_info.region |
| expiration_time | The time that an unaccepted VPC peering connection will expire. | expiration_time |
| requester_vpc_info.cidr_block | The IPv4 CIDR block for the VPC. | requester_vpc_info.cidr_block |
| requester_vpc_info.ipv_6_cidr_block_set | The IPv6 CIDR block for the VPC. | requester_vpc_info.ipv_6_cidr_block_set |
| requester_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block| The IPv6 CIDR block. | requester_vpc_info.ipv_6_cidr_block_set[0].ipv_6_cidr_block |
| requester_vpc_info.cidr_block_set | The IPv4 CIDR block for the VPC. | requester_vpc_info.cidr_block_set |
| requester_vpc_info.cidr_block_set.first.cidr_block | The IPv4 CIDR block. | requester_vpc_info.cidr_block_set[0].cidr_block |
| requester_vpc_info.owner_id | The ID of the Amazon Web Services account that owns the VPC. | requester_vpc_info.owner_id |
| requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc | Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC. | requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc |
| requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc | Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC peering connection. | requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc |
| requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link | Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC peering connection. | requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link |
| requester_vpc_info.vpc_id| The ID of the VPC. | requester_vpc_info.vpc_id |
| requester_vpc_info.region| The Region in which the VPC is located. | requester_vpc_info.region |
| status.code| The status of the VPC peering connection. | status.code |
| status.message| A message that provides more information about the status, if applicable. | status.message |
| tags | Any tags assigned to the resource. | tags |
| vpc_peering_connection_id| The ID of the VPC peering connection. | vpc_peering_connection_id |

## Examples

### Ensure a VPC Peering Connection ID is available.
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
      its('vpc_peering_connection_id') { should eq 'VPCPeeringConnectionID' }
    end

### Ensure that the status is `available`.
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
        its('status.code') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VPCPeeringConnectionID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpcPeeringConnectionsResult` action with `Effect` set to `Allow`.