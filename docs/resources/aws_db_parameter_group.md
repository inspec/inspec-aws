---
title: About the aws_db_parameter_group Resource
platform: aws
---

# aws_db_parameter_group

Use the `aws_db_parameter_group` InSpec audit resource to test properties of an AWS DB parameter group.

## Syntax

An `aws_db_parameter_group` resource block uses the parameter to select a parameter group.

    describe aws_db_parameter_group(db_parameter_group_name: 'DB_PARAMETER_GROUP_NAME') do
      it { should exist }
    end

### Parameters

#### db_parameter_group_name _(required)_

The name of the DB parameter group.

See the [AWS documentation on DB parameter groups](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html) for additional information.

## Properties

| Property  | Description |
| --- | --- |
| db_parameter_group_name | The name of the DB parameter group. |
| db_parameter_group_family | The name of the DB parameter group family that this DB parameter group is compatible with. |
| description | The customer-specified description for this DB parameter group. |
| db_parameter_group_arn | The Amazon Resource Name (ARN) for the DB parameter group. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBParameterGroup.html)

## Examples

### Verify the group name of a DB parameter group.

    describe aws_db_parameter_group(db_parameter_group_name: 'DB_PARAMETER_GROUP_NAME') do
      its('db_parameter_group_name')  { should eq 'DB_PARAMETER_GROUP_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

    describe aws_db_parameter_group(db_parameter_group_name: 'DB_PARAMETER_GROUP_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_db_parameter_group(db_parameter_group_name: 'DB_PARAMETER_GROUP_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DBParameterGroupsMessage` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
