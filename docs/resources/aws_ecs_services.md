---
title: About the aws_ecs_services Resource
platform: aws
---
# aws\_ecs\_services

Use the `aws_ecs_services` InSpec audit resource to test properties of a plural Athena Work Groups.

The AWS::ECS::Service resource creates an Amazon Elastic Container Service (Amazon ECS) service that runs and maintains the requested number of tasks and associated load balancers.

## Syntax

Ensure that a service exists.
    describe aws_ecs_services(cluster: "cluster_name") do
      it { should exist }
    end

## Parameters

`cluster` _(required)_

For additional information, see the [AWS documentation on ECS Service](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html).

## Properties

| Property | Description|
| --- | --- |
| service_arns | The service arns of the service. |

## Examples

### Ensure a work_group name is available.
    describe aws_ecs_services(cluster: "cluster_name") do
      its('service_arns') { should include 'arn:aws:ecs:us-east-1:012345678910:service/ecs-simple-service' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ecs_services(cluster: "cluster_name") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_ecs_services(cluster: "cluster_name") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the service is available.

    describe aws_ecs_services(cluster: "cluster_name") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ecs:client:list_services` action with `Effect` set to `Allow`.