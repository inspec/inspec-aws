---
title: About the aws_ec2_local_gateway_route Resource
platform: aws
---

# aws_ec2_local_gateway_route

Use the `aws_ec2_local_gateway_route` InSpec audit resource to test properties of a single specific AWS EC2 Local Gateway Route.

The AWS::EC2::LocalGatewayRoute resource creates a static route for the specified local gateway route table..

## Syntax

Ensure that Local Gateway Route table id exists.

    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'LocalGatewayRoutetableId') do
      it { should exist }
    end

## Parameters

`local_gateway_route_table_id` _(required)_

| Property | Description |
| --- | --- | --- |
| local_gateway_route_table_id | The ID of the local gateway route table. |

For additional information, see the [AWS documentation on AWS EC2 Local Gateway Route](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-localgatewayroute.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| destination_cidr_block | The CIDR block used for destination matches.| destination_cidr_block |
| local_gateway_virtual_interface_group_id | The ID of the virtual interface group. | local_gateway_virtual_interface_group_id |
| type | The route type. | type |
| state | The state of the route. | state |
| local_gateway_route_table_id | The ID of the local gateway route table. | local_gateway_route_table_id |
| local_gateway_route_table_arn | The Amazon Resource Name (ARN) of the local gateway route table. | local_gateway_route_table_arn |
| owner_id | The AWS account ID that owns the local gateway route. | owner_id |

## Examples

### Ensure a Local Gateway Route table Id is available.
    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'LocalGatewayRoutetableId') do
      its('local_gateway_route_table_id') { should eq 'LocalGatewayRoutetableId' }
    end

### Ensure a owner id is available.
    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'LocalGatewayRoutetableId') do
        its('owner_id') { should eq '1234567890' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'LocalGatewayRoutetableId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_local_gateway_route(local_gateway_route_table_id: 'LocalGatewayRoutetableId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2.Client.search_local_gateway_routes` action with `Effect` set to `Allow`.