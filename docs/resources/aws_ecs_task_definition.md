---
title: About the aws_ecs_task_definition Resource
platform: aws
---

# aws\_ecs\_task\_definition

Use the `aws_ecs_task_definition` InSpec audit resource to test the properties of a single ECS task definition.

## Syntax

Ensure that a task definition exists.

    describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
      it { should exist }
    end

## Parameters

`task_definition` _(required)_

The full task definition description.
Specified as just the `family`that targets the latest active revision, or `family:revision` for a specific revision number of a family, or the full Amazon Resource Name (ARN) of the task definition.

For additional information, see the [AWS ECS task definition documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html).

## Properties

| Property | Description|
| --- | --- |
| task_definition_arn     | The ARN of the task definition. |
| family                  | The family of the task definition. |
| container_definitions   | The list of container definitions passed to the docker daemon. |
| task_role_arn           | The ARN of the AWS IAM role that grants containers in the task permission to call AWS APIs. |
| execution_role_arn      | The ARN of the execution role. |
| network_mode            | The Docker networking mode for the task containers. |
| revision                | The revision number of the task definition. |
| volumes                 | The data volumes used with the containers in the task. |
| status                  | The status of the task definition. |
| requires_attributes     | The required container instance attributes of the task. |
| placement_constraints   | The placement constraints on task placement in a task. |
| compatibilities         | The task launch types that the task definition was validated against. |
| cpu                     | The number of CPU units used by the task. |
| memory                  | The amount of memory used by the task in MiB. |
| inference_accelerators  | The Elastic Interference accelerators used for a container in a task. |
| pid_mode                | The process namespace use by containers in the task. Valid values are `host` or `task`. |
| ipc_mode                | The IPC resource namespace used by containers in the task. Valid values are `host`, `task`, or `none`. |
| proxy_configuration     | The configuration details for the App Mesh proxy. |
| tags                    | The tags of the task definition. |

## Examples

### Ensure a task definition ARN is available.

    describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
      its('task_definition_arn') { should eq 'ARN:AWS:ECS:REGION:AWS_ACCOUNT_ID:TASK-DEFINITION/TASK_DEFINITION_ID' }
    end

### Verify the amount of memory for a task definition.

    describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
        its('memory') { should eq 500 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of the available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the task definition is available.

    describe aws_ecs_task_definition(task_definition: 'TASK_DEFINITION') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecs:client:describe_task_definition` action with `Effect` set to `Allow`.
