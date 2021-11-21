---
title: About the aws_rds_db_proxies Resource
platform: aws
---

# aws_rds_db_proxies

Use the `aws_rds_db_proxies` InSpec audit resource to test properties of the plural resource of AWS RDS DBProxy.

The AWS::RDS::DBProxy resource creates or updates a DB proxy.

## Syntax

Ensure that the db proxy exists.

    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end

## Parameters

`db_proxy_name` _(required)_

The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

For additional information, see the [AWS documentation on AWS RDS DBProxy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxy.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| db_proxy_names | The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region. | db_proxy_name |
| db_proxy_arns | The Amazon Resource Name (ARN) for the proxy. | db_proxy_arn |
| statuses | The current status of this proxy. |
| engine_families | The engine family applies to MySQL and PostgreSQL for both RDS and Aurora. | engine_family |
| vpc_ids | The VPC id. | vpc_id |
| vpc_security_group_ids | Provides a list of VPC security groups that the proxy belongs to. | vpc_security_group_ids |
| vpc_subnet_ids | The EC2 subnet IDs for the proxy. | vpc_subnet_ids |
| auths | One or more data structures specifying the authorization mechanism to connect to the associated RDS DB instance or Aurora DB cluster. | auths |
| role_arns | The Amazon Resource Name (ARN) for the IAM role that the proxy uses to access Amazon Secrets Manager. | role_arn |
| endpoints | The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application. | endpoint |
| require_tls | Indicates whether Transport Layer Security (TLS) encryption is required for connections to the proxy. |
| idle_client_timeouts | The number of seconds a connection to the proxy can have no activity before the proxy drops the client connection. | idle_client_timeout |
| debug_loggings | Whether the proxy includes detailed information about SQL statements in its logs. | debug_logging |
| created_dates | The date and time when the proxy was first created. | created_date |
| updated_dates | The date and time when the proxy was last updated. | updated_date |

## Examples

### Ensure a db proxy name is available.
    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      its('db_proxy_names') { should include 'DB_PROXY_NAME' }
    end

### Ensure a db proxy arn is available.
    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      its('db_proxy_arns') { should include 'DB_PROXY_ARN' }
    end

### Ensure a status is `available`.
    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_proxies(db_proxy_name: 'DB_PROXY_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBProxiesResponse` action with `Effect` set to `Allow`.