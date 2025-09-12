+++
title = "aws_ecs_service resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ecs_service"
identifier = "inspec/resources/aws/aws_ecs_service resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecs_service` InSpec audit resource to test properties of a single AWS ECS Service.

The AWS ECS Service resource creates an Amazon Elastic Container Service (Amazon ECS) service that runs and maintains the requested number of tasks and associated load balancers.

For additional information, including details on parameters and properties, see the [AWS documentation on ECS Service](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html).

## Syntax

Ensure that a services exists.

```ruby
describe aws_ecs_service(cluster: "default", service: "SERVICE_ARN") do
  it { should exist }
end
```

## Parameters

`cluster`

: The short name or full Amazon Resource Name (ARN) of the cluster on which your service is running.

`service` _(required)_

: The ECS service ARN or service name.

## Properties

`service_arn`
: The ARN of the service.

`service_name`
: The name of the service.

`cluster_arn`
: The Amazon Resource Name (ARN) of the cluster that hosts the service.

`status`
: The status of the service. The valid values are `ACTIVE`, `DRAINING`, or `INACTIVE`.

`desired_count`
: The desired number of instantiations of the task definition to keep running on the service.

`running_count`
: The number of tasks in the cluster that are in the `RUNNING` state.

`pending_count`
: The number of tasks in the cluster that are in the `PENDING` state.

`launch_type`
: The infrastructure on which your service is running.

`task_definition`
: The task definition to use for tasks in the service.

`platform_version`
: The AWS Fargate platform version on which the tasks in the task set are running.

For additional information, see the [AWS documentation on ECS describe services method](https://docs.aws.amazon.com/sdk-for-ruby/v2/api/Aws/ECS/Client.html#describe_services-instance_method).

## Examples

Ensure a work group name is available:

```ruby
describe aws_ecs_service(cluster: "default", service: "SERVICE_ARN") do
  its('service_name') { should eq 'service_name' }
end
```

Ensure that the status is `ACTIVE` or not:

```ruby
describe aws_ecs_service(cluster: "default", service: "SERVICE_ARN") do
    its('status') { should eq 'ACTIVE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ecs_service(cluster: "CLUSTER_NAME", service: "SERVICE_ARN") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ecs_service(cluster: "CLUSTER_NAME", service: "SERVICE_NAME") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the services is available.

```ruby
describe aws_ecs_service(cluster: "default", service: "SERVICE_ARN") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECS:Client:DeleteServiceResponse" %}}
