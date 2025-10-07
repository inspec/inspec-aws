+++
title = "aws_rds_db_security_groups resource"

draft = false


[menu.aws]
title = "aws_rds_db_security_groups"
identifier = "inspec/resources/aws/aws_rds_db_security_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_security_groups` InSpec audit resource to test properties of multiple Amazon Relational Database Service (RDS) database security groups.

## Syntax

Ensure that the DB security group exists.

```ruby
describe aws_rds_db_security_groups do
  it { should exist }
end
```

For additional information, see the [AWS documentation on the `AWS::RDS::DBSecurityGroup` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-security-group.html).

## Properties

`owner_ids`
: Provides the Amazon Web Services ID of the owner of a specific DB security group.

: **Field**: `owner_id`

`db_security_group_names`
: The name of the DB security group to return details for.

: **Field**: `db_security_group_name`

`db_security_group_descriptions`
: Provides the description of the DB security group.

: **Field**: `db_security_group_description`

`vpc_ids`
: Provides the VpcId of the DB security group.

: **Field**: `vpc_id`

`db_security_group_arns`
: The Amazon Resource Name (ARN) for the DB security group.

: **Field**: `db_security_group_arn`

## Examples

Ensure a DB security group name is available:

```ruby
describe aws_rds_db_security_groups do
  its('db_security group_names') { should include 'DB_SECURITY_GROUP_NAME' }
end
```

Ensure a DB security group ARN is available:

```ruby
describe aws_rds_db_security_groups do
  its('db_security_group_arns') { should include 'DB_SECURITY_GROUP_ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_security_groups do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_security_groups do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_security_groups do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBSecurityGroup" %}}
