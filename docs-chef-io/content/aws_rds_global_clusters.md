+++
title = "aws_rds_global_clusters resource"

draft = false


[menu.aws]
title = "aws_rds_global_clusters"
identifier = "inspec/resources/aws/aws_rds_global_clusters resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_global_clusters` InSpec audit resource to test properties of multiple Amazon Aurora global database clusters.

The AWS::RDS::GlobalCluster resource creates or updates an Amazon Aurora global database spread across multiple AWS Regions.

## Syntax

Ensure that the global cluster exists.

```ruby
aws_rds_global_clusters do
  it { should exist }
end
```

For additional information, see the [AWS documentation on the `AWS::RDS::GlobalCluster` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-globalcluster.html).

## Properties

`global_cluster_identifiers`
: The list of global clusters returned by this request.

: **Field**: `global_cluster_identifier`

`global_cluster_resource_ids`
: Contains a user-supplied global database cluster identifier.

: **Field**: `global_cluster_resource_id`

`global_cluster_arns`
: The Amazon Web Services Region-unique, immutable identifier for the global database cluster.

: **Field**: `global_cluster_arn`

`statuses`
: Specifies the current state of this global database cluster.

: **Field**: `status`

`engines`
: The Aurora database engine used by the global database cluster.

: **Field**: `engine`

`engine_versions`
: Indicates the database engine version.

: **Field**: `engine_version`

`database_names`
: The default database name within the new global database cluster.

: **Field**: `database_name`

`storage_encrypted`
: The storage encryption setting for the global database cluster.

: **Field**: `storage_encrypted`

`deletion_protections`
: The deletion protection setting for the new global database cluster.

: **Field**: `deletion_protection`

## Examples

Ensure global cluster resource ID is available:

```ruby
describe aws_rds_global_clusters do
  its('global_cluster_identifiers') { should include 'GLOBAL_CLUSTER_IDENTIFIER' }
end
```

Ensure global cluster resource ID is available:

```ruby
describe aws_rds_global_clusters do
  its('global_cluster_resource_ids') { should include 'GLOBAL_CLUSTER_RESOURCE_ID' }
end
```

Ensure a status is `available`:

```ruby
describe aws_rds_global_clusters do
  its('statuses') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_global_clusters do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_global_clusters do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_global_clusters do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeGlobalClustersMessage" %}}
