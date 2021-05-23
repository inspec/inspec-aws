---
title: About the aws_dms_replication_instance Resource
platform: aws
---

# aws_dms_replication_instance

Use the `aws_dms_replication_instance` InSpec audit resource to test properties of a single specific DMS Replication Instance.

The AWS::DMS::ReplicationInstance resource creates an AWS DMS replication instance.

## Syntax

Ensure that a deplication instance exists.

    describe aws_dms_replication_instance do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on DMS Replication Instance](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description|
| --- | --- |
| engine_version | The engine version of the replication instance. |
| replication_instance_class | The class of the replication instance. |
| storage_type | The storage type of the replication instance. |
| min_allocated_storage | The min allocated storage of the replication instance. |
| max_allocated_storage | The max allocated storage of the replication instance. |
| default_allocated_storage | The default allocated storage of the replication instance. |
| included_allocated_storage | The included allocated storage of the replication instance. |
| availability_zones | The availability zones of the replication instance. |
| release_status | The release status of the replication instance. |

## Examples

### Ensure a engine version is available.
    describe aws_dms_replication_instance do
      its('engine_version') { should eq '3.4.4' }
    end

### Ensure that the replication instance class is `dms.c4.2xlarge`
    describe aws_dms_replication_instance do
        its('replication_instance_class') { should eq 'dms.c4.2xlarge' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_dms_replication_instance do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_dms_replication_instance do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_dms_replication_instance do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `dmsmigrationservice:client:get_work_group` action with `Effect` set to `Allow`.