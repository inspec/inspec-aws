---
title: About the aws_rds_snapshot Resource
---

# aws\_rds\_snapshot

Use the `aws_rds_snapshot` InSpec audit resource to test detailed properties of an individual RDS snapshot.


## Syntax

An `aws_rds_snapshot` resource block uses resource parameters to search for an RDS snapshot, and then tests that RDS snapshot.  If no RDS snapshots match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.  If more than one RDS snapshot matches (due to vague search parameters), an error is raised.

    describe aws_rds_snapshot('test-snapshot-id') do
      it { should exist }
    end

    # Can also use hash syntax
    describe aws_rds_snapshot(db_snapshot_identifier: 'test-snapshot-id') do
      it { should exist }
    end
    
#### Parameters

##### db\_snapshot\_identifier _(required)_

This resource accepts a single parameter, the user-supplied snapshot identifier. This parameter isn't case-sensitive.
This can be passed either as a string or as a `db_snapshot_identifier: 'value'` key-value entry in a hash.

See also the [AWS documentation on RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.html).

## Properties

For a comprehensive list of properties available to test on an RDS snapshot see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/Types/DBSnapshot.html)

## Examples

##### Test the engine used with an RDS snapshot

    describe aws_rds_snapshot(db_snapshot_identifier: 'awsrds123') do
      its ('engine')         { should eq 'mysql' }
      its ('engine_version') { should eq '5.6.37' }
    end
    
##### Test the storage allocated to an RDS snapshot
    
    describe aws_rds_snapshot(db_snapshot_identifier: 'awsrds123') do
      its ('allocated_storage') { should eq 10 }
    end

##### Test the snapshot type and master username
    describe aws_rds_snapshot(db_snapshot_identifier: 'awsrds123') do
      its ('master_username')   { should eq 'db-maintain' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_rds_snapshot(db_snapshot_identifier: 'AnExistingRDS') do
      it { should exist }
    end

    describe aws_rds_snapshot(db_snapshot_identifier: 'ANonExistentRDS') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `rds:DescribeDBSnapshots` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
