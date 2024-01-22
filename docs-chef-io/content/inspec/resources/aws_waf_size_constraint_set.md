+++
title = "aws_waf_size_constraint_set resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_waf_size_constraint_set"
identifier = "inspec/resources/aws/aws_waf_size_constraint_set resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_size_constraint_set` Chef InSpec audit resource to test the properties of a single AWS Web Application Firewall (WAF) size constraint set.

For additional information, including details on parameters and properties, see the [AWS documentation on `AWS::WAF::SizeConstraintSet` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a size constraint set exists.

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
  it { should exist }
end
```

## Parameters

`size_constraint_set_id` _(required)_

: A unique identifier for a size constrain set.

## Properties

`size_constraint_set_id`
: A unique identifier for a size constrain set.

`name`
: The name of the size constrain set.

`size_constraints`
: Specifies the parts of web requests that you want to inspect for cross-site scripting attacks.

`size_constraints_field_to_match_types`
: The part of the web request that you want AWS WAF to search for a specified string.

`size_constraints_field_to_match_data`
: When the value of Type is `HEADER`, enter the name of the header that you want AWS WAF to search, for example, User-Agent or Referer.

`size_constraints_text_transformations`
: Text transformations eliminate some of the unusual formatting that attackers use in web requests in an effort to bypass AWS WAF.

`size_constraints_comparison_operators`
: The type of comparison you want AWS WAF to perform. AWS WAF uses this in combination with the provided Size and FieldToMatch to build an expression in the form of "Size ComparisonOperator size in bytes of FieldToMatch".

`size_constraints_sizes`
: The size in bytes that you want AWS WAF to compare against the size of the specified FieldToMatch.

## Examples

**Ensure a size constraint set is available.**

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
  its('size_constraint_set_id') { should eq 'SIZE_CONSTRAINT_SET_ID' }
end
```

**Ensure a size constraint set name is available.**

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
    its('name') { should eq 'SIZE_CONSTRAINT_SET_NAME' }
end
```

**Ensure an a size constraint set type is `HEADER`.**

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
    its('size_constraints_field_to_match_types') { should include 'HEADER' }
end
```

**Verify the size of the constraint set.**

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
    its('size_constraints_sizes') { should include '5' }
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers.

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:GetSizeConstraintSetResponse" %}}
