+++
title = "aws_stepfunctions_state_machines resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_stepfunctions_state_machines"
identifier = "inspec/resources/aws/aws_stepfunctions_state_machines resource"
parent = "inspec/resources/aws"
+++

Use the `aws_stepfunctions_state_machines` InSpec audit resource to test properties of multiple Step Functions state machines.

A state machine consists of a collection of states that can do work (Task states), determine which states to transition next (Choice states), stop an execution with an error (Fail states), and so on.

For additional information, including details on parameters and properties, see the [AWS documentation on Step Functions state machine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html).

## Syntax

Ensure that a state machine exists.

```ruby
describe aws_stepfnctions_state_machines do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`state_machine_arns`
: The ARNs of the state machine.

`names`
: The names of the state machine.

`types`
: The type of the state machine. Valid values: `STANDARD` or `EXPRESS`.

`creation_date`
: The creation dates of the state machine.

## Examples

Ensure an state machine ARN is available:

```ruby
describe aws_stepfunctions_state_machines do
  its('state_machine_arns') { should include 'STATE_MACHINE_ARN' }
end
```

Ensure a name is available:

```ruby
describe aws_stepfunctions_state_machines do
    its('names') { should include 'STATE_MACHINE_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_stepfunctions_state_machines do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_stepfunctions_state_machines do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the state machine is available.

```ruby
describe aws_stepfunctions_state_machines do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="States:Client:ListStateMachinesOutput" %}}
