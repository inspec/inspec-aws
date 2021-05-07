---
title: About the aws_ec2_transit_gateway_route_tables Resource
platform: aws
---

# aws\_ec2\_transit\_gateway\_routetable\_associations

Use the `aws_ec2_transit_gateway_routetable_associations` InSpec audit resource to test properties of some or all TTransit Gateway Route Table Associations.

## Syntax

Verify that a Transit Gateway Route Table ID exists.

    describe aws_ec2_transit_gateway_routetable_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
      it { should exist }
    end

An `aws_ec2_transit_gateway_routetable_associations` resource block uses an optional filter to select a group of Elastic IPs and then test that group.

## Parameters

This resource does not expect any parameters.

See the [AWS documentation on Transit Gateway Route Table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html) for additional information.

## Properties

| Property | Description|
| --- | --- |
| transit_gateway_route_table_ids | The ID of the transit gateway route table. |
| resource_type | The resource type. Valid values are vpc | vpn | direct-connect-gateway | peering | connect. |
| resource_id | The ID of the resource. |
| states | The state of the route table are available, deleting, deleted, pending. |

## Examples

##### Ensure a Transit Gateway Route Table exists.
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
      it { should exist }
    end

##### Match count of Transit Gateway Route Table.
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
        its('count') { should eq 5 }
    end

##### Check State whether it is available or not
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
       its('states') { should include "available" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
      it { should exist }
    end
      
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:describe_transit_gateway_route_tables` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
