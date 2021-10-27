---
title: About the aws_servicecatalog_cloud_formation_product Resource
platform: aws
---

# aws\_servicecatalog\_cloud\_formation\_product

Use the `aws_servicecatalog_cloud_formation_product` InSpec audit resource to test properties of a single AWS Service Catalog CloudFormation product.

## Syntax

Ensure that a product exists.

    describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
      it { should exist }
    end

## Parameters

`name` _(required)_

The name of the product. 

For additional information, see the [AWS documentation on AWS Service Catalog CloudFormation product](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-cloudformationproduct.html).

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
| support_email | The email contact information to obtain support for this product. |
| support_description | The description of the support for this product. |
| support_url | The URL information to obtain support for this product. |

## Examples

### Ensure a product name is available.

    describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
      its('name') { should eq 'PRODUCT_NAME' }
    end

### Ensure a owner is available.

    describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
        its('owner') { should eq 'PRODUCT_OWNER' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ServiceCatalog:Client:DescribeProductAsAdminOutput` action with `Effect` set to `Allow`.