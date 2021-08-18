---
title: About the aws_ec2_vpc_peering_connection Resource
platform: aws
---

# aws\_ec2\_vpc\_peering\_connection

Use the `aws_ec2_vpc_peering_connection` InSpec audit resource to test properties of a single specific AWS EC2 VPC Peering Connection.

The AWS::EC2::VPCPeeringConnection resource requests a VPC peering connection between two VPCs: a requester VPC that you own and an accepter VPC with which to create the connection.

## Syntax

Ensure that a VPC peering Connection ID exists.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VpcPeeringConnectionId') do
      it { should exist }
    end

## Parameters

`vpc_peering_connection_id` _(required)_

## Properties of the Required Parameter

| Property | Description|
| --- | --- |
| vpc_peering_connection_id | The ID of the VPC peering connection. |

For additional information, see the [AWS documentation on AWS EC2 VPCPeeringConnection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html).

## Properties

| Fields | Description | Property |
| --- | --- | --- |
| accepter_vpc_info (cidr_block) | The IPv4 CIDR block of the accepter VPC. | accepter_vpc_info.cidr_block |
| accepter_vpc_info (ipv_6_cidr_block_set) | The IPv4 CIDR block set of the accepter's VPC. | accepter_vpc_info.ipv_6_cidr_block_set |
| accepter_vpc_info (ipv_6_cidr_block_set (ipv_6_cidr_block)) | The IPv4 CIDR block of the IPv4 CIDR block set of the accepter's VPC. | accepter_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block |
| accepter_vpc_info (cidr_block_set) | The ID of the attachment. | accepter_vpc_info.cidr_block_set |
| accepter_vpc_info (cidr_block_set (cidr_block)) | The IPv4 CIDR block. | accepter_vpc_info.cidr_block_set.first.cidr_block |
| accepter_vpc_info (owner_id) | The ID of the account that owns the accepter VPC. | accepter_vpc_info.owner_id |
| accepter_vpc_info (peering_options (allow_dns_resolution_from_remote_vpc)) | Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC. | accepter_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc |
| accepter_vpc_info (peering_options (allow_egress_from_local_classic_link_to_remote_vpc)) | Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC peering connection. | accepter_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc |
| accepter_vpc_info (peering_options (allow_egress_from_local_vpc_to_remote_classic_link)) | Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC peering connection. | accepter_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link |
| accepter_vpc_info (vpc_id) | The ID of the accepter VPC. | accepter_vpc_info.cidr_block_set |
| accepter_vpc_info (region) | The region of the requester VPC. | accepter_vpc_info.cidr_block_set |
| expiration_time | The expiration date and time for the VPC peering connection. | expiration_time |
| requester_vpc_info (cidr_block) | The IPv4 CIDR block of the requester's VPC. | requester_vpc_info.cidr_block |
| requester_vpc_info (ipv_6_cidr_block_set) | The IPv4 CIDR block of the IPv4 CIDR block set of the accepter's VPC. | requester_vpc_info.ipv_6_cidr_block_set |
| requester_vpc_info (ipv_6_cidr_block_set (ipv_6_cidr_block)) | The IPv4 CIDR block. | requester_vpc_info.ipv_6_cidr_block_set.first.ipv_6_cidr_block |
| requester_vpc_info (cidr_block_set) | The IPv4 CIDR block set of the requester's VPC. | requester_vpc_info.cidr_block_set |
| requester_vpc_info (cidr_block_set (cidr_block)) | The ID of the attachment. | requester_vpc_info.cidr_block_set.first.cidr_block |
| requester_vpc_info (owner_id) | The ID of the account that owns the requester VPC. | requester_vpc_info.owner_id |
| requester_vpc_info (peering_options (allow_dns_resolution_from_remote_vpc)) | Indicates whether a local VPC can resolve public DNS hostnames to private IP addresses when queried from instances in a peer VPC. | requester_vpc_info.peering_options.allow_dns_resolution_from_remote_vpc |
| requester_vpc_info (peering_options (allow_egress_from_local_classic_link_to_remote_vpc)) | Indicates whether a local ClassicLink connection can communicate with the peer VPC over the VPC peering connection. | requester_vpc_info.peering_options.allow_egress_from_local_classic_link_to_remote_vpc |
| requester_vpc_info (peering_options (allow_egress_from_local_vpc_to_remote_classic_link)) | Indicates whether a local VPC can communicate with a ClassicLink connection in the peer VPC over the VPC peering connection. | requester_vpc_info.peering_options.allow_egress_from_local_vpc_to_remote_classic_link |
| requester_vpc_info (vpc_id) | The ID of the requester VPC. | requester_vpc_info.vpc_id |
| requester_vpc_info (region) | The region of the requester VPC. | requester_vpc_info.region |
| status (code) | The status of the VPC peering connection. | status.code |
| status (message) | A message that provides more information about the status, if applicable. | status.message |
| tags | The tags assigned to the resource. | tags |
| vpc_peering_connection_id | The ID of the VPC peering connection. | vpc_peering_connection_id |

## Examples

### Ensure a accepter vpc cidr block is available.
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VpcPeeringConnectionId') do
      its('accepter_vpc_info.cidr_block') { should eq 'cidr_block' }
    end

### Ensure that the accepter owner_id is available.
    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VpcPeeringConnectionId') do
        its('accepter_vpc_info.owner_id') { should eq '1234567890' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VpcPeeringConnectionId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the function is available.

    describe aws_ec2_vpc_peering_connection(vpc_peering_connection_id: 'VpcPeeringConnectionId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:describe_vpc_peering_connections` action with `Effect` set to `Allow`.