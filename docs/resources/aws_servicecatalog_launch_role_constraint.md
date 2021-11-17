---
title: About the aws_servicecatalog_launch_role_constraint Resource
platform: aws
---

# aws\_servicecatalog\_launch\_role\_constraint

Use the `aws_servicecatalog_launch_role_constraint` InSpec audit resource to test properties of a single specific AWS Service Catalog launch constraint.

## Syntax

Ensure that a constraint exists.

    describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
      it { should exist }
    end

## Parameters

`id` _(required)_

The identifier of the constraint.

For additional information, see the [AWS documentation on AWS Service Catalog launch role constraint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-launchroleconstraint.html).

## Properties

| Property | Description|
| --- | --- |
| constraint_detail (constraint_id) | The identifier of the constraint. |
| constraint_detail (type) | The type of constraint. Valid values are: `LAUNCH`, `NOTIFICATION`, `RESOURCE_UPDATE`, `STACKSET`, and `TEMPLATE`. |
| constraint_detail (description) | The description of the constraint. |
| constraint_detail (owner) | The owner of the constraint. |
| constraint_detail (product_id) | The identifier of the product the constraint applies to. Note that a constraint applies to a specific instance of a product within a certain portfolio. |
| constraint_detail (portfolio_id) | The identifier of the portfolio the product resides in. The constraint applies only to the instance of the product that lives within this portfolio. |
| constraint_parameters | The constraint parameters. |
| status | The status of the current request. Valid values are: `AVAILABLE`, `CREATING`, and `FAILED`. |

## Examples

### Ensure a product name is available.

    describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
      its('constraint_detail.constraint_id') { should eq 'ID' }
    end

### Ensure a status is available.

    describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
        its('status') { should eq 'AVAILABLE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ServiceCatalog:Client:DescribeConstraintOutput` action with `Effect` set to `Allow`.
