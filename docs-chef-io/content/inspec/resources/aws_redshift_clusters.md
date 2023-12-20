+++
title = "aws_redshift_clusters Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_redshift_clusters"
identifier = "inspec/resources/aws/aws_redshift_clusters Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_redshift_clusters` InSpec audit resource to test properties of a collection of Amazon Redshift clusters.

Redshift gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure you have exactly 3 clusters

```ruby
describe aws_redshift_clusters do
  its('cluster_identifiers.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`cluster_identifiers`
: The unique IDs of the Redshift clusters returned.

: **Field**: `cluster_identifier`

`db_names`
: The name of the database associated with each Redshift cluster.

: **Field**: `db_name`

`node_types`
: The Redshift instance type.

: **Field**: `node_type`

`cluster_create_time`
: The create time of Redshift clusters.

: **Field**: `cluster_create_time`

`cluster_subnet_group_names`
: The cluster name of Redshift clusters.

: **Field**: `cluster_subnet_group_name`

`cluster_status`
: The current status of each cluster.

: **Field**: `cluster_status`

`cluster_availability_status`
: The current status of cluster.

: **Field**: `cluster_availability_status`

`modify_status`
: The current status of cluster.

: **Field**: `modify_status`

`availability_zones`
: A list of availability zones of the Redshift clusters returned.

: **Field**: `availability_zones`

`allow_version_upgrade`
: Returns `true` or `false` depending on whether version upgrade is allowed or not.

: **Field**: `allow_version_upgrade`

`encrypted`
: Returns `true` or `false` depending on whether Redshift clusters are encrypted or not.

: **Field**: `encrypted`

`cluster_subnet_group_names`
: Cluster subnet group name for Redshift clusters returned.

: **Field**: `cluster_subnet_group_name`

`iam_roles`
: The IAM roles that are used in the cluster.

: **Field**: `iam_roles`

`vpc_ids`
: The VPC ID of the Redshift clusters.

: **Field**: `vpc_id`

For a comprehensive list of properties available to test on an Redshift cluster see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/Redshift/Client.html#describe_clusters-instance_method.html).

## Examples

**Ensure a specific cluster exists.**

```ruby
describe aws_redshift_clusters do
  its('cluster_identifier') { should include 'cluster-12345678' }
end
```

**Request the IDs of all Redshift clusters, then test in-depth using `aws_redshift_cluster` to ensure all clusters are encrypted.**

```ruby
aws_redshift_clusters.cluster_identifier.each do |cluster_identifier|
    describe aws_redshift_cluster(cluster_identifier) do
      it { should have_encrypted }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should` to test entity exists.

```ruby
describe aws_redshift_clusters do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_redshift_clusters do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Redshift:Client:ClustersMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
