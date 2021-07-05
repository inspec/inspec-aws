---
title: About the aws_stepfunctions_state_machine Resource
platform: aws
---

# aws\_stepfunctions\_state\_machine

Use the `aws_stepfunctions_state_machine` InSpec audit resource to test properties of a single specific Step Functions State Machine.

Provisions a state machine. A state machine consists of a collection of states that can do work (Task states), determine to which states to transition next (Choice states), stop an execution with an error (Fail states), and so on. State machines are specified using a JSON-based, structured language.

## Syntax

Ensure that an identity pool exists.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'test') do
      it { should exist }
    end

## Parameters

`state_machine_arn` _(required)_

For additional information, see the [AWS documentation on Step Functions State Machine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html).

## Properties

| Property | Description|
| --- | --- |
| state_machine_arn | The arn of the state machine. |
| name | The name of the state machine. |
| status | The status of the state machine. |
| definition | The definition of the state machine. |
| role_arn | The role arn of the state machine. |
| type | The type of the state machine. |
| creation_date | The creation date of the state machine. |
| logging_configuration (level) | The level of the logging configuration of the state machine. |
| logging_configuration (include_execution_data) | The include execution data of the logging configuration of the state machine. |
| logging_configuration (destinations) | The destinations of the logging configuration of the state machine. |
| logging_configuration (enabled) | Selects whether or not the state machine's AWS X-Ray tracing is enabled. |

## Examples

### Ensure a state machine arn is available.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'test') do
      its('state_machine_arn') { should eq 'test' }
    end

### Ensure that the status is available.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'name') do
        its('status') { should eq 'ACTIVE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the identity pool id is available.
    describe aws_stepfunctions_state_machine(state_machine_arn: 'test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `states:client:describe_state_machine` action with `Effect` set to `Allow`.