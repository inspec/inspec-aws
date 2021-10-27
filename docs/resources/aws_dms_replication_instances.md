---
title: About the aws_dms_replication_instances Resource
platform: aws
---

# aws_dms_replication_instances

Use the `aws_dms_replication_instances` InSpec audit resource to test properties of multiple AWS DMS replication instances.

The AWS::DMS::ReplicationInstance resource creates an AWS DMS replication instance.

## Syntax

### Ensure that a replication instance exists.

    describe aws_dms_replication_instances do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on DMS Replication Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationinstance.html).

## Properties

| Property | Description|
| --- | --- |
| engine_versions | The engine versions of the replication instance. |
| replication_instance_classes | The compute and memory capacity of the replication instance as defined for the specified replication instance class. |
| storage_types | The storage types of the replication instance. |
| min_allocated_storages | The min allocated storages of the replication instance. |
| max_allocated_storages | The max allocated storages of the replication instance. |
| default_allocated_storages | The default allocated storages of the replication instance in gigabytes. |
| included_allocated_storages | The included allocated storages of the replication instance in gigabytes. |
| availability_zones | The availability zones of the replication instance. |
| release_statuses | The release statuses of the replication instance. |

## Examples

### Ensure an engine version is available.

    describe aws_dms_replication_instances do
      its('engine_versions') { should include '3.4.4' }
    end

### Ensure that the classes are available

    describe aws_dms_replication_instances do
        its('replication_instance_classes') { should include 'dms.c4.2xlarge' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

#### Use `should` to test that the entity exists.

    describe aws_dms_replication_instances do
      it { should exist }
    end

#### Use `should_not` to test the entity does not exist.

    describe aws_dms_replication_instances do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work group name is available.

    describe aws_dms_replication_instances do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `DatabaseMigrationService:Client:DescribeOrderableReplicationInstancesResponse` action with `Effect` set to `Allow`.
