+++
title = "aws_rds_db_proxy_target_group resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_db_proxy_target_group"
identifier = "inspec/resources/aws/aws_rds_db_proxy_target_group resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_proxy_target_group` InSpec audit resource to test properties of a single AWS Relational Database Service (RDS) database proxy target group.

The `AWS::RDS::DBProxyTargetGroup` resource represents a set of RDS DB instances, Aurora DB clusters, or both that a proxy can connect to.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS DBProxyTargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxytargetgroup.html).

## Syntax

Ensure that the target group exists.

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  it { should exist }
end
```

## Parameters

`db_proxy_name` _(required)_

: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

`target_group_name` _(required)_

: The identifier for the target group.

## Properties

`db_proxy_name`
: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

`target_group_name`
: The identifier for the target group.

`target_group_arn`
: The Amazon Resource Name (ARN) representing the target group.

`is_default`
: Whether this target group is the first one used for connection requests by the associated proxy.

`status`
: The current status of this target group.

`connection_pool_config.max_connections_percent`
: The maximum size of the connection pool for each target in a target group.

`connection_pool_config.max_idle_connections_percent`
: Controls how actively the proxy closes idle database connections in the connection pool.

`connection_pool_config.connection_borrow_timeout`
: The number of seconds for a proxy to wait for a connection to become available in the connection pool.

`connection_pool_config.session_pinning_filters`
: Each item in the list represents a class of SQL operations that normally cause all later statements in a session using a proxy to be pinned to the same underlying database connection.

`connection_pool_config.init_query`
: One or more SQL statements for the proxy to run when opening each new database connection.

`created_date`
: The date and time when the target group was first created.

`updated_date`
: The date and time when the target group was last updated.

## Examples

Ensure a DB proxy name is available:

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  its('db_proxy_name') { should eq 'DB_PROXY_NAME' }
end
```

Ensure a target group name is available:

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  its('target_group_name') { should eq 'TARGET_GROUP_NAME' }
end
```

Ensure a status is `available`:

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  its('status') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_proxy_target_group(db_proxy_name: 'DB_PROXY_NAME', target_group_name: 'TARGET_GROUP_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBProxyTargetGroupsResponse" %}}
