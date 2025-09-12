+++
title = "aws_rds_db_proxy_target_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_db_proxy_target_groups"
identifier = "inspec/resources/aws/aws_rds_db_proxy_target_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_proxy_target_groups` InSpec audit resource to test properties of multiple AWS Relational Database Service (RDS) database proxy target groups.

The `AWS::RDS::DBProxyTargetGroup` resource represents a set of RDS DB instances, Aurora DB clusters, or both that a proxy can connect to.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS DBProxyTargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxytargetgroup.html).

## Syntax

Ensure that the target group exists.

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  it { should exist }
end
```

## Parameters

`db_proxy_name` _(required)_

: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

## Properties

`db_proxy_names`
: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

: **Field**: `db_proxy_name`

`target_group_names`
: The identifier for the target group.

: **Field**: `target_group_name`

`target_group_arns`
: The Amazon Resource Name (ARN) representing the target group.

: **Field**: `target_group_arn`

`is_default`
: Whether this target group is the first one used for connection requests by the associated proxy.

: **Field**: `is_default`

`statuses`
: The current status of this target group.

: **Field**: `status`

`connection_pool_configs`
: The settings that determine the size and behavior of the connection pool for the target group.

: **Field**: `connection_pool_config`

`created_dates`
: The date and time when the target group was first created.

: **Field**: `created_date`

`updated_dates`
: The date and time when the target group was last updated.

: **Field**: `updated_date`

## Examples

**Ensure a DB proxy name is available.**

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  its('db_proxy_names') { should include 'DB_PROXY_NAME' }
end
```

**Ensure a target group name is available.**

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  its('target_group_names') { should include 'TARGET_GROUP_NAME' }
end
```

**Ensure a status is `available`.**

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  its('statuses') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBProxyTargetGroupsResponse" %}}
