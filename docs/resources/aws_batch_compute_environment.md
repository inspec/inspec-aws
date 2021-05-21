---
title: About the aws_batch_compute_environment Resource
platform: aws
---

# aws\_batch\_compute\_environment

Use the `aws_batch_compute_environment` InSpec audit resource to test properties of a single specific Batch Compute Environment.

The AWS::Batch::ComputeEnvironment resource defines your AWS Batch compute environment. You can define MANAGED or UNMANAGED compute environments. MANAGED compute environments can use Amazon EC2 or resources. UNMANAGED compute environments can only use EC2 resources.

## Syntax

Ensure that a compute_environment name exists.
    describe aws_batch_compute_environment(compute_environment_name: 'test1') do
      it { should exist }
    end

## Parameters

`compute_environment_name` _(required)_

For additional information, see the [AWS documentation on Batch Compute Environment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-computeenvironment.html).

## Properties

| Property | Description|
| --- | --- |
| compute_environment_name | The name of the compute environment. |
| compute_environment_arn | The arn of the compute environment. |
| ecs_cluster_arn | The ecs cluster arn of the compute environment. |
| tags | The tags of the compute environment. |
| type | The type of the compute environment. |
| state | The state of the compute environment. |
| status | The status of the compute environment. |
| status_reason | The status reason of the compute environment. |
| compute_resources (type) | The type of the compute resources of the compute environment. |
| compute_resources (allocation_strategy) | The allocation strategy of the compute resources of the compute environment. |
| compute_resources (minv_cpus) | The minv cpus of the compute resources of the compute environment. |
| compute_resources (maxv_cpus) | The maxv cpus of the compute resources of the compute environment. |
| compute_resources (desiredv_cpus) | The desiredv cpus of the compute resources of the compute environment. |
| compute_resources (instance_types) | The instance types of the compute resources of the compute environment. |
| compute_resources (image_id) | The image id of the compute resources of the compute environment. |
| compute_resources (subnets) | The subnets of the compute resources of the compute environment. |
| compute_resources (security_group_ids) | The security group ids of the compute resources of the compute environment. |
| compute_resources (ec2_key_pair) | The ec2 key pair of the compute resources of the compute environment. |
| compute_resources (instance_role) | The instance role of the compute resources of the compute environment. |
| compute_resources (tags) | The tags of the compute resources of the compute environment. |
| compute_resources (placement_group) | The placement group of the compute resources of the compute environment. |
| compute_resources (bid_percentage) | The bid percentage of the compute resources of the compute environment. |
| compute_resources (spot_iam_fleet_role) | The spot iam fleet role of the compute resources of the compute environment. |
| compute_resources (launch_template (launch_template_id)) | The id of the launch template of the compute resources of the compute environment. |
| compute_resources (launch_template (launch_template_name)) | The name of the launch template of the compute resources of the compute environment. |
| compute_resources (launch_template (version)) | The version of the launch template of the compute resources of the compute environment. |
| service_role | The service role of the compute environment. |

## Examples

### Ensure a compute environment name is available.
    describe aws_batch_compute_environment(compute_environment_name: 'test1') do
      its('compute_environment_name') { should eq 'test1' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.
    describe aws_batch_compute_environment(compute_environment_name: 'test1') do
        its('state') { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_batch_compute_environment(compute_environment_name: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_batch_compute_environment(compute_environment_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the compute environment name is available.

    describe aws_batch_compute_environment(compute_environment_name: 'test1') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `batch:client:describe_compute_environments` action with `Effect` set to `Allow`.