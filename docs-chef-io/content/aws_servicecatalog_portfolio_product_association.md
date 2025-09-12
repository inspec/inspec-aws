+++
title = "aws_servicecatalog_portfolio_product_association resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_servicecatalog_portfolio_product_association"
identifier = "inspec/resources/aws/aws_servicecatalog_portfolio_product_association resource"
parent = "inspec/resources/aws"
+++

Use the `aws_servicecatalog_portfolio_product_association` InSpec audit resource to test properties of a single specific AWS Service Catalog portfolio product association.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Service Catalog Portfolio Product Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioproductassociation.html).

## Syntax

Ensure that a portfolio exists.

```ruby
describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
  it { should exist }
end
```

## Parameters

`product_id` _(required)_

: The product identifier.

## Properties

`id`
: The portfolio identifier.

`arn`
: The ARN assigned to the portfolio.

`display_name`
: The name to use for display purposes.

`description`
: The description of the portfolio.

`created_time`
: The UTC time stamp of the creation time.

`provider_name`
: The name of the portfolio provider.

## Examples

**Ensure a product name is available.**

```ruby
describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
  its('id') { should eq 'PORTFOLIO_ID' }
end
```

**Ensure a status is available.**

```ruby
describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
    its('provider_name') { should eq 'PORTFOLIO_PROVIDER_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_servicecatalog_portfolio_product_association(product_id: 'PRODUCT_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ServiceCatalog:Client:ListPortfoliosForProductOutput" %}}
