---
title: About the aws_waf_size_constraint_set resource
platform: aws
---

# aws_waf_size_constraint_sets

Use the `aws_waf_size_constraint_sets` InSpec audit resource to test the properties of the plural resource of AWS WAF SizeConstraintSet.

## Syntax

Ensure that size constraint set exists.

    describe aws_waf_size_constraint_sets do
      it { should exist }
    end

## Parameters

No required parameters.

For additional information, see the [AWS documentation on AWS WAF SizeConstraintSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| size_constraint_set_ids | A unique identifier for a SizeConstraintSet. | size_constraint_set_id |
| names | The name of the SizeConstraintSet. | name |

## Examples

### Ensure a size constraint set is available.

    describe aws_waf_size_constraint_sets do
      its('size_constraint_set_ids') { should include 'SIZE_CONSTRAINT_SET_ID' }
    end

### Ensure a size constraint set name is available..

    describe aws_waf_size_constraint_sets do
        its('names') { should include 'SIZE_CONSTRAINT_SET_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_waf_size_constraint_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_waf_size_constraint_sets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `WAF:Client:ListSizeConstraintSetsResponse` action with `Effect` set to `Allow`.