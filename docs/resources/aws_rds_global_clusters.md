---
title: About the aws_rds_global_clusters Resource
platform: aws
---

# aws_rds_global_clusters

Use the `aws_rds_global_clusters` InSpec audit resource to test properties of multiple Amazon Aurora global database clusters.

The AWS::RDS::GlobalCluster resource creates or updates an Amazon Aurora global database spread across multiple AWS Regions.

## Syntax

Ensure that the global cluster exists.

    aws_rds_global_clusters do
      it { should exist }
    end

For additional information, see the [AWS documentation on the `AWS::RDS::GlobalCluster` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-globalcluster.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| global_cluster_identifiers | The list of global clusters returned by this request. | global_cluster_identifier |
| global_cluster_resource_ids | Contains a user-supplied global database cluster identifier. | global_cluster_resource_id |
| global_cluster_arns | The Amazon Web Services Region-unique, immutable identifier for the global database cluster. | global_cluster_arn |
| statuses | Specifies the current state of this global database cluster. | status |
| engines | The Aurora database engine used by the global database cluster. | engine |
| engine_versions | Indicates the database engine version. | engine_version |
| database_names | The default database name within the new global database cluster. | database_name |
| storage_encrypted | The storage encryption setting for the global database cluster. | storage_encrypted |
| deletion_protections | The deletion protection setting for the new global database cluster. | deletion_protection |

## Examples

### Ensure global cluster resource ID is available.

    describe aws_rds_global_clusters do
      its('global_cluster_identifiers') { should include 'GLOBAL_CLUSTER_IDENTIFIER' }
    end

### Ensure global cluster resource ID is available.

    describe aws_rds_global_clusters do
      its('global_cluster_resource_ids') { should include 'GLOBAL_CLUSTER_RESOURCE_ID' }
    end

### Ensure a status is `available`.

    describe aws_rds_global_clusters do
      its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_global_clusters do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_global_clusters do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_global_clusters do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeGlobalClustersMessage` action with `Effect` set to `Allow`.
