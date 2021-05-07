---
title: About the aws_ec2_transit_gateway_route_table_association Resource
platform: aws
---

# aws\_ec2\_transit\_gateway\_route\_t_able\_association

Use the `aws_ec2_transit_gateway_routetable_association` InSpec audit resource to test properties of a single specific Transit Gateway Route Table Association.

A Transit Gateway Route Table Association associates the specified attachment with the specified transit gateway route table. You can associate only one route table with an attachment.

## Syntax

Ensure that a Transit Gateway Route Table ID exists.

    describe aws_ec2_transit_gateway_routetable_association(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id` _(required)_

For additional information, see the [AWS documentation on Transit Gateway Route Table Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html).

## Properties

| Property | Description|
| --- | --- |
| transit_gateway_route_table_id | The ID of the transit gateway route table. |
| resource_type | The resource type. Valid values are vpc | vpn | direct-connect-gateway | peering | connect. |
| resource_id | The ID of the resource. |
| state | The state of the route table are available, deleting, deleted, pending. |

## Examples

### Ensure a Transit Gateway Route Table ID is available.
    describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
      its('transit_gateway_attachment_id') { should eq 'tgw-attach-04e7d012fb9c478a6' }
    end

### Ensure that the state is available or deleted.
    describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_transit_gateway_routetable_association(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_ec2_transit_gateway_routetable_association(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the Transit Gateway Route Table ID is available.

    describe aws_ec2_transit_gateway_routetable_association(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:get_transit_gateway_route_table_associations` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.