---
title: About the aws_batch_job_definition Resource
platform: aws
---

# aws\_batch\_job\_definition

Use the `aws_batch_job_definition` InSpec audit resource to test properties of a single specific Batch Job Definition.

The AWS::Batch::JobDefinition resource specifies the parameters for an AWS Batch job definition.

## Syntax

Ensure that a job definition name exists.

    describe aws_batch_job_definition(job_definition_name: 'test1') do
      it { should exist }
    end

## Parameters

`job_definition_name` _(required)_

For additional information, see the [AWS documentation on Batch Job Definition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).

## Properties

| Property | Description|
| --- | --- |
| job_definition_name | The name of the job definition. |
| job_definition_arn | The arn of the job definition. |
| revision | The revision of the job definition. |
| status | The status of the job definition. |
| type | The type of the job definition. |
| parameters | The parameters of the job definition. |
| container_properties (image) | The image of the container properties of the job definition. |
| container_properties (vcpus) | The vcpus of the container properties of the job definition. |
| container_properties (memory) | The memory of the container properties of the job definition. |
| container_properties (command) | The command of the container properties of the job definition. |
| container_properties (job_role_arn) | The job role arn of the container properties of the job definition. |
| container_properties (execution_role_arn) | The execution role arn of the container properties of the job definition. |
| container_properties (volumes) | The volumes of the container properties of the job definition. |
| container_properties (environment) | The environment of the container properties of the job definition. |
| container_properties (mount_points) | The mount points of the container properties of the job definition. |
| container_properties (readonly_root_filesystem) | The image of the container properties of the job definition. |
| container_properties (image) | The readonly root filesystem of the container properties of the job definition. |
| container_properties (privileged) | The privileged of the container properties of the job definition. |
| container_properties (ulimits) | The ulimits of the container properties of the job definition. |
| container_properties (user) | The user of the container properties of the job definition. |
| container_properties (instance_type) | The instance type of the container properties of the job definition. |
| container_properties (resource_requirements) | The resource requirements of the container properties of the job definition. |
| container_properties (linux_parameters (shared_memory_size)) | The shared_memory_size of the linux parameters of the container properties of the job definition. |
| container_properties (linux_parameters (tmpfs)) | The tmpfs of the linux parameters of the container properties of the job definition. |
| container_properties (linux_parameters (max_swap)) | The max_swap of the linux parameters of the container properties of the job definition. |
| container_properties (linux_parameters (swappiness)) | The swappiness of the linux parameters of the container properties of the job definition. |
| container_properties (log_configuration (options)) | The options of the log configuration of the container properties of the job definition. |
| container_properties (log_configuration (shared_memory_size)) | The shared_memory_size of the log configuration of the container properties of the job definition. |
| container_properties (secrets) | The secrets of the container properties of the job definition. |
| timeout (attempt_duration_seconds) | The attempt_duration_seconds of the timeout of the job definition. |
| node_properties (num_nodes) | The num_nodes of the node_properties of the job definition. |
| node_properties (main_node) | The main_node of the node_properties of the job definition. |
| node_properties (node_range_properties) | The node_range_properties of the node_properties of the job definition. |
| tags | The tags of the job definition. |
| propagate_tags | The propagate_tags of the job definition. |
| platform_capabilities | The platform_capabilities of the job definition. |

## Examples

### Ensure a job definition name is available.
    describe aws_batch_job_definition(job_definition_name: 'test1') do
      its('job_definition_name') { should eq 'test1' }
    end

### Ensure that the state is `Active` or `not`.
    describe aws_batch_job_definition(job_definition_name: 'test1') do
        its('status') { should eq 'ACTIVE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_batch_job_definition(job_definition_name: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_batch_job_definition(job_definition_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the job definition name is available.

    describe aws_batch_job_definition(job_definition_name: 'test1') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `batch:client:describe_job_definitions` action with `Effect` set to `Allow`.