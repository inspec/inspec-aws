---
title: About the aws_servicecatalog_launch_role_constraints Resource
platform: aws
---

# aws\_servicecatalog\_launch\_role\_constraints

Use the `aws_servicecatalog_launch_role_constraints` InSpec audit resource to test properties of multiple AWS Service Catalog launch constraint.

## Syntax

Ensure that a portfolio exists.

    describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'PORTFOLIO_ID') do
      it { should exist }
    end

## Parameters

`portfolio_id` _(required)_

The identifier of the portfolio the product resides in.

For additional information, see the [AWS documentation on AWS ServiceCatalog LaunchRoleConstraint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-launchroleconstraint.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| constraint_ids | The identifier of the constraint. |
| types | The type of constraint. Valid values are: `LAUNCH`, `NOTIFICATION`, `RESOURCE_UPDATE`, `STACKSET`, and `TEMPLATE`. |
| descriptions | The description of the constraint. |
| owners | The owner of the constraint. |
| product_ids | The identifier of the product the constraint applies to. Note that a constraint applies to a specific instance of a product within a certain portfolio. |
| portfolio_ids | The identifier of the portfolio the product resides in. The constraint applies only to the instance of the product that lives within this portfolio. |

## Examples

### Ensure a constraint is available.

    describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'PORTFOLIO_ID') do
      its('constraint_ids') { should include 'ID' }
    end

### Ensure that the type is 'LAUNCH'.

    describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'PORTFOLIO_ID') do
        its('types') { should include 'LAUNCH' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'PORTFOLIO_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_launch_role_constraints(portfolio_id: 'PORTFOLIO_ID') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ServiceCatalog:Client:ListConstraintsForPortfolioOutput` action with `Effect` set to `Allow`.
