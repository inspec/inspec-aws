+++
title = "aws_dms_replication_subnet_groups resource"

draft = false


[menu.aws]
title = "aws_dms_replication_subnet_groups"
identifier = "inspec/resources/aws/aws_dms_replication_subnet_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_dms_replication_subnet_groups` InSpec audit resource to test properties of multiple DMS replication instance subnet groups.

For additional information, including details on parameters and properties, see the [AWS documentation on DMS Replication Subnet Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html).

## Syntax

Ensure that a subnet group exists.

```ruby
describe aws_dms_replication_subnet_groups do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`replication_subnet_group_identifiers`
: The identifiers of the replication subnet groups.

`replication_subnet_group_descriptions`
: The descriptions of the replication subnet groups.

`vpc_ids`
: The IDs of the virtual private clouds.

`subnet_group_statuses`
: The statuses of the replication subnet groups.

`subnets`
: The subnets that are in the replication subnet groups.

## Examples

Ensure an identifier is available:

```ruby
describe aws_dms_replication_subnet_groups do
  its('replication_subnet_group_identifiers') { should include 'REPLICATION_SUBNET_GROUP_IDENTIFIER' }
end
```

Ensure that the VPC is available:

```ruby
describe aws_dms_replication_subnet_groups do
    its('vpc_ids') { should include 'VPC_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_dms_replication_subnet_groups do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_dms_replication_subnet_groups do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_dms_replication_subnet_groups do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="DatabaseMigrationService:Client:DescribeReplicationSubnetGroupsResponse" %}}
