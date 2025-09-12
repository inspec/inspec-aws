+++
title = "aws_servicecatalog_cloud_formation_product resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_servicecatalog_cloud_formation_product"
identifier = "inspec/resources/aws/aws_servicecatalog_cloud_formation_product resource"
parent = "inspec/resources/aws"
+++

Use the `aws_servicecatalog_cloud_formation_product` InSpec audit resource to test properties of a single AWS Service Catalog CloudFormation product.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Service Catalog CloudFormation product](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-cloudformationproduct.html).

## Syntax

Ensure that a product exists.

```ruby
describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
  it { should exist }
end
```

## Parameters

`name` _(required)_

: The name of the product.

## Properties

`id`
: The product view identifier.

`product_id`
: The product identifier.

`name`
: The name of the product.

`owner`
: The owner of the product.

`short_description`
: Short description of the product.

`type`
: The product type.

`distributor`
: The distributor of the product.

`has_default_path`
: Indicates whether the product has a default path.

`support_email`
: The email contact information to obtain support for this product.

`support_description`
: The description of the support for this product.

`support_url`
: The URL information to obtain support for this product.

## Examples

Ensure a product name is available:

```ruby
describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
  its('name') { should eq 'PRODUCT_NAME' }
end
```

Ensure a owner is available:

```ruby
describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
    its('owner') { should eq 'PRODUCT_OWNER' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_servicecatalog_cloud_formation_product(name: 'PRODUCT_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ServiceCatalog:Client:DescribeProductAsAdminOutput" %}}
