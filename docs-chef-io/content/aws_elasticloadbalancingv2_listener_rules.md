+++
title = "aws_elasticloadbalancingv2_listener_rules resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticloadbalancingv2_listener_rules"
identifier = "inspec/resources/aws/aws_elasticloadbalancingv2_listener_rules resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticloadbalancingv2_listener_rules` InSpec audit resource to test properties of multiple listener rules associated with an Application Load Balancer.

Each rule consists of a priority, one or more actions, and one or more conditions.

For additional information, including details on parameters and properties, see the [AWS documentation on ELBv2 Listener Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listenerrule.html).

## Syntax

Ensure that a listener ARN exists.

```ruby
describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

## Parameters

`listener_arn`  _(required)_

: The ARN of the listener.

## Properties

`rule_arns`
: The Amazon Resource Name (ARN) of the rule.

: **Field**: `rule_arns`

`priorities`
: The rule priority.

: **Field**: `priorities`

`conditions`
: The conditions for listener rules. Each rule can include zero or one of the following conditions: `http-request-method` , `host-header` , `path-pattern` , and `source-ip`, and zero or more of the following conditions: `http-header` and `query-string`.

: **Field**: `conditions`

`actions`
: The actions for listener rules. Each rule includes exactly one of the following types of actions: `forward`, `redirect`, or `fixed-response`.

: **Field**: `actions`

`is_defaults`
: Indicates whether this is the default rule.

: **Field**: `is_defaults`

## Examples

**Ensure a listener ARN is available.**

```ruby
describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
  its('rule_arns') { should include 'RULE_ARN' }
end
```

**Verify the priority of the desired rule ARN.**

```ruby
describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
    its('priorities') { should include 1 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_elasticloadbalancingv2_listener_rules(listener_arn: 'LISTENER_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElasticLoadBalancingV2:Client:DescribeRulesOutput" %}}
