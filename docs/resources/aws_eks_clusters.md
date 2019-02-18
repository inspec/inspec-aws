---
title: About the aws_eks_clusters Resource
platform: aws
---

# aws\_eks\_clusters

Use the `aws_eks_clusters` InSpec audit resource to test properties of some or all AWS Elastic Container Service for Kubernetes.

<br>

## Availability

### Installation

This resource is distributed along with InSpec itself. You can use it automatically.

### Version

...

## Syntax

An `aws_eks_clusters` resource block collects a group of EKS Clusters and then tests that group.

    # Verify the number of Eks Clusters in the AWS account
    describe aws_eks_clusters do
      its('names.count') { should cmp 10 }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_eks_clusters`, its limited functionality precludes examples.

<br>

## Properties
* `names`
* `arns`
* `certificate_authorities`
* `versions`
* `statuses`
* `endpoints`
* `subnets_counts`
* `subnet_ids`
* `security_group_ids`
* `created_ats`
* `role_arns`
* `vpc_ids`
* `security_groups_counts`
* `creating`
* `active`
* `failed`
* `deleting`

<br>

## Property Examples

### entries

Provides access to the raw results of the query. This can be useful for checking counts and other advanced operations.

    # Allow at most 100 EKS Clusters on the account
    describe aws_eks_clusters do
      its('names.count') { should be <= 100}
    end

### names

Provides a list of cluster names for all EKS Clusters in the AWS account.

    describe aws_eks_clusters do
      its('names') { should include('cluster-1') }
    end
<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # Verify that at least one EKS Cluster exists.
    describe aws_eks_clusters
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `eks:DescribeCluster` action with Effect set to Allow.

You can find detailed documentation at [Amazon EKS IAM Policies, Roles, and Permissions](https://docs.aws.amazon.com/eks/latest/userguide/IAM_policies.html)
The documentation for EKS actions is at [Policy Structure](https://docs.aws.amazon.com/eks/latest/userguide/iam-policy-structure.html#UsingWithEKS_Actions)
