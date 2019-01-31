---
title: About the aws_ecs_cluster Resource
platform: aws
---

# aws\_ecs\_cluster

Use the `aws_ecs_cluster` InSpec audit resource to test properties of a single AWS ECS Cluster.

<br>

## Availability

### Installation

    ...
## Syntax

An `aws_ecs_cluster` resource block declares the tests for a single AWS ECS Cluster by cluster name.

    describe aws_ecs_cluser(cluster_name: 'cluster-8') do
      it             { should exist }
      its ('status') { should eq 'ACTIVE' }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that an ECS Cluster does not exist

    describe aws_ecs_cluster(cluster_name: 'invalid-cluster') do
      it    { should_not exist }
    end

### Test that an ECS Cluster is active

    describe aws_cs_cluster('cluster-8') do
      its ('status') { should eq 'ACTIVE' }
    end

<br>

## Properties

* cluster_name 
* cluster_arn 
* status 
* registered_container_instances_count 
* running_tasks_count
* pending_tasks_count
* active_services_count
* statistics

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the described ECS Cluster exists.

    it { should exist }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeClusters` action set to allow.

