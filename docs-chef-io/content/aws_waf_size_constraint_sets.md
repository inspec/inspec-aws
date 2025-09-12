+++
title = "aws_waf_size_constraint_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_waf_size_constraint_sets"
identifier = "inspec/resources/aws/aws_waf_size_constraint_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_waf_size_constraint_sets` Chef InSpec audit resource to test the properties of multiple AWS Web Application Firewall (WAF) size constraint sets.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS WAF SizeConstraintSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html).

## Syntax

Ensure that a size constraint set exists.

```ruby
describe aws_waf_size_constraint_sets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`size_constraint_set_ids`
: A unique identifier for a size constraint set.

: **Field**: `size_constraint_set_id`

`names`
: The name of the size constraint set.

: **Field**: `name`

## Examples

**Ensure a size constraint set is available.**

```ruby
describe aws_waf_size_constraint_sets do
  its('size_constraint_set_ids') { should include 'SIZE_CONSTRAINT_SET_ID' }
end
```

**Ensure a size constraint set name is available.**

```ruby
describe aws_waf_size_constraint_sets do
    its('names') { should include 'SIZE_CONSTRAINT_SET_NAME' }
end
```

## Matchers

This Chef InSpec audit resource has the following special matchers.

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_waf_size_constraint_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_waf_size_constraint_sets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="WAF:Client:ListSizeConstraintSetsResponse" %}}
