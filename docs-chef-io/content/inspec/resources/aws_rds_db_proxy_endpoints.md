+++
title = "aws_rds_db_proxy_endpoints Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_db_proxy_endpoints"
identifier = "inspec/resources/aws/aws_rds_db_proxy_endpoints Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_proxy_endpoints` InSpec audit resource to test properties of multiple AWS Relational Database Service (RDS) database proxy endpoints.

The `AWS::RDS::DBProxyEndpoint` resource creates or updates an AWS RDS DB proxy endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS DBProxyEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxyendpoint.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the DB proxy endpoint exists.

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  it { should exist }
end
```

## Parameters

`db_proxy_name` _(required)_

: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

## Properties

`db_proxy_endpoint_names`
: The name for the DB proxy endpoint.

: **Field**: `db_proxy_endpoint_name`

`db_proxy_endpoint_arns`
: The Amazon Resource Name (ARN) for the DB proxy endpoint.

: **Field**: `db_proxy_endpoint_arn`

`db_proxy_names`
: The identifier for the DB proxy that is associated with this DB proxy endpoint.

: **Field**: `db_proxy_name`

`statuses`
: The current status of this DB proxy endpoint.

: **Field**: `status`

`vpc_ids`
: Provides the VPC ID of the DB proxy endpoint.

: **Field**: `vpc_id`

`vpc_security_group_ids`
: Provides a list of VPC security groups that the DB proxy endpoint belongs to.

: **Field**: `vpc_security_group_ids`

`vpc_subnet_ids`
: The EC2 subnet IDs for the DB proxy endpoint.

: **Field**: `vpc_subnet_ids`

`endpoints`
: The endpoint that you can use to connect to the DB proxy.

: **Field**: `endpoint`

`created_dates`
: The date and time when the DB proxy endpoint was first created.

: **Field**: `created_date`

`target_roles`
: A value that indicates whether the DB proxy endpoint can be used for read/write or read-only operations.

: **Field**: `target_role`

`is_default`
: A value that indicates whether this endpoint is the default endpoint for the associated DB proxy. Default DB proxy endpoints always have read/write capability.

: **Field**: `is_default`

## Examples

**Ensure a DB proxy endpoint name is available.**

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  its('db_proxy_endpoint_names') { should include 'DB_PROXY_ENDPOINT_NAME' }
end
```

**Ensure a DB proxy is available.**

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  its('db_proxy_names') { should include 'DB_PROXY_NAME' }
end
```

**Ensure a status is `available`.**

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  its('statuses') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBProxyEndpointsResponse" %}}
