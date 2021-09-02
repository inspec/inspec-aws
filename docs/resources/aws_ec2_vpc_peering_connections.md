---
title: About the aws_ec2_vpc_peering_connections Resource
platform: aws
---

# aws\_ec2\_vpc\_peering\_connections

Use the `aws_ec2_vpc_peering_connections` InSpec audit resource to test properties of multiple AWS EC2 VPC peering connections.

The `AWS::EC2::VPCPeeringConnection` resource requests a VPC peering connection between two VPCs: a requester VPC that you own and an accepter VPC with which to create the connection.

## Syntax

Ensure that a VPC peering Connection ID exists.

    describe aws_ec2_vpc_peering_connections do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 VPCPeeringConnection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcpeeringconnection.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| accepter_vpc_infos | Information about the accepter VPC. | accepter_vpc_info |
| expiration_times | The expiration date and time for the VPC peering connection. | expiration_time |
| requester_vpc_infos | Information about the requester VPC. | requester_vpc_info |
| statuses | The status of the VPC peering connection. | status |
| tags | The tags assigned to the resource. | tags |
| vpc_peering_connection_ids | The ID of the VPC peering connection. | vpc_peering_connection_id |

## Examples

### Ensure a VPC peering connection ID is available.

    describe aws_ec2_vpc_peering_connections do
      its('vpc_peering_connection_ids') { should include 'VPC_PEERING_CONNECTION_ID' }
    end

### Ensure that a connection is `available`.

    describe aws_ec2_vpc_peering_connections do
        its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that an entity exists.

    describe aws_ec2_vpc_peering_connections do
      it { should exist }
    end

Use `should_not` to test an entity does not exist.

    describe aws_ec2_vpc_peering_connections do
      it { should_not exist }
    end

### be_available

Use `should` to check if an entity is available.

    describe aws_ec2_vpc_peering_connections do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:describe_vpc_peering_connections` action with `Effect` set to `Allow`.
