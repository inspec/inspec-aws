---
title: About the aws_waf_size_constraint_set resource
platform: aws
---

# aws_waf_size_constraint_set

Use the `aws_waf_size_constraint_set` Chef InSpec audit resource to test the properties of a single AWS Web Application Firewall (WAF) size constraint set.

A complex type that contains SizeConstraint objects, which specify the parts of web requests that you want AWS WAF to inspect the size of. If a SizeConstraintSet contains more than one SizeConstraint object, a request only needs to match one constraint to be considered a match.

## Syntax

Ensure that a size constraint set exists.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
      it { should exist }
    end

## Parameters

`size_constraint_set_id` _(required)_

A unique identifier for a size constrain set.

For additional information, see the [AWS documentation on `AWS::WAF::SizeConstraintSet` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html).

## Properties

| Property | Description |
| :---: | :--- |
| size_constraint_set_id | A unique identifier for a size constrain set. |
| name | The name of the size constrain set. |
| size_constraints | Specifies the parts of web requests that you want to inspect for cross-site scripting attacks. |
| size_constraints_field_to_match_types | The part of the web request that you want AWS WAF to search for a specified string. |
| size_constraints_field_to_match_data | When the value of Type is `HEADER`, enter the name of the header that you want AWS WAF to search, for example, User-Agent or Referer. |
| size_constraints_text_transformations | Text transformations eliminate some of the unusual formatting that attackers use in web requests in an effort to bypass AWS WAF. |
| size_constraints_comparison_operators | The type of comparison you want AWS WAF to perform. AWS WAF uses this in combination with the provided Size and FieldToMatch to build an expression in the form of "Size ComparisonOperator size in bytes of FieldToMatch". |
| size_constraints_sizes | The size in bytes that you want AWS WAF to compare against the size of the specified FieldToMatch. |

## Examples

### Ensure a size constraint set is available.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
      its('size_constraint_set_id') { should eq 'SIZE_CONSTRAINT_SET_ID' }
    end

### Ensure a size constraint set name is available.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
        its('name') { should eq 'SIZE_CONSTRAINT_SET_NAME' }
    end

### Ensure an a size constraint set type is `HEADER`.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
        its('size_constraints_field_to_match_types') { should include 'HEADER' }
    end

### Verify the size of the constraint set.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
        its('size_constraints_sizes') { should include '5' }
    end

## Matchers

This Chef InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_waf_size_constraint_set(size_constraint_set_id: 'SIZE_CONSTRAINT_SET_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:GetSizeConstraintSetResponse` action with `Effect` set to `Allow`.
