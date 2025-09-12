+++
title = "aws_waf_byte_match_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_waf_byte_match_sets"
identifier = "inspec/resources/aws/aws_waf_byte_match_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_byte_match_sets` Chef InSpec audit resource to test the properties of multiple AWS (Web Application Firewall) WAF byte match sets.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::WAF::ByteMatchSet` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-bytematchset.html).

## Syntax

### Ensure that a byte match set exists

```ruby
describe aws_waf_byte_match_sets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`byte_match_set_ids`
: The unique identifier for the ByteMatchSet.

: **Field**: `byte_match_set_id`

`names`
: The name of the ByteMatchSet.

: **Field**: `name`

## Examples

Ensure a byte match set is available:

```ruby
describe aws_waf_byte_match_sets do
  its('byte_match_set_ids') { should include 'BYTE_MATCH_SET_ID' }
end
```

Ensure a byte match set name is available:

```ruby
describe aws_waf_byte_match_sets do
    its('names') { should include 'BYTE_MATCH_SET_NAME' }
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers.

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_byte_match_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_byte_match_sets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListByteMatchSetsResponse" %}}
