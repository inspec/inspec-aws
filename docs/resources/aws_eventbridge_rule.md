---
title: About the aws_eventbridge_rule Resource
platform: aws
---

# aws\_eventbridge\_rule

Use the `aws_eventbridge_rule` InSpec audit resource to test properties of a single Amazon EventBridge event rule.

The AWS::Events::Rule resource creates a rule that matches incoming events and routes them to one or more targets for processing.

## Syntax

Ensure that a rule name exists.

    describe aws_eventbridge_rule(name: 'test_rule') do
      it { should exist }
    end

## Parameters

`name` _(required)_

The name of the rule.
Pass the name as a key-value entry in a hash.

For additional information, see the [AWS documentation on Events Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule.html).

## Properties

| Property | Description|
| --- | --- |
| name | The name of the rule. |
| arn | The Amazon Resource Name (ARN) of the rule. |
| event_pattern | The event pattern. |
| schedule_expression | The scheduling expression. For example, "cron(0 20 * * ? *)", "rate(5 minutes)". |
| state | Specifies whether the rule is enabled or disabled. |
| description | The description of the rule. |
| role_arn | The Amazon Resource Name (ARN) of the IAM role associated with the rule. |
| managed_by | If this is a managed rule, created by an AWS service on your behalf, this field displays the principal name of the AWS service that created the rule. |
| event_bus_name | The name of the event bus associated with the rule. |

## Examples

### Ensure a rule name is available.

    describe aws_eventbridge_rule(name: 'RULE_NAME') do
      its('name') { should eq 'RULE_NAME' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.

    describe aws_eventbridge_rule(name: 'RULE_NAME') do
        its('state') { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_eventbridge_rule(name: 'test_rule') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_eventbridge_rule(name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_eventbridge_rule(name: 'test_rule') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `eventbridge_client.describe_rule` action with `Effect` set to `Allow`.
