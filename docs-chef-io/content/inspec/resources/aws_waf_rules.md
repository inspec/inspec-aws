+++
title = "aws_waf_rules resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_waf_rules"
identifier = "inspec/resources/aws/aws_waf_rules resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_rules` Chef InSpec audit resource to test the properties of multiple AWS WAF (web application firewall) rules.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAF::Rule` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-rule.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that a WAF rule exists.

```ruby
describe aws_waf_rules do
  it { should exist }
end
```

## Parameters

No required parameters.

## Properties

`rule_ids`
: The unique identifier for the rule.

: **Field**: `rule_id`

`names`
: A friendly name or description of the rule.

: **Field**: `name`

## Examples

**Ensure a rule is available by rule ID.**

```ruby
describe aws_waf_rules do
  its('rule_ids') { should include 'RULE_ID' }
end
```

**Ensure a rule is available by name.**

```ruby
describe aws_waf_rules do
    its('names') { should include 'RULE_NAMES' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_rules do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_rules do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_rules do
  it { should be_available }
end
```

## AWS Permissions

{{% aws_permissions_principal action="WAF:Client:ListRulesResponse" %}}
