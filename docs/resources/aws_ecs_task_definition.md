---
title: About the aws_ecs_task_definition Resource
platform: aws
---

# aws\_ecs\_task\_definition

Use the `aws_ecs_task_definition` InSpec audit resource to test properties of a single specific ECS Task Definition.

The AWS::ECS::TaskDefinition resource describes the container and volume definitions of an Amazon Elastic Container Service (Amazon ECS) task. You can specify which Docker images to use, the required resources, and other configurations related to launching the task definition through an Amazon ECS service or task.

## Syntax

Ensure that a task definition exists.
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
      it { should exist }
    end

## Parameters

`task_definition` _(required)_

For additional information, see the [AWS documentation on ECS Task Definition](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html).

## Properties

| Property | Description|
| --- | --- |
| task_definition_arn | The family for the latest ACTIVE revision, family and revision (family:revision) for a specific revision in the family, or full Amazon Resource Name (ARN) of the task definition to describe. |
| container_definitions | A list of container definitions in JSON format that describe the different containers that make up your task.  |
| family | The name of a family that this task definition is registered to. Up to 255 letters (uppercase and lowercase), numbers, hyphens, and underscores are allowed. |
| task_role_arn | The short name or full Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that grants containers in the task permission to call AWS APIs on your behalf.  |
| execution_role_arn | The Amazon Resource Name (ARN) of the task execution role that grants the Amazon ECS container agent permission to make AWS API calls on your behalf. |
| network_mode | The Docker networking mode to use for the containers in the task. The valid values are none, bridge, awsvpc, and host. The default Docker network mode is bridge. If you are using the Fargate launch type, the awsvpc network mode is required. If you are using the EC2 launch type, any network mode can be used. If the network mode is set to none, you cannot specify port mappings in your container definitions, and the tasks containers do not have external connectivity. The host and awsvpc network modes offer the highest networking performance for containers because they use the EC2 network stack instead of the virtualized network stack provided by the bridge mode. |
| revision | The revision for the task. |
| volumes | The list of data volume definitions for the task. |
| status | The revision for the task. |
| requires_attributes | The attributes for the task. |
| placement_constraints | An array of placement constraint objects to use for tasks. |
| compatibilities | The compatibilities for the task. |
| cpu | The number of cpu units used by the task. If you are using the EC2 launch type, this field is optional and any value can be used. |
| memory | The amount (in MiB) of memory used by the task. |
| inference_accelerators | The Elastic Inference accelerators to use for the containers in the task. |
| pid_mode | The process namespace to use for the containers in the task. The valid values are host or task. If host is specified, then all containers within the tasks that specified the host PID mode on the same container instance share the same process namespace with the host Amazon EC2 instance. If task is specified, all containers within the specified task share the same process namespace. If no value is specified, the default is a private namespace. |
| ipc_mode | The IPC resource namespace to use for the containers in the task. The valid values are host, task, or none. If host is specified, then all containers within the tasks that specified the host IPC mode on the same container instance share the same IPC resources with the host Amazon EC2 instance. If task is specified, all containers within the specified task share the same IPC resources. If none is specified, then IPC resources within the containers of a task are private and not shared with other containers in a task or on the container instance. If no value is specified, then the IPC resource namespace sharing depends on the Docker daemon setting on the container instance. |
| proxy_configuration | The ProxyConfiguration property specifies the configuration details for the App Mesh proxy. |
| tags | The metadata that you apply to the task definition to help you categorize and organize them. Each tag consists of a key and an optional value, both of which you define. |

## Examples

### Ensure a task definition arn is available.
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
      its('task_definition_arn') { should eq 'arn:aws:ecs:us-east-1:<aws_account_id>:task-definition/hello_world:8' }
    end

### Ensure that the memory is available.
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
        its('memory') { should eq 500 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_ecs_task_definition(task_definition: 'dummy') do
      it { should_not exist }
    end

### be_available
Use `should` to check if the task definition is available.
    describe aws_ecs_task_definition(task_definition: 'hello_world:8') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecs:client:describe_task_definition` action with `Effect` set to `Allow`.