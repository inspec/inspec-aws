---
title: About the aws_rds_db_security_groups Resource
platform: aws
---

# aws_rds_db_security_groups

Use the `aws_rds_db_security_groups` InSpec audit resource to test properties of the plural resource of AWS RDS security group.

## Syntax

Ensure that the db security group exists.

    describe aws_rds_db_security_groups do
      it { should exist }
    end

For additional information, see the [AWS documentation on AWS RDS security group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-security-group.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| owner_ids | Provides the Amazon Web Services ID of the owner of a specific DB security group. | owner_id |
| db_security_group_names | The name of the DB security group to return details for. | db_security_group_name |
| db_security_group_descriptions | Provides the description of the DB security group.| db_security_group_description |
| vpc_ids |Provides the VpcId of the DB security group. | vpc_id |
| db_security_group_arns | The Amazon Resource Name (ARN) for the DB security group. | db_security_group_arn |


## Examples

### Ensure a db security group name is available.
    describe aws_rds_db_security_groups do
      its('db_security group_names') { should include 'SECURITY_GROUP_NAME' }
    end

### Ensure a db security group arn is available.
    describe aws_rds_db_security_groups do
      its('db_security_group_arns') { should include 'SECURITY_GROUP_ARN' }
    end

### Ensure a status is `available`.
    describe aws_rds_db_security_groups do
      its('statuses') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_security_groups do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_security_groups do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_security_groups do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBSecurityGroup` action with `Effect` set to `Allow`.