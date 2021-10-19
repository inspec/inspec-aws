---
title: About the aws_rds_db_cluster_snapshots Resource
platform: aws
---

# aws_rds_db_cluster_snapshots

Use the `aws_rds_db_cluster_snapshots` InSpec audit resource to test properties of a single specific AWS RDS Cluster Snapshot.

## Syntax

Ensure that the cluster snapshot exists.

    describe aws_rds_db_cluster_snapshots do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS RDS Cluster Snapshot.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_RDS.html).

## Properties


|Property                     | Description| Fields |
| ---                         | --- | --- |
|availability_zones    | Provides the list of EC2 Availability Zones that instances in the DB cluster snapshot can be restored in. | availability_zone |
|db_cluster_snapshot_identifiers    | Specifies the identifier for the DB cluster snapshot. | db_cluster_snapshot_identifier |
|db_cluster_identifiers   | Specifies the DB cluster identifier of the DB cluster that this DB cluster snapshot was created from. | db_cluster_identifier |
|snapshot_create_times    | Provides the time when the snapshot was taken, in Universal Coordinated Time (UTC). | snapshot_create_time |
|engines  | Specifies the name of the database engine. | engine |
|allocated_storages    | Specifies the allocated storage size in gibibytes (GiB). | allocated_storage |
|statuses    | Specifies the status of this DB cluster snapshot. | status |
|ports    | Specifies the port that the DB cluster was listening on at the time of the snapshot.  | port |
|vpc_ids  | Provides the VPC ID associated with the DB cluster snapshot. | vpc_id |
|cluster_create_times   | Specifies the time when the DB cluster was created, in Universal Coordinated Time (UTC). | cluster_create_time |
|master_usernames    | Provides the master username for the DB cluster snapshot. | master_username |
|engine_versions    | Provides the version of the database engine for this DB cluster snapshot. | engine_version |
|license_models    | Provides the license model information for this DB cluster snapshot.  | license_model |
|snapshot_types  | Provides the type of the DB cluster snapshot. | snapshot_type |
|percent_progresses   | Specifies the percentage of the estimated data that has been transferred. | percent_progress |
|storage_encrypted    | Specifies whether the DB cluster snapshot is encrypted. | storage_encrypted |
|kms_key_ids    | If StorageEncrypted is true, the AWS KMS key identifier for the encrypted DB cluster snapshot.  | kms_key_id |
|db_cluster_snapshot_arns  | The Amazon Resource Name (ARN) for the DB cluster snapshot.| db_cluster_snapshot_arn |
|source_db_cluster_snapshot_arns   | If the DB cluster snapshot was copied from a source DB cluster snapshot, the Amazon Resource Name (ARN) for the source DB cluster snapshot, otherwise, a null value. | source_db_cluster_snapshot_arn |
|iam_database_authentication_enabled  | True if mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false. | iam_database_authentication_enabled |
|tag_lists   | The related tags. | tag_list |

## Examples

### Ensure a cluster snapshot id is available.
    describe aws_rds_db_cluster_snapshots do
      its('db_cluster_snapshot_ids') { should include 'DB_CLUSTER_SNAPSHOT_ID' }
    end

### Ensure that the state is `available`.
    describe aws_rds_db_cluster_snapshots do
        its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_cluster_snapshots do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_cluster_snapshots do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_cluster_snapshots do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DBClusterSnapshotMessage` action with `Effect` set to `Allow`.