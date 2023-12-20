+++
title = "aws_rds_db_cluster_snapshots Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_db_cluster_snapshots"
identifier = "inspec/resources/aws/aws_rds_db_cluster_snapshots Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_cluster_snapshots` InSpec audit resource to test the properties of a single specific AWS RDS Cluster snapshot.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS Cluster Snapshot.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_RDS.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the cluster snapshot exists.

```ruby
describe aws_rds_db_cluster_snapshots do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`availability_zones`
: Provides the list of EC2 Availability Zones instances in the DB cluster snapshot that can be restored.

: **Field**: `availability_zone`

`db_cluster_snapshot_identifiers`
: Specifies the identifier for the DB cluster snapshot.

: **Field**: `db_cluster_snapshot_identifier`

`db_cluster_identifiers`
: Specifies the identifier of the DB cluster from which the DB cluster snapshot is created.

: **Field**: `db_cluster_identifier`

`snapshot_create_times`
: Provides the time when the snapshot is taken, in Universal Coordinated Time (UTC).

: **Field**: `snapshot_create_time`

`engines`
: Specifies the name of the database engine.

: **Field**: `engine`

`allocated_storages`
: Specifies the allocated storage size in Gibibytes (GiB).

: **Field**: `allocated_storage`

`statuses`
: Specifies the status of this DB cluster snapshot.

: **Field**: `status`

`ports`
: Specifies the port where the DB cluster is listening at the time of the snapshot.

: **Field**: `port`

`vpc_ids`
: Provides the VPC ID associated with the DB cluster snapshot.

: **Field**: `vpc_id`

`cluster_create_times`
: Specifies the time when the DB cluster is created, in Universal Coordinated Time (UTC).

: **Field**: `cluster_create_time`

`master_usernames`
: Provides the master username for the DB cluster snapshot.

: **Field**: `master_username`

`engine_versions`
: Provides the database engine version for the DB cluster snapshot.

: **Field**: `engine_version`

`license_models`
: Provides the license model information for the DB cluster snapshot.

: **Field**: `license_model`

`snapshot_types`
: Provides the DB cluster snapshot type.

: **Field**: `snapshot_type`

`percent_progresses`
: Specifies the percentage of the estimated data that is transferred.

: **Field**: `percent_progress`

`storage_encrypted`
: Specifies whether the DB cluster snapshot is encrypted.

: **Field**: `storage_encrypted`

`kms_key_ids`
: If `StorageEncrypted` is true, the AWS Key Management Service (AWS KMS) identifier for the encrypted DB cluster snapshot is set to protect the data.

: **Field**: `kms_key_id`

`db_cluster_snapshot_arns`
: The Amazon Resource Name (ARN) for the DB cluster snapshot.

: **Field**: `db_cluster_snapshot_arn`

`source_db_cluster_snapshot_arns`
: If the DB cluster snapshot is copied from a source DB cluster snapshot, the Amazon Resource Name (ARN) for the source DB cluster snapshot is associated, otherwise a null value is stored for the source DB cluster snapsot ARN.

: **Field**: `source_db_cluster_snapshot_arn`

`iam_database_authentication_enabled`
: `True`, if the mapping of the AWS Identity and Access Management (IAM) corresponds to database accounts are enabled, and otherwise `False`.

: **Field**: `iam_database_authentication_enabled`

`tag_lists`
: The related tags.

: **Field**: `tag_list`

## Examples

**Ensure a cluster snapshot id is available.**

```ruby
describe aws_rds_db_cluster_snapshots do
  its('db_cluster_snapshot_ids') { should include 'CLUSTER_ID' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_rds_db_cluster_snapshots do
    its('statuses') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_cluster_snapshots do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_cluster_snapshots do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_cluster_snapshots do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBClusterSnapshotMessage" %}}
