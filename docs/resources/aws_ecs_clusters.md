---
title: About the aws_ecs_clusters Resource
platform: aws
---

# aws\_ecs\_clusters

Use the `aws_ecs_clusters` InSpec audit resource to test properties of some or all AWS ECS Clusters.


<br>

## Availability

### Installation

    ...


## Syntax

An `aws_ecs_clusters` resource block returns all ECS Clusters and allows the testing of that group of Clusters.

    describe aws_ecs_clusters do
      its('cluster_names') { should include 'cluster-root' }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.


    Ensure there are no Clusters in an undesired state.

      describe aws_ecs_clusters do
        it                   { should exist }
        its('statuses')      { should_not include 'UNDESIRED-STATUS'}
        its('cluster_names') { should include 'SQL-cluster' }
      end
<br>

## Properties

* cluster_names 
* cluster_arns 
* statuses 
* registered_container_instances_counts 
* running_tasks_counts
* pending_tasks_counts
* active_services_counts
* statistics

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the filtered IAM User(s) exists.

      describe aws_ecs_clusters.where( <property>: <value>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecs:ListClusters` & `ecs:DescribeClusters` action set to allow.
