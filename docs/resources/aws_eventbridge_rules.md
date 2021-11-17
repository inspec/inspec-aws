---
title: About the aws_eventbridge_rules Resource
platform: aws
---

# aws\_eventbridge\_rules

Use the `aws_eventbridge_rules` InSpec audit resource to test properties of multiple Amazon EventBridge event rules.

The AWS::Events::Rule resource creates a rule that matches incoming events and routes them to one or more targets for processing.

## Syntax

Ensure that a rule name exists.

    describe aws_eventbridge_rules do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Events Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule.html).

## Properties

| Property | Description|
| --- | --- |
| names | The name of the rule. |
| arns | The Amazon Resource Name (ARN) of the rule. |
| event_patterns | The event pattern. |
| schedule_expressions | The scheduling expression. For example, "cron(0 20 * * ? *)", "rate(5 minutes)". |
| states | Specifies whether the rule is enabled or disabled. |
| descriptions | The description of the rule. |
| role_arns | The Amazon Resource Name (ARN) of the IAM role associated with the rule. |
| managed_bys | If this is a managed rule, created by an AWS service on your behalf, this field displays the principal name of the AWS service that created the rule. |
| event_bus_names | The name of the event bus associated with the rule. |

## Examples

### Ensure a rule name is available.

    describe aws_eventbridge_rules do
      its('name') { should include 'test_rule' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.

    describe aws_eventbridge_rules do
        its('state') { should include 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_eventbridge_rules do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_eventbridge_rules do
      it { should_not exist }
    end

### be_available

Use `should` to check if the rule name is available.

    describe aws_eventbridge_rules do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EventBridge:Client:ListRulesResponse` action with `Effect` set to `Allow`.
