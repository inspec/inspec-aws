+++
title = "aws_servicecatalog_launch_role_constraint resource"

draft = false


[menu.aws]
title = "aws_servicecatalog_launch_role_constraint"
identifier = "inspec/resources/aws/aws_servicecatalog_launch_role_constraint resource"
parent = "inspec/resources/aws"
+++

Use the `aws_servicecatalog_launch_role_constraint` InSpec audit resource to test properties of a single specific AWS Service Catalog launch constraint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Service Catalog launch role constraint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalog-launchroleconstraint.html).

## Syntax

Ensure that a constraint exists.

```ruby
describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
  it { should exist }
end
```

## Parameters

`id` _(required)_

: The identifier of the constraint.

## Properties

`constraint_detail (constraint_id)`
: The identifier of the constraint.

`constraint_detail (type)`
: The type of constraint. Valid values are: `LAUNCH`, `NOTIFICATION`, `RESOURCE_UPDATE`, `STACKSET`, and `TEMPLATE`.

`constraint_detail (description)`
: The description of the constraint.

`constraint_detail (owner)`
: The owner of the constraint.

`constraint_detail (product_id)`
: The identifier of the product the constraint applies to. Note that a constraint applies to a specific instance of a product within a certain portfolio.

`constraint_detail (portfolio_id)`
: The identifier of the portfolio the product resides in. The constraint applies only to the instance of the product that lives within this portfolio.

`constraint_parameters`
: The constraint parameters.

`status`
: The status of the current request. Valid values are: `AVAILABLE`, `CREATING`, and `FAILED`.

## Examples

Ensure a product name is available:

```ruby
describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
  its('constraint_detail.constraint_id') { should eq 'ID' }
end
```

Ensure a status is available:

```ruby
describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
    its('status') { should eq 'AVAILABLE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_servicecatalog_launch_role_constraint(id: 'CONSTRAINT_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ServiceCatalog:Client:DescribeConstraintOutput" %}}
