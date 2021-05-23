---
title: About the aws_dms_replication_subnet_groups Resource
platform: aws
---

# aws_dms_replication_subnet_groups

Use the `aws_dms_replication_subnet_groups` InSpec audit resource to test properties of a plural DMS Replication Instance Subnet Groups.

The AWS::DMS::ReplicationSubnetGroup resource creates an AWS DMS replication subnet group. Subnet groups must contain at least two subnets in two different Availability Zones in the same region.

## Syntax

Ensure that a work_group exists.
    describe aws_dms_replication_subnet_groups do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on DMS Replication Subnet Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html).

## Properties

| Property | Description|
| --- | --- |
| replication_subnet_group_identifiers | The identifiers of the replication subnet group. |
| replication_subnet_group_descriptions | The descriptions of the replication subnet group. |
| vpc_ids | The vpc ids of the replication subnet group. |
| subnet_group_statuses | The statuses of the replication subnet group. |
| subnets | The subnets of the replication subnet group. |

## Examples

### Ensure a identifier is available.
    describe aws_dms_replication_subnet_groups do
      its('replication_subnet_group_identifiers') { should include 'test' }
    end

### Ensure that the vpc is availble.
    describe aws_dms_replication_subnet_groups do
        its('vpc_ids') { should include 'ENABLED' }
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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `dmsmigrationservice:client:describe_replication_subnet_groups` action with `Effect` set to `Allow`.