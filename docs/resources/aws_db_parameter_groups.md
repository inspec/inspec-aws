---
title: About the aws_db_parameter_groups Resource
platform: aws
---

# aws\_db\_parameter\_groups

Use the `aws_db_parameter_groups` InSpec audit resource to test properties of a collection of AWS DB parameter groups.

## Syntax

Ensure you have exactly three DB parameter groups:

    describe aws_db_parameter_groups do
      its('db_parameter_group_names.count') { should cmp 3 }
    end

#### Parameters

This resource does not expect any parameters.

See the [AWS documentation on DB parameter groups](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-dbparametergroup.html) for additional information.

## Properties

|Property                     | Description|
| ---                         | --- |
|db\_parameter\_group\_names    | The name of the DB parameter group. |
|db\_parameter\_group\_families   | The name of the DB parameter group family that this DB parameter group is compatible with. |
|descriptions    | Provides the customer-specified description for this DB parameter group. |
|db\_parameter\_group\_arns    | The Amazon Resource Name (ARN) for the DB parameter group. |

For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DBParameterGroup.html)

## Examples

### Ensure the group name of a DB parameter group exists

    describe aws_db_parameter_groups do
      its('db_parameter_group_names') { should include 'parameter-group-name' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe method returns at least one result.

    describe aws_db_parameter_groups.where( <property>: <value> ) do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_db_parameter_groups.where( <property>: <value> ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DBParameterGroupsMessage` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
