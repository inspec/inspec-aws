---
title: About the aws_eks_cluster Resource
---

# aws\_eks\_cluster

Use the `aws_eks_cluster` InSpec audit resource to test properties of a single AWS Elastic Container Service for Kubernetes. 

<br>

## Syntax

An `aws_eks_cluster` resource block declares the tests for a single EKS Cluster by Cluster name.

    describe aws_eks_cluster('my-eks') do
      it { should exist }
    end

    describe aws_eks_cluster(cluster_name: 'my-eks') do
      its('status') { should eq 'ACTIVE' }
    end

<br>

## Resource Parameters

## Examples

The following examples show how to use this InSpec audit resource.

### Test that an EKS Cluster does not exist

    describe aws_eks_cluster('bad-eks') do
      it { should_not exist }
    end

### Test that an EKS Cluster has at least 2 subnets

    describe aws_eks_cluster('my-cluster') do
      its('subnets_count') { should be > 1 }
    end

<br>

## Properties

### version

Returns a string identifying the version of the EKS Cluster.

    # Verify the version is 1.5
    describe aws_eks_cluster('my-cluster') do
      its('version') { should cmp '1.5' }
    end

### arn

Returns the ARN of the cluster.  This is the Amazon resource name.

    # Verify the arn is what we expect it to be
    describe aws_eks_cluster('my-cluster') do
      its('arn') { should eq 'arn:aws:eks:ab-region-1:012345678910:cluster/kangaroo' }
    end

### name

The name of the EKS cluster within AWS. The EKS name is unique within the region.

    # Ensure that the EKS's name is what we said it was
    describe aws_eks_cluster('my-cluster') do
      its('name') { should match /my-cluster/ }
    end

### status

Returns a string containing the current status of the cluster, possible values are: CREATING,ACTIVE,DELETING,FAILED.

    # ensure the cluster is available or being created
    describe aws_eks_cluster('my-cluster') do
      its('status') { should be_in %w(ACTIVE CREATING) }
    end

Status can also be called with predicates.

    # ensure the cluster is available
    describe aws_eks_cluster('my-cluster') do
      it { should be_active }
    end

    # ensure the cluster is being removed
    describe aws_eks_cluster('my-cluster') do
      it { should be_deleting }
    end

### endpoint

Returns a string with the K8s API server endpoint. The endpoint is used by kubectl to control the cluster.

    # Ensure that the endpoint is what we expect it to be
    describe aws_eks_cluster('my-cluster') do
      its('endpoint') { should eq 'https://A0DCCD80A04F01705DD065655C30CC3D.yl4.aq-south-2.eks.amazonaws.com' }
    end

### security\_group\_ids

Returns an array of strings reflecting the security group IDs (firewall rule sets) assigned to the EKS Cluster VPC.

    # Ensure that a specific SG ID is assigned
    describe aws_eks_cluster('my-cluster') do
      its('security_group_ids') { should include 'sg-12345678' }
    end

### subnet\_ids

Returns an array of strings reflecting the subnet IDs on which the EKS Cluster VPC is located.

    # Ensure that the EKS VPC is on a specific subnet
    describe aws_eks_cluster('my-cluster') do
      its('subnet_ids') { should include 'subnet-12345678' }
    end

### vpc\_id

Returns a String reflecting the ID of the VPC in which the EKS Cluster is located.

    # Ensure that the EKS Cluster is on a specific VPC
    describe aws_eks_cluster('my-cluster') do
      its('vpc_id') { should cmp 'vpc-12345678' }
    end

### role\_arn

Returns a String reflecting the Amazon resource name of the Amazon EKS Service IAM role the cluster is using.

    # Ensure that the EKS Cluster is using a specific IAM role
    describe aws_eks_cluster('my-cluster') do
      its('role_arn') { should cmp 'rn:aws:iam::012345678910:role/eks-service-role-AWSServiceRoleForAmazonEKS-J7ONKE3BQ4PI' }
    end

### certificate\_authority

Returns a String reflecting the certificate authority data used by kubectl to identify to the cluster.

    # Ensure that the EKS Cluster is using specific certificate authority data
    describe aws_eks_cluster('my-cluster') do
      its('certificate_authority') { should cmp 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1EVXpNVEl6TVRFek1Wb1hEVEk0TURVeU9ESXpNVEV6TVZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTTZWCjVUaG4rdFcySm9Xa2hQMzRlVUZMNitaRXJOZGIvWVdrTmtDdWNGS2RaaXl2TjlMVmdvUmV2MjlFVFZlN1ZGbSsKUTJ3ZURyRXJiQyt0dVlibkFuN1ZLYmE3ay9hb1BHekZMdmVnb0t6b0M1N2NUdGVwZzRIazRlK2tIWHNaME10MApyb3NzcjhFM1ROeExETnNJTThGL1cwdjhsTGNCbWRPcjQyV2VuTjFHZXJnaDNSZ2wzR3JIazBnNTU0SjFWenJZCm9hTi8zODFUczlOTFF2QTBXb0xIcjBFRlZpTFdSZEoyZ3lXaC9ybDVyOFNDOHZaQXg1YW1BU0hVd01aTFpWRC8KTDBpOW4wRVM0MkpVdzQyQmxHOEdpd3NhTkJWV3lUTHZKclNhRXlDSHFtVVZaUTFDZkFXUjl0L3JleVVOVXM3TApWV1FqM3BFbk9RMitMSWJrc0RzQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFNZ3RsQ1dIQ2U2YzVHMXl2YlFTS0Q4K2hUalkKSm1NSG56L2EvRGt0WG9YUjFVQzIrZUgzT1BZWmVjRVZZZHVaSlZCckNNQ2VWR0ZkeWdBYlNLc1FxWDg0S2RXbAp1MU5QaERDSmEyRHliN2pVMUV6VThTQjFGZUZ5ZFE3a0hNS1E1blpBRVFQOTY4S01hSGUrSm0yQ2x1UFJWbEJVCjF4WlhTS1gzTVZ0K1Q0SU1EV2d6c3JRSjVuQkRjdEtLcUZtM3pKdVVubHo5ZEpVckdscEltMjVJWXJDckxYUFgKWkUwRUtRNWEzMHhkVWNrTHRGQkQrOEtBdFdqSS9yZUZPNzM1YnBMdVoyOTBaNm42QlF3elRrS0p4cnhVc3QvOAppNGsxcnlsaUdWMm5SSjBUYjNORkczNHgrYWdzYTRoSTFPbU90TFM0TmgvRXJxT3lIUXNDc2hEQUtKUT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=',
' }
    end

### subnets\_count

Returns the number of subnets associated with the Cluster VPC.

    # Test that an EKS Cluster has 2 subnets
    describe aws_eks_cluster('my-cluster') do
      its('subnets_count') { should eq 2 }
    end


### created_at

Returns a Time object for the time the cluster was created at.

    # Test that an EKS Cluster was created after a certain date
    describe aws_eks_cluster('my-cluster') do
      its('created_at') { should be > Time.new(2011) }
    end

### security\_groups\_count

Returns the number of security groups associated with the Cluster VPC.

    # Test that an EKS Cluster has 2 security groups
    describe aws_eks_cluster('my-cluster') do
      its('security_groups_count') { should eq 2 }
    end

### integration with other resources

Using the resource together with other AWS resources.

    # find the default security group for our VPC
    my_vpc_id = aws_eks_cluster('my-cluster').vpc_id
    default_security_group = aws_security_group(group_name: 'default', vpc_id: my_vpc_id)

    # make sure we are not using the default security group
    describe aws_eks_cluster('my-cluster') do
      its('security_group_ids') { should_not include default_security_group.group_id }
    end

<br>

## Matchers

This InSpec audit resource has no special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).


## AWS Permissions
Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `eks:DescribeCluster` action set to Allow.

You can find detailed documentation at [Amazon EKS IAM Policies, Roles, and Permissions](https://docs.aws.amazon.com/eks/latest/userguide/IAM_policies.html)
The documentation for EKS actions is at [Policy Structure](https://docs.aws.amazon.com/eks/latest/userguide/iam-policy-structure.html#UsingWithEKS_Actions)