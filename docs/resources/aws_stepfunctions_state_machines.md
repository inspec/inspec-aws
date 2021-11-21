---
title: About the aws_stepfunctions_state_machines Resource
platform: aws
---

# aws\_stepfunctions\_state\_machines

Use the `aws_stepfunctions_state_machines` InSpec audit resource to test properties of multiple Step Functions state machines.

A state machine consists of a collection of states that can do work (Task states), determine which states to transition next (Choice states), stop an execution with an error (Fail states), and so on.

## Syntax

Ensure that a state machine exists.

    describe aws_stepfnctions_state_machines do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Step Functions state machine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html).

## Properties

| Property | Description|
| --- | --- |
| state_machine_arns | The ARNs of the state machine. |
| names | The names of the state machine. |
| types | The type of the state machine. Valid values: `STANDARD` or `EXPRESS`. |
| creation_date | The creation dates of the state machine. |

## Examples

### Ensure an state machine ARN is available.

    describe aws_stepfunctions_state_machines do
      its('state_machine_arns') { should include 'STATE_MACHINE_ARN' }
    end

### Ensure a name is available.

    describe aws_stepfunctions_state_machines do
        its('names') { should include 'STATE_MACHINE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_stepfunctions_state_machines do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_stepfunctions_state_machines do
      it { should_not exist }
    end

### be_available

Use `should` to check if the state machine is available.

    describe aws_stepfunctions_state_machines do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `States:Client:ListStateMachinesOutput` action with `Effect` set to `Allow`.
