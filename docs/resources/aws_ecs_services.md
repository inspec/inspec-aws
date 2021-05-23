---
title: About the aws_ecs_services Resource
platform: aws
---

# aws\_ecs\_services

Use the `aws_ecs_services` InSpec audit resource to test properties of a plural Athena Work Groups.

The AWS::ECS::Service resource creates an Amazon Elastic Container Service (Amazon ECS) service that runs and maintains the requested number of tasks and associated load balancers.

## Syntax

Ensure that a work_group exists.
    describe aws_athena_work_groups do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Athena Work Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description|
| --- | --- |
| name | test |

## Examples

### Ensure a work_group name is available.
    describe aws_athena_work_groups do
      its('names') { should include 'test1' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.
    describe aws_athena_work_groups do
        its('states') { should include 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_athena_work_groups do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_athena_work_groups do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_athena_work_groups do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecs:client:list_services` action with `Effect` set to `Allow`.