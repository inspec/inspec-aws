---
title: About the aws_ecs_service Resource
platform: aws
---

# aws\_ecs\_service

Use the `aws_ecs_service` InSpec audit resource to test properties of a single specific Athena Work Group.

The AWS::ECS::Service resource creates an Amazon Elastic Container Service (Amazon ECS) service that runs and maintains the requested number of tasks and associated load balancers.

## Syntax

Ensure that a services exists.
    describe aws_ecs_service(cluster: "default", services: ["arn:aws:ecs:us-east-1:012345678910:service/ecs-simple-service"]) do
      it { should exist }
    end

## Parameters

`cluster, services` _(required)_

For additional information, see the [AWS documentation on Athena Work Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description|
| --- | --- |
| services | A list of services to describe. You may specify up to 10 services to describe in a single operation. |
| failures | A list of faliures to describe. |

For additional information, see the [AWS documentation on ECS describe services method](https://docs.aws.amazon.com/sdk-for-ruby/v2/api/Aws/ECS/Client.html#describe_services-instance_method).

## Examples

### Ensure a work_group name is available.
    describe aws_ecs_service(cluster: "default", services: ["arn:aws:ecs:us-east-1:012345678910:service/ecs-simple-service"]) do
      its('service_name') { should eq 'service_name' }
    end

### Ensure that the status is `ACTIVE` or not.
    describe aws_ecs_service(cluster: "default", services: ["arn:aws:ecs:us-east-1:012345678910:service/ecs-simple-service"]) do
        its('status') { should eq 'ACTIVE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_ecs_service(cluster: "default", services: ["arn:aws:ecs:us-east-1:012345678910:service/ecs-simple-service"]) do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_ecs_service(cluster: "dummy", services: ["dummy"]) do
      it { should_not exist }
    end

### be_available

Use `should` to check if the services is available.
    describe aws_ecs_service(cluster: "default", services: ["arn:aws:ecs:us-east-1:012345678910:service/ecs-simple-service"]) do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecs:client:describe_services` action with `Effect` set to `Allow`.