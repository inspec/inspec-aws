---
title: About the aws_servicecatalog_cloud_formation_product Resource
platform: aws
---

# aws\_servicecatalog\_cloud\_formation\_product

Use the `aws_servicecatalog_cloud_formation_product` InSpec audit resource to test properties of a single specific AWS Service Catalog Cloud Formation Product.

The AWS::ServiceCatalog::CloudFormationProduct specifies a product.

## Syntax

Ensure that a product exists.

    describe aws_servicecatalog_cloud_formation_product(name: 'ProductViewName') do
      it { should exist }
    end

## Parameters

`name` _(required)_

For additional information, see the [AWS documentation on AWS Service Catalog Cloud Formation Product](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-cloudformationproduct.html).

## Properties

| Property | Description|
| --- | --- |
| id | The product view identifier. |
| product_id | The product identifier. |
| name | The name of the product. |
| owner | The owner of the product. |
| short_description | Short description of the product. |
| type | The product type. |
| distributor | The distributor of the product. |
| has_default_path | Indicates whether the product has a default path. |
| support_email | The email contact information to obtain support for this Product. |
| support_description | The description of the support for this Product. |
| support_url | The URL information to obtain support for this Product. |

## Examples

### Ensure a product name is available.
    describe aws_servicecatalog_cloud_formation_product(name: 'ProductViewName') do
      its('name') { should eq 'ProductViewName' }
    end

### Ensure a owner is available.
    describe aws_servicecatalog_cloud_formation_product(name: 'ProductViewName') do
        its('owner') { should eq 'TestUser' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_cloud_formation_product(name: 'ProductViewName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_cloud_formation_product(name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_servicecatalog_cloud_formation_product(name: 'ProductViewName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `servicecatalog:client:DescribeProductAsAdmin` action with `Effect` set to `Allow`.