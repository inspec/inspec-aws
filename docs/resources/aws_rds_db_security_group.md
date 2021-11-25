---
title: About the aws_rds_db_security_group Resource
platform: aws
---

# aws_rds_db_security_group

Use the `aws_rds_db_security_group` InSpec audit resource to test properties of the singular resource of AWS security group .

## Syntax

Ensure that the security group exists.

    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      it { should exist }
    end

## Parameters

`db_security_group_name` _(required)_

The identifier for the security group.

For additional information, see the [AWS documentation on AWS RDS Security Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-rds-security-group.html).

## Properties

| Property | Description |
| --- | --- |
| owner_id | Provides the Amazon Web Services ID of the owner of a specific DB security group. |
| db_security_group_name | The name of the DB security group to return details for. |
| db_security_group_description | Provides the description of the DB security group.|
| vpc_id |Provides the VpcId of the DB security group. |
| ec2_security_groups | The VPC id. |
| status | Provides the status of the EC2 security group. Status can be "authorizing", "authorized", "revoking", and "revoked". |
| ec2_security_group_name | Specifies the name of the EC2 security group.|
| ec2_security_group_id | pecifies the id of the EC2 security group. |
| ec2_security_group_owner_id | pecifies the Amazon Web Services ID of the owner of the EC2 security group specified in the EC2SecurityGroupName field. |
| status | Specifies the status of the IP range. Status can be "authorizing", "authorized", "revoking", and "revoked". |
| db_security_group_arn | The Amazon Resource Name (ARN) for the DB security group. |
| cidrip | Specifies the IP range. |

## Examples

### Ensure a security group name is available.
    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      its('db_security_group_name') { should eq 'SECURITY_GROUP_NAME' }
    end

### Ensure a security group description is available.
    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      its('db_security_group_description') { should eq 'SECURITY_GROUP_DESC' }
    end

### Ensure a status is `available`.
    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      its('status') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_db_security_group(db_security_group_name: 'SECURITY_GROUP_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBSecurityGroup` action with `Effect` set to `Allow`.