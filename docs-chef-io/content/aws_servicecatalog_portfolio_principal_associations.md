+++
title = "aws_servicecatalog_portfolio_principal_associations resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_servicecatalog_portfolio_principal_associations"
identifier = "inspec/resources/aws/aws_servicecatalog_portfolio_principal_associations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_servicecatalog_portfolio_principal_associations` InSpec audit resource to test properties of a single specific AWS Service Catalog portfolio principal association.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Service Catalog Portfolio Principal Association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-portfolioprincipalassociation.html).

## Syntax

Ensure that portfolio are available.

```ruby
describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
  it { should exist }
end
```

## Parameters

`portfolio_id` _(required)_

: The ID of the portfolio.

## Properties

`principal_arns`
: The ARN of the principal (IAM user, role, or group).

`principal_types`
: The principal type. The supported value is `IAM`.

## Examples

Ensure a principal ARN is available:

```ruby
describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
  its('principal_arns') { should include 'PRINCIPAL_ARN' }
end
```

Ensure a principal type is 'IAM':

```ruby
describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
    its('principal_types') { should include 'IAM' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_servicecatalog_portfolio_principal_associations(portfolio_id: 'PORTFOLIO_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ServiceCatalog:Client:ListPrincipalsForPortfolioOutput" %}}
