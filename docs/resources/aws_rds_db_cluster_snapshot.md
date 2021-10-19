---
title: About the aws_rds_db_cluster_snapshot Resource
platform: aws
---

# aws_rds_db_cluster_snapshot

Use the `aws_rds_db_cluster_snapshot` InSpec audit resource to test properties of the singular resource of AWS RDS Cluster Snapshot.

## Syntax

Ensure that cluster snapshot exists.

    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "DB_CLUSTER_SNAPSHOT_ID") do
      it { should exist }
    end

## Parameters

`db_cluster_snapshot_id` _(required)_

The ID of the cluster snapshot.

For additional information, see the [AWS documentation on AWS RDS Cluster Snapshot.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_RDS.html).

## Properties


|Property                     | Description|
| ---                         | --- |
|availability_zones    | Provides the list of EC2 Availability Zones that instances in the DB cluster snapshot can be restored in. |
|db_cluster_snapshot_identifier    | Specifies the identifier for the DB cluster snapshot. |
|db_cluster_identifier    | Specifies the DB cluster identifier of the DB cluster that this DB cluster snapshot was created from. |
|snapshot_create_time    | Provides the time when the snapshot was taken, in Universal Coordinated Time (UTC). |
|engine   | Specifies the name of the database engine. |
|allocated_storage    | Specifies the allocated storage size in gibibytes (GiB). |
|status    | Specifies the status of this DB cluster snapshot. |
|port    | Specifies the port that the DB cluster was listening on at the time of the snapshot.  |
|vpc_id  | Provides the VPC ID associated with the DB cluster snapshot. |
|cluster_create_time   | Specifies the time when the DB cluster was created, in Universal Coordinated Time (UTC). |
|master_username    | Provides the master username for the DB cluster snapshot. |
|engine_version    | Provides the version of the database engine for this DB cluster snapshot. |
|license_model    | Provides the license model information for this DB cluster snapshot.  |
|snapshot_type  | Provides the type of the DB cluster snapshot. |
|percent_progress   | Specifies the percentage of the estimated data that has been transferred. |
|storage_encrypted    | Specifies whether the DB cluster snapshot is encrypted. |
|kms_key_id  | If StorageEncrypted is true, the AWS KMS key identifier for the encrypted DB cluster snapshot.  |
|db_cluster_snapshot_arn  | The Amazon Resource Name (ARN) for the DB cluster snapshot.|
|source_db_cluster_snapshot_arn   | If the DB cluster snapshot was copied from a source DB cluster snapshot, the Amazon Resource Name (ARN) for the source DB cluster snapshot, otherwise, a null value. |
|iam_database_authentication_enabled  | True if mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false. |
|tag_list   | The related tags. |

## Examples

### Ensure a cluster snapshot id is available.
    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "DB_CLUSTER_SNAPSHOT_ID") do
      its('db_cluster_snapshot_id') { should eq 'DB_CLUSTER_SNAPSHOT_ID' }
    end

### Ensure that the status is `available`.
    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "DB_CLUSTER_SNAPSHOT_ID") do
        its('status') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "DB_CLUSTER_SNAPSHOT_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "DB_CLUSTER_SNAPSHOT_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "DB_CLUSTER_SNAPSHOT_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DBClusterSnapshotMessage` action with `Effect` set to `Allow`.