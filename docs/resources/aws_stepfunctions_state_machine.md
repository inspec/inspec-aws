---
title: About the aws_stepfunctions_state_machine Resource
platform: aws
---

# aws\_stepfunctions\_state\_machine

Use the `aws_stepfunctions_state_machine` InSpec audit resource to test properties of a single specific Step Functions state machine.

A state machine consists of a collection of states that can do work (Task states), determine which states to transition next (Choice states), stop an execution with an error (Fail states), and so on.

## Syntax

Ensure that an identity pool exists.

    describe aws_stepfunctions_state_machine(state_machine_arn: 'STATE_MACHINE_ARN') do
      it { should exist }
    end

## Parameters

`state_machine_arn` _(required)_

The ARN of the state machine.

For additional information, see the [AWS documentation on Step Functions state machine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html).

## Properties

| Property | Description|
| --- | --- |
| state_machine_arn | The ARN of the state machine. |
| name | The name of the state machine. |
| status | The current status of the state machine. |
| definition | The Amazon States Language definition of the state machine. |
| role_arn | The ARN of the IAM role used when creating this state machine. |
| type | The type of the state machine. Valid values: `STANDARD` or `EXPRESS`. |
| creation_date | The creation date of the state machine. |
| logging_configuration (level) | The category of execution history in which events are logged. |
| logging_configuration (include_execution_data) | Whether execution data is included in your log. Valid values: `true` or `false`. |
| logging_configuration (destinations) | An array of objects that describes where your execution history events will be logged. |
| tracing_configuration (enabled) | Selects whether or not the state machine's AWS X-Ray tracing is enabled. Valid values: `true` or `false`. |

## Examples

### Ensure a state machine ARN is available.

    describe aws_stepfunctions_state_machine(state_machine_arn: 'STATE_MACHINE_ARN') do
      its('state_machine_arn') { should eq 'STATE_MACHINE_ARN' }
    end

### Ensure that the status is available.

    describe aws_stepfunctions_state_machine(state_machine_arn: 'STATE_MACHINE_ARN') do
        its('status') { should eq 'ACTIVE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_stepfunctions_state_machine(state_machine_arn: 'STATE_MACHINE_ARN') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_stepfunctions_state_machine(state_machine_arn: 'STATE_MACHINE_ARN') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the identity pool id is available.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'STATE_MACHINE_ARN') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `States:Client:DescribeStateMachineOutput` action with `Effect` set to `Allow`.
