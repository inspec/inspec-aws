+++
title = "aws_db_subnet_groups Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_db_subnet_groups"
identifier = "inspec/resources/aws/aws_db_subnet_groups Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_db_subnet_groups` InSpec audit resource to test properties of a collection of AWS RDS subnet groups.

RDS gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

## Installation

{{% inspec_aws_install %}}

## Syntax

 Ensure you have exactly 3 subnet groups

```ruby
describe aws_db_subnet_groups do
  its('db_subnet_group_names.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`db_subnet_group_names`
: The name of the DB subnet group.

`db_subnet_group_descriptions`
: Provides the description of the DB subnet group.

`vpc_ids`
: Provides the VPC ID of the DB subnet group.

`subnet_group_status`
: Provides the status of the DB subnet group.

`subnets`
: Contains a list of Subnet elements.

`db_subnet_group_arns`
: The Amazon Resource Name for the DB subnet group.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBSubnetGroup.html)

## Examples

**Ensure DB Subnet Group Name of a subnet group exists.**

```ruby
describe aws_db_subnet_groups do
  its('db_subnet_group_names') { should include 'subnet-group-name' }
end
```

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_db_subnet_groups.where( <property>: <value> ) do
  it { should exist }
end
```

```ruby
describe aws_db_subnet_groups.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="RDS:Client:DBSubnetGroupMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).