---
title: About the aws_ecs_services Resource
platform: aws
---
# aws\_ecs\_services

Use the `aws_ecs_services` InSpec audit resource to test properties of multiple AWS ECS Services.

The AWS ECS Service resource creates an Amazon Elastic Container Service (Amazon ECS) service that runs and maintains the requested number of tasks and associated load balancers.

## Syntax

Ensure that a service exists.

    describe aws_ecs_services(cluster: "CLUSTER_NAME") do
      it { should exist }
    end

## Parameters

`cluster` _(required)_

The short name or full Amazon Resource Name (ARN) of the cluster on which your service is running.

For additional information, see the [AWS documentation on ECS Service](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| service_arns | The ARNs of the services. |
| service_names | The names of the services. |
| cluster_arns | The Amazon Resource Name (ARN) of the cluster that hosts the services.|
| status |The status of the service. The valid values are `ACTIVE`, `DRAINING`, or `INACTIVE`. |
| desired_count |The desired number of instantiations of the task definition to keep running on the service. |
| running_count | The number of tasks in the cluster that are in the `RUNNING` state. |
| pending_count | The number of tasks in the cluster that are in the `PENDING` state.|
| launch_types | The infrastructure on which your service is running. |
| task_definitions | The task definitions to use for tasks in the service. |
| platform_versions | The AWS Fargate platform versions on which the tasks in the task set are running. |

For additional information, see the [AWS documentation on ECS describe services method](https://docs.aws.amazon.com/sdk-for-ruby/v2/api/Aws/ECS/Client.html#describe_services-instance_method).

## Examples

### Ensure a specific service is available on a cluster.

    describe aws_ecs_services(cluster: "CLUSTER_NAME") do
      its('service_arns') { should include 'SERVICE_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ecs_services(cluster: "CLUSTER_NAME") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ecs_services(cluster: "CLUSTER_NAME") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the service is available.

    describe aws_ecs_services(cluster: "CLUSTER_NAME") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ECS:Client:ListServicesResponse` action with `Effect` set to `Allow`.