+++
title = "aws_db_parameter_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_db_parameter_group"
identifier = "inspec/resources/aws/aws_db_parameter_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_db_parameter_group` InSpec audit resource to test properties of an AWS DB parameter group.

#### db_parameter_group_name _(required)_

This resource accepts a single parameter, the DB parameter group name. This can be passed either as a string or as a `aws_db_parameter_group: 'value'` key-value entry in a hash.

For additional information, including details on parameters and properties, see the [AWS documentation on DB parameter groups](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_db_parameter_group` resource block uses the parameter to select a parameter group.

```ruby
describe aws_db_parameter_group(db_parameter_group_name: 'parameter-group-name-12345') do
  it { should exist }
end
```

## Parameters

`db_parameter_group_name` _(required)_

: This resource accepts a single parameter, the DB parameter group name. This can be passed either as a string or as a `aws_db_parameter_group: 'value'` key-value entry in a hash.

## Properties

`db_parameter_group_name`
: The name of the DB parameter group.

`db_parameter_group_family`
: The name of the DB parameter group family that this DB parameter group is compatible with.

`description`
: The customer-specified description for this DB parameter group.

`db_parameter_group_arn`
: The Amazon Resource Name (ARN) for the DB parameter group.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBParameterGroup.html)

## Examples

**Verify the group name of a DB parameter group.**

```ruby
describe aws_db_parameter_group(db_parameter_group_name: 'parameter-group-name-12345') do
  its('db_parameter_group_name')  { should eq 'parameter-group-name-12345' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_db_parameter_group(db_parameter_group_name: 'parameter-group-name-12345') do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_db_parameter_group(db_parameter_group_name: 'parameter-group-name-6789') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBParameterGroupsMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
