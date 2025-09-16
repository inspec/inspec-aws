+++
title = "aws_dms_replication_subnet_group resource"

draft = false


[menu.aws]
title = "aws_dms_replication_subnet_group"
identifier = "inspec/resources/aws/aws_dms_replication_subnet_group resource"
parent = "inspec/resources/aws"
+++

Use the `aws_dms_replication_subnet_group` InSpec audit resource to test properties of a single DMS replication instance subnet group.

For additional information, including details on parameters and properties, see the [AWS documentation on DMS Replication Subnet Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html).

## Syntax

Ensure that a subnet group identifier exists.

```ruby
describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
  it { should exist }
end
```

## Parameters

`replication_subnet_group_identifier` _(required)_

: The identifier for the replication subnet group.

## Properties

`replication_subnet_group_identifier`
: The identifier of the replication subnet group.

`replication_subnet_group_description`
: The description of the replication subnet group.

`vpc_id`
: The ID of the virtual private cloud.

`subnet_group_status`
: The status of the replication subnet group.

`subnets`
: The subnets that are in the replication subnet group.

## Examples

Ensure a identifier is available:

```ruby
describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
  its('replication_subnet_group_identifier') { should eq 'SUBNET_GROUP_IDENTIFIER' }
end
```

Ensure that the vpc is available:

```ruby
describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
    its('vpc_id') { should eq 'VPC_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the identifier is available.

```ruby
describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'SUBNET_GROUP_IDENTIFIER') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="DatabaseMigrationService:Client:DescribeReplicationSubnetGroupsResponse" %}}
