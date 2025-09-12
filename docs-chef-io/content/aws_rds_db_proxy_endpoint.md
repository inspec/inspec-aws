+++
title = "aws_rds_db_proxy_endpoint resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_db_proxy_endpoint"
identifier = "inspec/resources/aws/aws_rds_db_proxy_endpoint resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_db_proxy_endpoint` InSpec audit resource to test properties of a single AWS Relational Database Service (RDS) database proxy endpoint.

The `AWS::RDS::DBProxyEndpoint` resource creates or updates an AWS RDS DB proxy endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS RDS DBProxyEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxyendpoint.html).

## Syntax

Ensure that the DB proxy endpoint exists.

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  it { should exist }
end
```

## Parameters

`db_proxy_name` _(required)_

: The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

`db_proxy_endpoint_name` _(required)_

: The name for the DB proxy endpoint.

## Properties

`db_proxy_endpoint_name`
: The name for the DB proxy endpoint.

`db_proxy_endpoint_arn`
: The Amazon Resource Name (ARN) for the DB proxy endpoint.

`db_proxy_name`
: The identifier for the DB proxy that is associated with this DB proxy endpoint.

`status`
: The current status of this DB proxy endpoint.

`vpc_id`
: Provides the VPC ID of the DB proxy endpoint.

`vpc_security_group_ids`
: Provides a list of VPC security groups that the DB proxy endpoint belongs to.

`vpc_subnet_ids`
: The EC2 subnet IDs for the DB proxy endpoint.

`endpoint`
: The endpoint that you can use to connect to the DB proxy.

`created_date`
: The date and time when the DB proxy endpoint was first created.

`target_role`
: A value that indicates whether the DB proxy endpoint can be used for read/write or read-only operations.

`is_default`
: A value that indicates whether this endpoint is the default endpoint for the associated DB proxy. Default DB proxy endpoints always have read/write capability.

## Examples

**Ensure a DB proxy endpoint name is available.**

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  its('db_proxy_endpoint_name') { should eq 'DB_PROXY_ENDPOINT_NAME' }
end
```

**Ensure a DB proxy is available.**

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  its('db_proxy_name') { should eq 'DB_PROXY_NAME' }
end
```

**Ensure a status is `available`.**

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  its('status') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_db_proxy_endpoint(db_proxy_name: 'DB_PROXY_NAME', db_proxy_endpoint_name: 'DB_PROXY_ENDPOINT_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBProxyEndpointsResponse" %}}
