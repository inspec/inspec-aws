---
title: About the aws_rds_instance Resource
---

# aws\_rds\_instance

Use the `aws_rds_instance` InSpec audit resource to test detailed properties of an individual RDS instance.

RDS gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

<br>

## Syntax

An `aws_rds_instance` resource block uses resource parameters to search for an RDS instance, and then tests that RDS instance.  If no RDS instances match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.  If more than one RDS instance matches (due to vague search parameters), an error is raised.

    # Ensure you have a RDS instance with a certain ID
    # This is "safe" - RDS IDs are unique within an account
    describe aws_rds_instance('test-instance-id') do
      it { should exist }
    end

    # Ensure you have a RDS instance with a certain ID
    # This uses hash syntax
    describe aws_rds_instance(db_instance_identifier: 'test-instance-id') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_rds_instance`, its limited functionality precludes examples.

<br>

## Resource Parameters

This InSpec resource accepts the following parameters, which are used to search for the RDS instance.

### exists

The control will pass if the specified RDS instance was found.  Use should_not if you want to verify that the specified RDS instance does not exist.

    # Using Hash syntax
    describe aws_rds_instance(db_instance_identifier: 'test-instance-id') do
      it { should exist }
    end

    # Using the instance id directly from the terraform file
    describe aws_rds_instance(fixtures['rds_db_instance_id']) do
      it { should exist }
    end

    # Make sure we don't have any RDS instances with the name 'nogood'
    describe aws_rds_instance('nogood') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `rds:DescribeDBInstances` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
