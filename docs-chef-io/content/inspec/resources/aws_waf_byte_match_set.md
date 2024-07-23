+++
title = "aws_waf_byte_match_set resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_waf_byte_match_set"
identifier = "inspec/resources/aws/aws_waf_byte_match_set resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_byte_match_set` Chef InSpec audit resource to test the properties of a single AWS (Web Application Firewall) WAF byte match set.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAF::ByteMatchSet` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-bytematchset.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a byte match set exists.

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
  it { should exist }
end
```

## Parameters

`aws_waf_byte_match_set` _(required)_

: The unique identifier for the byte match set.

## Properties

`byte_match_set_id`
: The unique identifier for the byte match set.

`name`
: The name of the byte match set.

`byte_match_tuples`
: Specifies the bytes (typically a string that corresponds with ASCII characters) that you want AWS WAF to search for in web requests, the location in requests that you want AWS WAF to search, and other settings.

`byte_match_tuples_field_to_matches`
: The part of a web request that you want AWS WAF to search, such as a specified header or a query string.

`byte_match_tuples_field_to_match_types`
: The part of the web request that you want AWS WAF to search for a specified string.

`byte_match_tuples_field_to_match_data`
: When the value of Type is HEADER , enter the name of the header that you want AWS WAF to search, for example, User-Agent or Referer.

`byte_match_tuples_target_strings`
: The value that you want AWS WAF to search for.

`byte_match_tuples_text_transformations`
: Text transformations eliminate some of the unusual formatting that attackers use in web requests in an effort to bypass AWS WAF.

`byte_match_tuples_positional_constraints`
: Within the portion of a web request that you want to search (for example, in the query string, if any), specify where you want AWS WAF to search.

## Examples

**Ensure a byte match set is available.**

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
  its('byte_match_set_id') { should eq 'BYTE_MATCH_SET_ID' }
end
```

**Ensure a byte match set name is available.**

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
    its('name') { should eq 'BYTE_MATCH_SET_NAME' }
end
```

**Ensure a byte match set type is `REGULAR`.**

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
    its('byte_match_tuples_positional_constraints') { should include 'REGULAR' }
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers.

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_byte_match_set(byte_match_set_id: 'BYTE_MATCH_SET_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:GetByteMatchSetResponse" %}}
