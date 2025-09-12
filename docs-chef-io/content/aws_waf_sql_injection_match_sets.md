+++
title = "aws_waf_sql_injection_match_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_waf_sql_injection_match_sets"
identifier = "inspec/resources/aws/aws_waf_sql_injection_match_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_sql_injection_match_sets` Chef InSpec audit resource to test the properties of multiple AWS WAF `SqlInjectionMatchSet` objects.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAF::SqlInjectionMatchSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sqlinjectionmatchset.html).

## Syntax

Ensure that a `SqlInjectionMatchSet` object exists.

```ruby
describe aws_waf_sql_injection_match_sets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`sql_injection_match_set_ids`
: A unique identifier for a `SqlInjectionMatchSet`.

: **Field**: `sql_injection_match_set_id`

`names`
: The name of the `SqlInjectionMatchSet`.

: **Field**: `name`

## Examples

**Ensure an injection match set is available.**

```ruby
describe aws_waf_sql_injection_match_sets do
  its('sql_injection_match_set_ids') { should include 'SQL_INJECTION_MATCH_SET_ID' }
end
```

**Ensure an injection match set is available.**

```ruby
describe aws_waf_sql_injection_match_sets do
    its('names') { should include 'SQL_INJECTION_MATCH_SET_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_sql_injection_match_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_sql_injection_match_sets do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_sql_injection_match_sets do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListSqlInjectionMatchSetsResponse" %}}
