---
title: About the aws_servicecatalog_portfolio_principal_association Resource
platform: aws
---

# aws\_servicecatalog\_portfolio\_principal\_association

Use the `aws_servicecatalog_portfolio_principal_association` InSpec audit resource to test properties of a single specific AWS Service Catalog Portfolio Principal Association.

The AWS::ServiceCatalog::PortfolioPrincipalAssociation resource associates the specified principal ARN with the specified portfolio.

## Syntax

Ensure that a portfolio is available.

    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'portfolio_id') do
      it { should exist }
    end

## Parameters

`portfolio_id` _(required)_

For additional information, see the [AWS documentation on AWS Service Catalog Portfolio Principal Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioprincipalassociation.html).

## Properties

| Property | Description|
| --- | --- |
| principal_arn | The ARN of the principal (IAM user, role, or group). |
| principal_type | The principal type. The supported value is IAM. |

## Examples

### Ensure a principal arn is available.
    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'portfolio_id') do
      its('principal_arn') { should eq 'principal_arn' }
    end

### Ensure a principal type is 'IAM'
    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'portfolio_id') do
        its('principal_type') { should eq 'IAM' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'portfolio_id') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_servicecatalog_portfolio_principal_association(portfolio_id: 'portfolio_id') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `servicecatalog:client:ListPrincipalsForPortfolio` action with `Effect` set to `Allow`.