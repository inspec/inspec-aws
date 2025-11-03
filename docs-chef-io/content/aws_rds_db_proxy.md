+++
title = "aws_rds_db_proxy resource"

draft = false


[menu.aws]
title = "aws_rds_db_proxy"
identifier = "inspec/resources/aws/aws_rds_db_proxy resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_proxy` InSpec audit resource to test properties of a single AWS Relational Database Service (RDS) database proxy.

The `AWS::RDS::DBProxy` resource creates or updates an RDS DB proxy.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS DBProxy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxy.html).

## Syntax

Ensure that the db proxy exists.

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  it { should exist }
end
```

## Parameters

`db_proxy_name` _(required)_

: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

## Properties

`db_proxy_name`
: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

`db_proxy_arn`
: The Amazon Resource Name (ARN) for the proxy.

`status`
: The current status of this proxy.

`engine_family`
: The engine family applies to MySQL and PostgreSQL for both RDS and Aurora.

`vpc_id`
: The VPC id.

`vpc_security_group_ids`
: Provides a list of VPC security groups that the proxy belongs to.

`vpc_subnet_ids`
: The EC2 subnet IDs for the proxy.

`auth_descriptions`
: A user-specified description about the authentication used by a proxy to log in as a specific database user.

`auth_user_names`
: The name of the database user to which the proxy connects.

`auth_schemes`
: The type of authentication that the proxy uses for connections from the proxy to the underlying database.

`auth_secret_arns`
: The Amazon Resource Name (ARN) representing the secret that the proxy uses to authenticate to the RDS DB instance or Aurora DB cluster. These secrets are stored within Amazon Secrets Manager.

`auth_iam_auths`
: Whether to require or disallow AWS Identity and Access Management (IAM) authentication for connections to the proxy.

`role_arn`
: The Amazon Resource Name (ARN) for the IAM role that the proxy uses to access Amazon Secrets Manager.

`endpoint`
: The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application.

`require_tls`
: Indicates whether Transport Layer Security (TLS) encryption is required for connections to the proxy.

`idle_client_timeout`
: The number of seconds a connection to the proxy can have no activity before the proxy drops the client connection.

`debug_logging`
: Whether the proxy includes detailed information about SQL statements in its logs.

`created_date`
: The date and time when the proxy was first created.

`updated_date`
: The date and time when the proxy was last updated.

## Examples

Ensure a db proxy name is available:

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  its('db_proxy_name') { should eq 'DB_PROXY_NAME' }
end
```

Ensure a db proxy arn is available:

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  its('db_proxy_arn') { should eq 'DB_PROXY_ARN' }
end
```

Ensure a status is `available`:

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  its('status') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_proxy(db_proxy_name: 'DB_PROXY_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBProxiesResponse" %}}
