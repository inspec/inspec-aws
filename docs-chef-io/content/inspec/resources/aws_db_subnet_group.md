+++
title = "aws_db_subnet_group Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_db_subnet_group"
identifier = "inspec/resources/aws/aws_db_subnet_group Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_db_subnet_group` InSpec audit resource to test properties of a db subnet group.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 An `aws_db_subnet_group` resource block uses the parameter to select a subnet group.

```ruby
describe aws_db_subnet_group(db_subnet_group_name: 'subnet-group-name-12345') do
  it { should exist }
end
```


## Parameters

`db_subnet_group_name` _(required)_

: This resource accepts a single parameter, the DB Subnet Group Name.
  This can be passed either as a string or as a `aws_db_subnet_group: 'value'` key-value entry in a hash.

See the [AWS documentation on DB Subnet Groups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets).


## Properties

`db_subnet_group_name`
: The name of the DB subnet group.

`db_subnet_group_description`
: Provides the description of the DB subnet group.

`vpc_id`
: Provides the VPC ID of the DB subnet group.

`subnet_group_status`
: Provides the status of the DB subnet group.

`subnets`
: Contains a list of Subnet elements.

`db_subnet_group_arn`
: The Amazon Resource Name for the DB subnet group.

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBSubnetGroup.html)

## Examples

**Check DB Subnet Group Name of a subnet group.**

```ruby
describe aws_db_subnet_group(db_subnet_group_name: 'subnet-group-name-12345') do
  its('db_subnet_group_name')  { should eq 'subnet-group-name-12345' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_db_subnet_group(db_subnet_group_name: 'subnet-group-name-12345') do
  it { should exist }
end
```

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'subnet-group-name-6789') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBSubnetGroupMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).