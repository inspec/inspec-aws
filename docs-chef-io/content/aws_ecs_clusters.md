+++
title = "aws_ecs_clusters resource"

draft = false


[menu.aws]
title = "aws_ecs_clusters"
identifier = "inspec/resources/aws/aws_ecs_clusters resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecs_clusters` InSpec audit resource to test properties of some or all AWS ECS Clusters.

For additional information, including details on parameters and properties, see the [AWS documentation on ECS Clusters](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_clusters.html).

## Syntax

An `aws_ecs_clusters` resource block returns all ECS Clusters and allows the testing of that group of Clusters.

```ruby
describe aws_ecs_clusters do
  its('cluster_names') { should include 'cluster-root' }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`cluster_arn`
: The Amazon Resource Name (ARN) that identifies the cluster.

`cluster_name`
: A user-generated string that you use to identify your cluster.

`status`
: The status of the cluster.

`running_tasks_count`
: The number of tasks in the cluster that are in the RUNNING state.

`pending_tasks_count`
: The number of tasks in the cluster that are in the PENDING state.

`active_services_count`
: The number of services that are running on the cluster in an ACTIVE state.

`registered_container_instances_count`
: The number of container instances registered into the cluster. This includes container instances in both ACTIVE and DRAINING status.

`statistics`
: Additional information about your clusters that are separated by launch type.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

Ensure there are no Clusters in an undesired state:

```ruby
describe aws_ecs_clusters do
  it                   { should exist }
  its('statuses')      { should_not include 'UNDESIRED-STATUS'}
  its('cluster_names') { should include 'SQL-cluster' }
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ecs_clusters.where( <property>: <value>) do
  it { should exist }
end
```

```ruby
describe aws_ecs_clusters.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ECS:Client:ListClustersResponse` & `ECS:Client:DescribeClustersResponse` action set to allow.
