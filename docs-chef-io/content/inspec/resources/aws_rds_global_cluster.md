+++
title = "aws_rds_global_cluster Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_global_cluster"
identifier = "inspec/resources/aws/aws_rds_global_cluster Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_global_cluster` InSpec audit resource to test properties of a single Amazon Aurora global database cluster.

The `AWS::RDS::GlobalCluster` resource creates or updates an Amazon Aurora global database spread across multiple AWS Regions.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::RDS::GlobalCluster` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-globalcluster.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the global cluster exists.

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER') do
  it { should exist }
end
```

## Parameters

`global_cluster_identifier` _(required)_

: The cluster identifier of the global database cluster.

## Properties

`global_cluster_identifier`
: The list of global clusters returned by this request.

`global_cluster_resource_id`
: Contains a user-supplied global database cluster identifier. This identifier is the unique key that identifies a global database cluster.

`global_cluster_arn`
: The Amazon Web Services Region-unique, immutable identifier for the global database cluster.

`status`
: Specifies the current state of this global database cluster.

`engine`
: The Aurora database engine used by the global database cluster.

`engine_version`
: Indicates the database engine version.

`database_name`
: The default database name within the new global database cluster.

`storage_encrypted`
: The storage encryption setting for the global database cluster.

`deletion_protection`
: The deletion protection setting for the new global database cluster.

`failover_state.status`
: The current status of the Aurora global database ( GlobalCluster ).

`failover_state.from_db_cluster_arn`
: The Amazon Resource Name (ARN) of the Aurora DB cluster that is currently being demoted, and which is associated with this state.

`failover_state.to_db_cluster_arn`
: The Amazon Resource Name (ARN) of the Aurora DB cluster that is currently being promoted, and which is associated with this state.

`global_cluster_members.db_cluster_arn`
: The Amazon Resource Name (ARN) for each Aurora cluster.

`global_cluster_members.readers`
: The Amazon Resource Name (ARN) for each read-only secondary cluster associated with the Aurora global database.

`global_cluster_members.is_writer`
: Specifies whether the Aurora cluster is the primary cluster (that is, has read-write capability) for the Aurora global database with which it is associated.

`global_cluster_members.global_write_forwarding_status`
: Specifies whether a secondary cluster in an Aurora global database has write forwarding enabled, not enabled, or is in the process of enabling it.

## Examples

**Ensure a DB global cluster is available.**

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER'') do
  its('global_cluster_resource_id') { should eq 'GLOBAL_CLUSTER_ID' }
end
```

**Ensure a global cluster engine is available.**

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER'') do
  its('engine') { should eq 'ENGINE' }
end
```

**Ensure a status is `available`.**

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER'') do
  its('status') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER'') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER'') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_global_cluster(global_cluster_identifier: 'GLOBAL_CLUSTER_IDENTIFIER') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeGlobalClustersMessage" %}}
