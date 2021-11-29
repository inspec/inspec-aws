---
title: About the aws_rds_db_proxy_target_groups Resource
platform: aws
---

# aws_rds_db_proxy_target_groups

Use the `aws_rds_db_proxy_target_groups` InSpec audit resource to test properties of multiple AWS Relational Database Service (RDS) database proxy target groups.

The `AWS::RDS::DBProxyTargetGroup` resource represents a set of RDS DB instances, Aurora DB clusters, or both that a proxy can connect to.

## Syntax

Ensure that the target group exists.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end

## Parameters

`db_proxy_name` _(required)_

The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.

For additional information, see the [AWS documentation on AWS RDS DBProxyTargetGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbproxytargetgroup.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| db_proxy_names | The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region. | db_proxy_name |
| target_group_names | The identifier for the target group. | target_group_name |
| target_group_arns | The Amazon Resource Name (ARN) representing the target group. | target_group_arn |
| is_default | Whether this target group is the first one used for connection requests by the associated proxy. | is_default |
| statuses | The current status of this target group. | status |
| connection_pool_configs | The settings that determine the size and behavior of the connection pool for the target group. | connection_pool_config |
| created_dates | The date and time when the target group was first created. | created_date |
| updated_dates | The date and time when the target group was last updated. | updated_date |

## Examples

### Ensure a DB proxy name is available.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      its('db_proxy_names') { should include 'DB_PROXY_NAME' }
    end

### Ensure a target group name is available.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      its('target_group_names') { should include 'TARGET_GROUP_NAME' }
    end

### Ensure a status is `available`.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_proxy_target_groups(db_proxy_name: 'DB_PROXY_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBProxyTargetGroupsResponse` action with `Effect` set to `Allow`.
