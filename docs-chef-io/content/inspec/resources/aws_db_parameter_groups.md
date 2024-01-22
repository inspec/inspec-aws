+++
title = "aws_db_parameter_groups Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_db_parameter_groups"
identifier = "inspec/resources/aws/aws_db_parameter_groups Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_db_parameter_groups` InSpec audit resource to test properties of a collection of AWS DB parameter groups.

This resource does not expect any parameters.

For additional information, including details on parameters and properties, see the [AWS documentation on DB parameter groups](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure you have exactly three DB parameter groups:

```ruby
describe aws_db_parameter_groups do
  its('db_parameter_group_names.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`db_parameter_group_names`
: The name of the DB parameter group.

`db_parameter_group_families`
: The name of the DB parameter group family that this DB parameter group is compatible with.

`descriptions`
: Provides the customer-specified description for this DB parameter group.

`db_parameter_group_arns`
: The Amazon Resource Name (ARN) for the DB parameter group.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBParameterGroup.html)

## Examples

**Ensure the group name of a DB parameter group exists.**

```ruby
describe aws_db_parameter_groups do
  its('db_parameter_group_names') { should include 'parameter-group-name' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe method returns at least one result.

```ruby
describe aws_db_parameter_groups.where( <property>: <value> ) do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_db_parameter_groups.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBParameterGroupsMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
