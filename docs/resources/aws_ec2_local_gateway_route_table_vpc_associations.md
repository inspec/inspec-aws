---
title: About the aws_ec2_local_gateway_route_table_vpc_associations Resource
platform: aws
---

# aws_ec2_local_gateway_route_table_vpc_associations

Use the `aws_ec2_local_gateway_route_table_vpc_associations` InSpec audit resource to test properties of the plural resource of AWS EC2 Local Gateway Route Table VPC Association.

The AWS::EC2::LocalGatewayRouteTableVPCAssociation resource associates the specified VPC with the specified local gateway route table..

## Syntax

Ensure that Local Gateway Route Table Vpc Association Id exists.

    describe aws_ec2_local_gateway_route_table_vpc_associations do
      it { should exist }
    end


## Parameters

For additional information, see the [AWS documentation on AWS EC2 Local Gateway Route Table VPC Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-localgatewayroutetablevpcassociation.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| local_gateway_route_table_vpc_association_ids | The ID of the association. | local_gateway_route_table_vpc_association_id |
| local_gateway_route_table_ids | The ID of the local gateway route table. | local_gateway_route_table_id |
| local_gateway_route_table_arns | The Amazon Resource Name (ARN) of the local gateway route table for the association. | local_gateway_route_table_arn |
| local_gateway_ids | The ID of the local gateway. | local_gateway_id |
| vpc_ids | The ID of the VPC. | vpc_id |
| owner_ids | The AWS account ID that owns the local gateway route table for the association. | owner_id |
| states | The state of the association. | state |
| tags | The tags assigned to the association. | tags |

## Examples

### Ensure a local gateway route table vpc association id is available.
    describe aws_ec2_local_gateway_route_table_vpc_associations do
      its('local_gateway_route_table_vpc_association_id') { should eq 'LocalGatewayRouteTableVpcAssociationId' }
    end

### Ensure a local gateway id is available.
    describe aws_ec2_local_gateway_route_table_vpc_associations do
        its('local_gateway_id') { should eq 'LocalGatewayId' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist


Use `should` to test that the entity exists.

    describe aws_ec2_local_gateway_route_table_vpc_associations do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_local_gateway_route_table_vpc_associations do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:DescribeLocalGatewayRouteTableVpcAssociationsResult` action with `Effect` set to `Allow`.