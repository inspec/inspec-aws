+++
title = "aws_waf_rule resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_waf_rule"
identifier = "inspec/resources/aws/aws_waf_rule resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_rule` Chef InSpec audit resource to test the properties of a single AWS WAF (web application firewall) rule.

The `AWS::WAF::Rule` resource type creates a firewall rule that identifies the web requests that you want to allow, block, or count.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAF::Rule` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-rule.html).

## Syntax

Ensure that a WAF rule exists.

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
  it { should exist }
end
```

## Parameters

`rule_id` _(required)_

: A unique identifier for a WAF rule.

## Properties

`rule_id`
: A unique identifier for a rule.

`name`
: The name of the rule.

`metric_name`
: The name of the metrics for this rule.

`predicates_negated`
: `False` if the AWS WAF rule will allow, block, or count requests based on the settings in the specified `ByteMatchSet`, `IPSet`, `SqlInjectionMatchSet`, `XssMatchSet`, `RegexMatchSet`, `GeoMatchSet`, or `SizeConstraintSet` object.

`predicates_type`
: The type of predicate in a rule, such as `ByteMatch` or `IPSet`.

`predicates_data_id`
: A unique identifier for a predicate in a rule, such as `ByteMatchSetId` or `IPSetId`.

## Examples

**Ensure a rule is available.**

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
  its('rule_id') { should eq 'RULE_ID' }
end
```

**Ensure a rule name is available.**

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
    its('name') { should eq 'RULE_ID_NAME' }
end
```

**Ensure a metric name type is `METRIC_NAME`.**

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
    its('metric_name') { should include 'METRIC_NAME' }
end
```

**Verify the type of data ID should be 'DATA_ID'.**

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
    its('predicates_data_id') { should include 'DATA_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_rule(rule_id: 'RULE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:GetRuleResponse" %}}
