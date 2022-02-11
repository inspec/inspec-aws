---
title: About the aws_rds_db_proxy_endpoints Resource
platform: aws
---

# aws_rds_db_proxy_endpoints

Use the `aws_rds_db_proxy_endpoints` InSpec audit resource to test properties of multiple AWS Relational Database Service (RDS) database proxy endpoints.

The `AWS::RDS::DBProxyEndpoint` resource creates or updates an AWS RDS DB proxy endpoint.

## Syntax

Ensure that the DB proxy endpoint exists.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end

## Parameters

`db_proxy_name` _(required)_

The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

For additional information, see the [AWS documentation on AWS RDS DBProxyEndpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxyendpoint.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| db_proxy_endpoint_names | The name for the DB proxy endpoint. | db_proxy_endpoint_name |
| db_proxy_endpoint_arns | The Amazon Resource Name (ARN) for the DB proxy endpoint. | db_proxy_endpoint_arn |
| db_proxy_names | The identifier for the DB proxy that is associated with this DB proxy endpoint. | db_proxy_name |
| statuses | The current status of this DB proxy endpoint. | status |
| vpc_ids | Provides the VPC ID of the DB proxy endpoint. | vpc_id |
| vpc_security_group_ids | Provides a list of VPC security groups that the DB proxy endpoint belongs to. | vpc_security_group_ids |
| vpc_subnet_ids | The EC2 subnet IDs for the DB proxy endpoint. | vpc_subnet_ids |
| endpoints | The endpoint that you can use to connect to the DB proxy. | endpoint |
| created_dates | The date and time when the DB proxy endpoint was first created. | created_date |
| target_roles | A value that indicates whether the DB proxy endpoint can be used for read/write or read-only operations. | target_role |
| is_default | A value that indicates whether this endpoint is the default endpoint for the associated DB proxy. Default DB proxy endpoints always have read/write capability. | is_default |

## Examples

### Ensure a DB proxy endpoint name is available.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      its('db_proxy_endpoint_names') { should include 'DB_PROXY_ENDPOINT_NAME' }
    end

### Ensure a DB proxy is available.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      its('db_proxy_names') { should include 'DB_PROXY_NAME' }
    end

### Ensure a status is `available`.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_proxy_endpoints(db_proxy_name: 'DB_PROXY_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBProxyEndpointsResponse` action with `Effect` set to `Allow`.
