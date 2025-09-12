+++
title = "aws_ecs_task_definitions resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ecs_task_definitions"
identifier = "inspec/resources/aws/aws_ecs_task_definitions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ecs_task_definitions` InSpec audit resource to test the properties of multiple ECS task definitions.

For additional information, including details on parameters and properties, see the [AWS ECS task definition documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html).

## Syntax

Ensure that a task definition ARNs exists.

```ruby
describe aws_ecs_task_definitions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`task_definition_arns`
: A list of ARNs to describe the task definition.

## Examples

**Ensure a task definition ARN is available.**

```ruby
describe aws_ecs_task_definitions do
  its('task_definition_arns') { should include 'arn:aws:ecs:REGION:AWS_ACCOUNT_ID:task-definition/TASK_DEFINITION_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list_task_definitions` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ecs_task_definitions do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ecs_task_definitions do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the task definition arns is available.

```ruby
describe aws_ecs_task_definitions do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ECS:Client:ListTaskDefinitionsResponse" %}}
