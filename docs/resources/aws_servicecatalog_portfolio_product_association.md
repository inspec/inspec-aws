---
title: About the aws_servicecatalog_portfolio_product_association Resource
platform: aws
---

# aws\_servicecatalog\_portfolio\_product\_association

Use the `aws_servicecatalog_portfolio_product_association` InSpec audit resource to test properties of a single specific AWS Service Catalog portfolio product association.

## Syntax

Ensure that a portfolio exists.

    describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
      it { should exist }
    end

## Parameters

`product_id` _(required)_

The product identifier.

For additional information, see the [AWS documentation on AWS Service Catalog Portfolio Product Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioproductassociation.html).

## Properties

| Property | Description|
| --- | --- |
| id | The portfolio identifier. |
| arn | The ARN assigned to the portfolio. |
| display_name | The name to use for display purposes. |
| description | The description of the portfolio. |
| created_time | The UTC time stamp of the creation time. |
| provider_name | The name of the portfolio provider. |

## Examples

### Ensure a product name is available.

    describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
      its('id') { should eq 'PORTFOLIO_ID' }
    end

### Ensure a status is available

    describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
        its('provider_name') { should eq 'PORTFOLIO_PROVIDER_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ServiceCatalog:Client:ListPortfoliosForProductOutput` action with `Effect` set to `Allow`.
