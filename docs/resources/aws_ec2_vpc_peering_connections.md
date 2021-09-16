---
title: About the aws_ec2_vpc_peering_connections Resource
platform: aws
---

# aws_ec2_vpc_peering_connections

Use the `aws_ec2_vpc_peering_connections` InSpec audit resource to test properties of a plural AWS EC2 Network Interface Attachment.

The AWS::EC2::VPCPeeringConnection resource requests a VPC peering connection between two VPCs: a requester VPC that you own and an accepter VPC with which to create the connection.

## Syntax

Ensure that VPC Peering Connection ID exists.

    describe aws_ec2_vpc_peering_connections do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 VPC Peering Connection.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| accepter_vpc_infos | Information about the accepter VPC. CIDR block information is only returned when describing an active VPC peering connection. | accepter_vpc_info |
| expiration_times | The time that an unaccepted VPC peering connection will expire. | expiration_time |
| requester_vpc_infos | Information about the requester VPC. CIDR block information is only returned when describing an active VPC peering connection. | requester_vpc_info |
| statuses | The status of the VPC peering connection. | status |
| tags | Any tags assigned to the resource. | tags |
| vpc_peering_connection_ids | The ID of the VPC peering connection. | vpc_peering_connection_id |

## Examples

### Ensure a VPC Peering Connection ID is available.
    describe aws_ec2_vpc_peering_connections do
      its('vpc_peering_connection_ids') { should include 'VPCPeeringConnectionID' }
    end

### Ensure that the status is `available`.
    describe aws_ec2_vpc_peering_connections do
        its('statuses') { should_not be_empty }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_vpc_peering_connections do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_vpc_peering_connections do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpcPeeringConnectionsResult` action with `Effect` set to `Allow`.