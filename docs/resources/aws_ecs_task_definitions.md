---
title: About the aws_ecs_task_definitions Resource
platform: aws
---

# aws\_ecs\_task\_definitions

Use the `aws_ecs_task_definitions` InSpec audit resource to test the properties of multiple ECS task definitions.

## Syntax

Ensure that a task definition ARNs exists.

    describe aws_ecs_task_definitions do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS ECS task definition documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html).

## Properties

| Property | Description|
| --- | --- |
| task_definition_arns | A list of ARNs to describe the task definition. |

## Examples

### Ensure a task definition ARN is available.

    describe aws_ecs_task_definitions do
      its('task_definition_arns') { should include 'arn:aws:ecs:REGION:AWS_ACCOUNT_ID:task-definition/TASK_DEFINITION_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list_task_definitions` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ecs_task_definitions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ecs_task_definitions do
      it { should_not exist }
    end

### be_available

Use `should` to check if the task definition arns is available.

    describe aws_ecs_task_definitions do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ECS:Client:ListTaskDefinitionsResponse` action with `Effect` set to `Allow`.
