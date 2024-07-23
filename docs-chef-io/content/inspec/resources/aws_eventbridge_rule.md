+++
title = "aws_eventbridge_rule Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_eventbridge_rule"
identifier = "inspec/resources/aws/aws_eventbridge_rule Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_eventbridge_rule` InSpec audit resource to test properties of a single Amazon EventBridge event rule.

The AWS::Events::Rule resource creates a rule that matches incoming events and routes them to one or more targets for processing.

For additional information, including details on parameters and properties, see the [AWS documentation on Events Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a rule name exists.

```ruby
describe aws_eventbridge_rule(name: 'test_rule') do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: The name of the rule.
  Pass the name as a key-value entry in a hash.

## Properties

`name`
: The name of the rule.

`arn`
: The Amazon Resource Name (ARN) of the rule.

`event_pattern`
: The event pattern.

`schedule_expression`
: The scheduling expression. For example, "cron(0 20 * * ? *)", "rate(5 minutes)".

`state`
: Specifies whether the rule is enabled or disabled.

`description`
: The description of the rule.

`role_arn`
: The Amazon Resource Name (ARN) of the IAM role associated with the rule.

`managed_by`
: If this is a managed rule, created by an AWS service on your behalf, this field displays the principal name of the AWS service that created the rule.

`event_bus_name`
: The name of the event bus associated with the rule.

## Examples

**Ensure a rule name is available.**

```ruby
describe aws_eventbridge_rule(name: 'RULE_NAME') do
  its('name') { should eq 'RULE_NAME' }
end
```

**Ensure that the state is `ENABLED` or `DISABLED`.**

```ruby
describe aws_eventbridge_rule(name: 'RULE_NAME') do
    its('state') { should eq 'ENABLED' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_eventbridge_rule(name: 'test_rule') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_eventbridge_rule(name: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_eventbridge_rule(name: 'test_rule') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EventBridge:Client:DescribeRuleResponse" %}}
