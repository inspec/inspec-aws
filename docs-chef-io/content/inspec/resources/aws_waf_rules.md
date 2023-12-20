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

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

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

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

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

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListRulesResponse" %}}
