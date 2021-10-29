---
title: About the aws_servicecatalog_portfolio_principal_associations Resource
platform: aws
---

# aws\_servicecatalog\_portfolio\_principal\_associations

Use the `aws_servicecatalog_portfolio_principal_associations` InSpec audit resource to test properties of a single specific AWS Service Catalog portfolio principal association.

## Syntax

Ensure that portfolio are available.

    describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
      it { should exist }
    end

## Parameters

`portfolio_id` _(required)_

The ID of the portfolio.

For additional information, see the [AWS documentation on AWS Service Catalog Portfolio Principal Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioprincipalassociation.html).

## Properties

| Property | Description|
| --- | --- |
| principal_arns | The ARN of the principal (IAM user, role, or group). |
| principal_types | The principal type. The supported value is `IAM`. |

## Examples

### Ensure a principal ARN is available.

    describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
      its('principal_arns') { should include 'PRINCIPAL_ARN' }
    end

### Ensure a principal type is 'IAM'

    describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
        its('principal_types') { should include 'IAM' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ServiceCatalog:Client:ListPrincipalsForPortfolioOutput` action with `Effect` set to `Allow`.