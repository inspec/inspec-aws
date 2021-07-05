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
| service_names | The name of the service. |
| cluster_arns | The Amazon Resource Name (ARN) of the cluster that hosts the service.|
| status |The status of the service. The valid values are ACTIVE , DRAINING , or INACTIVE . |
| desired_count |The desired number of instantiations of the task definition to keep running on the service. |
| running_count | The number of tasks in the cluster that are in the RUNNING state. |
| pending_count | The number of tasks in the cluster that are in the PENDING state.|
| launch_types | The infrastructure on which your service is running. |
| task_definitions | The task definition to use for tasks in the service. |
| platform_versions | The AWS Fargate platform version on which the tasks in the task set are running. |

For additional information, see the [AWS documentation on ECS describe services method](https://docs.aws.amazon.com/sdk-for-ruby/v2/api/Aws/ECS/Client.html#describe_services-instance_method).



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