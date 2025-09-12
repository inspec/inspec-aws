+++
title = "aws_network_firewall_rule_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_network_firewall_rule_groups"
identifier = "inspec/resources/aws/aws_network_firewall_rule_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_network_firewall_rule_groups` InSpec audit resource to test properties of multiple AWS Network Firewall rule groups.

The `AWS::NetworkFirewall::RuleGroup` resource defines a reusable collection of stateless or stateful network traffic filtering rules.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Network Firewall Rule Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html).

## Syntax

Ensure that the rule group exists.

```ruby
describe aws_network_firewall_rule_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The descriptive name of the rule group.

: **Field**: `name`

`arns`
: The Amazon Resource Name (ARN) of the rule group.

: **Field**: `arn`

## Examples

**Ensure a name is available.**

```ruby
describe aws_network_firewall_rule_groups do
  its('names') { should include 'RULE_GROUP_NaAME' }
end
```

**Ensure that the arn is available.**

```ruby
describe aws_network_firewall_rule_groups do
    its('arns') { should include 'ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_network_firewall_rule_groups do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_network_firewall_rule_groups do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="NetworkFirewall:Client:ListRuleGroupsResponse" %}}
