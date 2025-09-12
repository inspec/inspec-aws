+++
title = "aws_waf_xss_match_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_waf_xss_match_sets"
identifier = "inspec/resources/aws/aws_waf_xss_match_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_xss_match_sets` InSpec audit resource to test the properties of multiple AWS WAF `XssMatchSet` objects.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAF::XssMatchSet` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-xssmatchset.html).

## Syntax

Ensure that any `XssMatchSet` object exists.

```ruby
describe aws_waf_xss_match_sets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`xss_match_set_ids`
: A unique identifier for an `XssMatchSet`.

: **Field**: `xss_match_set_id`

`names`
: The name of the `XssMatchSet`.

: **Field**: `name`

## Examples

**Verify an `XssMatchSet` object is available by ID.**

```ruby
describe aws_waf_xss_match_sets do
  its('xss_match_set_ids') { should include 'XSS_MATCH_SET_ID' }
end
```

**Verify an `XssMatchSet` object name is available.**

```ruby
describe aws_waf_xss_match_sets do
    its('names') { should include 'XSS_MATCH_SET_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_xss_match_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_xss_match_sets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListXssMatchSetsResponse" %}}
