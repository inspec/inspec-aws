---
title: About the aws_ec2_transit_gateway_route_tables Resource
platform: aws
---

# aws_ec2_transit_gateway_route_tables

Use the `aws_ec2_transit_gateway_route_tables` InSpec audit resource to test properties of some or all Transit Gateway route tables.

## Syntax

Verify that a Transit Gateway route table ID exists.

    describe aws_ec2_transit_gateway_route_tables do
      it { should exist }
    end

An `aws_ec2_transit_gateway_route_tables` resource block uses an optional filter to select a group of Elastic IPs and then test that group.

## Parameters

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on the `AWS::Batch::JobDefinition` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).


See the [AWS documentation on Transit Gateway route tables](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetable.html) for additional information.

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| transit_gateway_route_table_ids | The ID of the Transit Gateway route table. | transit_gateway_route_table_id |
| transit_gateway_ids | The ID of the Transit Gateway. | transit_gateway_id |
| states | The state of the route table. Relevant values are: `available`, `deleting`, `deleted`, and `pending`. | state |
| default_association_route_tables | Indicates whether this is the default association route table for the Transit Gateway. Default values are `true` and `false`. | default_association_route_table |
| default_propagation_route_tables | Indicates whether this is the default propagation route table for the Transit Gateway. Default values are `true` and `false`. | default_propagation_route_table |
| creation_times | The creation time of the Transit Gateway route table. | creation_time |
| tags | The tags of the Transit Gateway route table. | tags |

## Examples

### Ensure a Transit Gateway route table has route table ID

    describe aws_ec2_transit_gateway_route_tables do
      it { should exist }
    end

### Match count of Transit Gateway route table

    describe aws_ec2_transit_gateway_route_tables do
        its('count') { should eq 5 }
    end

### Check State whether it is available or not

    describe aws_ec2_transit_gateway_route_tables do
       its('states') { should include "available" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

    describe aws_ec2_transit_gateway_route_tables do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_ec2_transit_gateway_route_tables do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeTransitGatewayRouteTablesResult` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
