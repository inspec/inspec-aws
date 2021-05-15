---
title: About the aws_ec2_transit_gateway_route_table_associations Resource
platform: aws
---

# aws\_ec2\_transit\_gateway\_routetable\_associations

Use the `aws_ec2_transit_gateway_route_table_associations` InSpec audit resource to test properties of some or all TTransit Gateway Route Table Associations.

A Transit Gateway Route Table Association associates the specified attachment with the specified transit gateway route table. You can associate only one route table with an attachment.

## Syntax

Verify that a Transit Gateway Route Table ID exists.

    describe aws_ec2_transit_gateway_routetable_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
      it { should exist }
    end

## Parameters

`transit_gateway_route_table_id` _(required)_

See the [AWS documentation on Transit Gateway Route Table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html) for additional information.

## Properties

| Property | Description|
| --- | --- |
| name | The workgroup name. |
| state | The state of the workgroup: ENABLED or DISABLED. |
| description | The workgroup description. |
| creation_time | The workgroup creation time. |
| tags | An array of key-value pairs to apply to this resource. |
| configuration (result_configuration) | The workgroup result configuration of the configuration. |
| configuration (enforce_work_group_configuration) | The enforce workgroup configuration of the configuration. |
| configuration (publish_cloud_watch_metrics_enabled) | The publish cloudwatch metrics enabled of the configuration. |
| configuration (bytes_scanned_cutoff_per_query) | The bytes scanned cutoff per query of the configuration. |
| configuration (requester_pays_enabled) | The requester pays enabled of the configuration. |
| configuration (engine_version (selected_engine_version)) | The selected engine version of engine version of the configuration. |
| configuration (engine_version (effective_engine_version)) | The effective engine version of engine version of the configuration. |

## Examples

##### Ensure a Transit Gateway Route Table exists.
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
      it { should exist }
    end

##### Match count of Transit Gateway Route Table.
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
        its('count') { should eq 5 }
    end

##### Check State whether it is available or not.
    describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: aws_transit_gateway_route_table_id) do
       its('states') { should include "available" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.

    describe aws_athena_work_groups do
      it { should_not exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_athena_work_groups do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `athena:client:list_work_groups` action with Effect set to Allow.