---
title: About the aws_redshift_clusters Resource
platform: aws
---

# aws\_redshift\_clusters

Use the `aws_redshift_clusters` InSpec audit resource to test properties of a collection of AWS redshift clusters.

redshift gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

## Syntax

Ensure you have exactly 3 clusters

    describe aws_redshift_clusters do
      its('cluster_identifiers.count') { should cmp 3 }
    end

#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on redshift](https://docs.aws.amazon.com/redshift/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|cluster\_identifier    | The unique IDs of the redshift clusters returned. |
|db\_name    | The name of the database associated with each redshift cluster. | 
|node\_type    | The redshift instance type. |
|cluster\_create\_time    | The create time of redshift clusters. | 
|cluster\_subnet\_group\_name    | The cluster name of redshift clusters. |
|cluster\_status   | The current status of each cluster . | 
|cluster\_availability\_status    | The current status of cluster. |
|modify\_status    | The current status of cluster | 
|availability\_zones    | A list of availability zones of the redshift clusters returned.  |
|allow_version_upgrade  | Returns T/F depending on whether version upgrade is allowed or not. | 
|encrypted   |  Returns T/F depending on whether Redshift clusters are encrypted or not. |
|cluster_subnet_group_name   | Cluster subnet group name for redshift clusters returned.  |
|iam\_roles  | iam_roles that are used in the cluster. | 
|vpc\_id  | vpc_id of the redshift clusters. |     
## Examples

#####Ensure a specific cluster exists
    describe aws_redshift_clusters do
      its('cluster_identifier') { should include 'cluster-12345678' }
    end

##### Use the InSpec resource to request the IDs of all redshift clusters, then test in-depth using `aws_redshift_cluster` to ensure all clusters are encrypted.
    aws_redshift_clusters.cluster_identifier.each do |cluster_identifier|
        describe aws_redshift_cluster(cluster_identifier) do
          it { should have_encrypted }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_redshift_clusters do
      it { should exist }
    end
      
    describe aws_redshift_clusters do
      it { should_not exist }
    end

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:Describeclusters`, and `iam:GetInstanceProfile` actions set to allow.
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
