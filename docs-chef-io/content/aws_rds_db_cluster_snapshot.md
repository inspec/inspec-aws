+++
title = "aws_rds_db_cluster_snapshot resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_db_cluster_snapshot"
identifier = "inspec/resources/aws/aws_rds_db_cluster_snapshot resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_cluster_snapshot` InSpec audit resource to test the properties of the singular resource of AWS RDS Cluster snapshot.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS Cluster Snapshot.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_RDS.html).

## Syntax

Ensure that cluster snapshot exists.

```ruby
describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "CLUSTER_ID") do
  it { should exist }
end
```

## Parameters

`db_cluster_snapshot_id` _(required)_

: The cluster snapshot ID.

## Properties

`availability_zones`
: Provides the list of EC2 Availability Zones instances in the DB cluster snapshot that can be restored.

`db_cluster_snapshot_identifier`
: Specifies the identifier for the DB cluster snapshot.

`db_cluster_identifier`
: Specifies the identifier of the DB cluster from which the DB cluster snapshot is created.

`snapshot_create_time`
: Provides the time when the snapshot is taken, in Universal Coordinated Time (UTC).

`engine`
: Specifies the name of the database engine.

`allocated_storage`
: Specifies the allocated storage size in Gibibytes (GiB).

`status`
: Specifies the status of this DB cluster snapshot.

`port`
: Specifies the port where the DB cluster is listening at the time of the snapshot.

`vpc_id`
: Provides the VPC ID associated with the DB cluster snapshot.

`cluster_create_time`
: Specifies when the DB cluster is created, in Universal Coordinated Time (UTC).

`master_username`
: Provides the master username for the DB cluster snapshot.

`engine_version`
: Provides the version of the database engine for the DB cluster snapshot.

`license_model`
: Provides the license model information for the DB cluster snapshot.

`snapshot_type`
: Provides the DB cluster snapshot type.

`percent_progress`
: Specifies the percentage of the estimated data that is transferred.

`storage_encrypted`
: Specifies whether the DB cluster snapshot is encrypted.

`kms_key_id`
: If `StorageEncrypted` is true, the AWS Key Management Service (AWS KMS) identifier for the encrypted DB cluster snapshot is set to protect the data.

`db_cluster_snapshot_arn`
: The Amazon Resource Name (ARN) for the DB cluster snapshot.

`source_db_cluster_snapshot_arn`
: If the DB cluster snapshot is copied from a source DB cluster snapshot, the Amazon Resource Name (ARN) for the source DB cluster snapshot is associated, otherwise a null value is stored for the source DB cluster snapsot ARN.

`iam_database_authentication_enabled`
: `True`, if the mapping of the AWS Identity and Access Management (IAM) corresponds to database accounts that are enabled, and otherwise `False`.

`tag_list`
: The related tags.

## Examples

**Ensure a cluster snapshot ID is `available`.**

```ruby
describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "CLUSTER_ID") do
  its('db_cluster_snapshot_id') { should eq 'CLUSTER_ID' }
end
```

**Ensure that the status is `available`.**

```ruby
describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "CLUSTER_ID") do
    its('status') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "CLUSTER_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "CLUSTER_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_cluster_snapshot(db_cluster_snapshot_id: "CLUSTER_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBClusterSnapshotMessage" %}}
