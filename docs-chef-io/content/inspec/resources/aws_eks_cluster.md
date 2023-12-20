+++
title = "aws_eks_cluster Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_eks_cluster"
identifier = "inspec/resources/aws/aws_eks_cluster Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_eks_cluster` InSpec audit resource to test properties of a single AWS Elastic Container Service for Kubernetes.

For additional information, including details on parameters and properties, see the [AWS documentation on EKS Clusters](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_eks_cluster` resource block declares the tests for a single EKS Cluster by Cluster name.

```ruby
describe aws_eks_cluster('my-eks') do
  it { should exist }
end
```

```ruby
describe aws_eks_cluster(cluster_name: 'my-eks') do
  it { should exist }
end
```

## Parameters

`cluster_name` _(required if resource_data not provided)_

: The name of the EKS cluster.
  This can be passed either as a string or as a `cluster_name: 'value'` key-value entry in a hash.

`resource_data` _(required if cluster_name not provided)_

: A hash or the cached AWS response passed from the `aws_eks_clusters` resource.

## Properties

`arn`
: The Amazon Resource Name (ARN) of the cluster.

`name`
: The name of the cluster.

`endpoint`
: The endpoint for your Kubernetes API server.

`status`
: The current status of the cluster.

`version`
: The Kubernetes server version for the cluster.

`certificate_authority`
: The certificate-authority-data for your cluster.

`subnets_count`
: The number of subnets associated with your cluster.

`subnet_ids`
: The subnets associated with your cluster.

`security_groups_count`
: The count of security groups associated with your cluster.

`security_group_ids`
: The security groups associated with the cross-account elastic network interfaces that are used to allow communication between your worker nodes and the Kubernetes control plane.

`role_arn`
: The Amazon Resource Name (ARN) of the IAM role that provides permissions for the Kubernetes control plane to make calls to AWS API operations on your behalf.

`vpc_id`
: The VPC associated with your cluster.

`created_at`
: The Unix epoch timestamp in seconds for when the cluster was created.

`creating`
: Boolean indicating whether or not the state of the cluster is CREATING.

`active`
: Boolean indicating whether or not the state of the cluster is ACTIVE.

`failed`
: Boolean indicating whether or not the state of the cluster is FAILED.

`deleting`
: Boolean indicating whether or not the state of the cluster is DELETING.

`tags`
: Cluster tags.

`enabled_logging_types`
: Return list of enabled logging types.

`disabled_logging_types`
: Return list of disabled logging types.

## Examples

**Test that an EKS Cluster has at least 2 subnets.**

```ruby
describe aws_eks_cluster('my-cluster') do
  its('subnets_count') { should be > 1 }
end
```

**Ensure a Cluster has the correct status.**

```ruby
describe aws_eks_cluster(cluster_name: 'my-eks') do
  its('status') { should eq 'ACTIVE' }
end
```

**Ensure that the EKS Cluster is on the correct VPC.**

```ruby
describe aws_eks_cluster('my-cluster') do
  its('vpc_id') { should eq 'vpc-12345678' }
end
```

**Ensure the EKS Cluster is using the correct IAM Role.**

```ruby
describe aws_eks_cluster('my-cluster') do
  its('role_arn') { should cmp 'rn:aws:iam::012345678910:role/eks-service-role-AWSServiceRoleForAmazonEKS-J7ONKE3BQ4PI' }
end
```

**Ensure that the EKS Cluster is on the correct VPC from cached resources.**

```ruby
resource = aws_eks_clusters.where(cluster_name: 'my-eks')
describe aws_eks_cluster(resource_data: resource) do
  its('vpc_id') { should eq 'vpc-12345678' }
end
```

**Integrate with other resources.**

Use a combination of InSpec AWS resources to ensure your EKS Cluster does not use the Default VPC.

**Find the default Security Group for our VPC.**

```ruby
cluster_vpc = aws_eks_cluster(cluster_name: 'my-cluster').vpc_id
default_sg  = aws_security_group(group_name: 'default', vpc_id: cluster_vpc)
```

**Ensure we are not using the default Security Group.**

```ruby
describe aws_eks_cluster(cluster_name: 'my-cluster') do
  its('security_group_ids') { should_not include default_security_group.group_id }
end
```

## Matchers

This InSpec audit resource has no special matchers.

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_eks_cluster('AnExistingCluster') do
  it { should exist }
end
```

```ruby
describe aws_eks_cluster('ANonExistentCluster') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EKS:Client:DescribeClusterResponse" %}}

You can find detailed documentation at [Amazon EKS IAM Policies, Roles, and Permissions](https://docs.aws.amazon.com/eks/latest/userguide/IAM_policies.html)
The documentation for EKS actions is at [Policy Structure](https://docs.aws.amazon.com/eks/latest/userguide/iam-policy-structure.html#UsingWithEKS_Actions)
