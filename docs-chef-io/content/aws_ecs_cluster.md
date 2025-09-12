+++
title = "aws_ecs_cluster resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ecs_cluster"
identifier = "inspec/resources/aws/aws_ecs_cluster resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecs_cluster` InSpec audit resource to test properties of a single AWS ECS Cluster.

For additional information, including details on parameters and properties, see the [AWS documentation on ECS Clusters](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_clusters.html).

## Syntax

An `aws_ecs_cluster` resource block declares the tests for a single AWS ECS Cluster by cluster name.

```ruby
describe aws_ecs_cluser(cluster_name: 'cluster-8') do
  it             { should exist }
end
```

## Parameters

If no parameters are passed, the resource will attempt to retrieve the `default` ECS Cluster.

`cluster_name` _(optional)_

: This resource accepts a single parameter, the Cluster Name.
  This can be passed either as a string or as a `cluster_name: 'value'` key-value entry in a hash.

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

## Examples

**Test that an ECS Cluster does not exist.**

```ruby
describe aws_ecs_cluster(cluster_name: 'invalid-cluster') do
  it    { should_not exist }
end
```

**Test that an ECS Cluster is active.**

```ruby
describe aws_ecs_cluster('cluster-8') do
  its ('status') { should eq 'ACTIVE' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ecs_cluster('cluster-8') do
  it { should exist }
end
```

```ruby
describe aws_ecs_cluster('cluster-9') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECS:Client:DescribeClustersResponse" %}}
