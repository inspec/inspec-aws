---
title: About the aws_dms_replication_subnet_group Resource
platform: aws
---

# aws_dms_replication_subnet_group

Use the `aws_dms_replication_subnet_group` InSpec audit resource to test properties of a single DMS replication instance subnet group.

## Syntax

Ensure that a subnet group identifier exists.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
      it { should exist }
    end

## Parameters

`replication_subnet_group_identifier` _(required)_

The identifier for the replication subnet group.

For additional information, see the [AWS documentation on DMS Replication Subnet Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html).

## Properties

| Property | Description|
| --- | --- |
| replication_subnet_group_identifier | The identifier of the replication subnet group. |
| replication_subnet_group_description | The description of the replication subnet group. |
| vpc_id | The ID of the virtual private cloud. |
| subnet_group_status | The status of the replication subnet group. |
| subnets | The subnets that are in the replication subnet group. |

## Examples

### Ensure a identifier is available.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
      its('replication_subnet_group_identifier') { should eq 'SUBNET_GROUP_IDENTIFIER' }
    end

### Ensure that the vpc is available.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
        its('vpc_id') { should eq 'VPC_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the identifier is available.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `DatabaseMigrationService:Client:DescribeReplicationSubnetGroupsResponse` action with `Effect` set to `Allow`.
