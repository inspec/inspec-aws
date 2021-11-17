---
title: About the aws_dms_replication_subnet_groups Resource
platform: aws
---

# aws_dms_replication_subnet_groups

Use the `aws_dms_replication_subnet_groups` InSpec audit resource to test properties of multiple DMS replication instance subnet groups.

## Syntax

Ensure that a subnet group exists.

    describe aws_dms_replication_subnet_groups do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

For additional information, see the [AWS documentation on DMS Replication Subnet Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html).

## Properties

| Property | Description|
| --- | --- |
| replication_subnet_group_identifiers | The identifiers of the replication subnet groups. |
| replication_subnet_group_descriptions | The descriptions of the replication subnet groups. |
| vpc_ids | The IDs of the virtual private clouds. |
| subnet_group_statuses | The statuses of the replication subnet groups. |
| subnets | The subnets that are in the replication subnet groups. |

## Examples

### Ensure an identifier is available.

    describe aws_dms_replication_subnet_groups do
      its('replication_subnet_group_identifiers') { should include 'REPLICATION_SUBNET_GROUP_IDENTIFIER' }
    end

### Ensure that the VPC is available.

    describe aws_dms_replication_subnet_groups do
        its('vpc_ids') { should include 'VPC_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_dms_replication_subnet_groups do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_dms_replication_subnet_groups do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_dms_replication_subnet_groups do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `DatabaseMigrationService:Client:DescribeReplicationSubnetGroupsResponse` action with `Effect` set to `Allow`.
