---
title: About the aws_waf_size_constraint_sets resource
platform: aws
---

# aws_waf_size_constraint_sets

Use the `aws_waf_size_constraint_sets` Chef InSpec audit resource to test the properties of multiple AWS Web Application Firewall (WAF) size constraint sets.

## Syntax

Ensure that a size constraint set exists.

    describe aws_waf_size_constraint_sets do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

For additional information, see the [AWS documentation on AWS WAF SizeConstraintSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-waf-sizeconstraintset.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| size_constraint_set_ids | A unique identifier for a size constraint set. | size_constraint_set_id |
| names | The name of the size constraint set. | name |

## Examples

### Ensure a size constraint set is available.

    describe aws_waf_size_constraint_sets do
      its('size_constraint_set_ids') { should include 'SIZE_CONSTRAINT_SET_ID' }
    end

### Ensure a size constraint set name is available.

    describe aws_waf_size_constraint_sets do
        its('names') { should include 'SIZE_CONSTRAINT_SET_NAME' }
    end

## Matchers

This Chef InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

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
