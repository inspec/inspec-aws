---
title: About the aws_rds_snapshot Resource
---

# aws_rds_snapshot

Use the `aws_rds_snapshot` InSpec audit resource to test the detailed properties of an individual RDS snapshot.

## Syntax

An `aws_rds_snapshot` resource block uses resource parameters to search for an RDS snapshot and test the respective RDS snapshot.

No error is raised if no RDS snapshots match. However, the `exists` matcher will return `false`, and all properties will be `nil`.

An error is raised if more than one RDS snapshot matches (due to vague search parameters).

    describe aws_rds_snapshot('TEST-SNAPSHOT-ID') do
      it { should exist }
    end

    # Can also use hash syntax
    describe aws_rds_snapshot(db_snapshot_identifier: 'TEST-SNAPSHOT-ID') do
      it { should exist }
    end

    # Passing in
    describe aws_rds_snapshot(resource_data: 'RESOURCE_DATA_OBJECT') do
      it { should exist }
    end

## Parameters

### db_snapshot_identifier _(required if resource_data not provided)_

The user-supplied database snapshot identifier.
This parameter can passed as a string or a `db_snapshot_identifier: 'value'` key-value entry in a hash.

See also the [AWS documentation on RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.html).

### resource_data _(required if db_snapshot_identifier not provided)_

A cached resource data object.
This must be passed key-value entry in a hash. For example, `resource_data: 'RESOURCE_DATA_OBJECT'` .


## Properties

For a comprehensive list of properties available to test on an RDS snapshot see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/Types/DBSnapshot.html)

## Examples

### Tests the engine used is with an RDS snapshot

    describe aws_rds_snapshot(db_snapshot_identifier: 'AWSRDS123') do
      its ('engine')         { should eq 'MYSQL' }
      its ('engine_version') { should eq '5.6.37' }
    end


### Tests the storage allocated to an RDS snapshot

    describe aws_rds_snapshot(db_snapshot_identifier: 'AWSRDS123') do
      its ('allocated_storage') { should eq 10 }
    end


### Tests the snapshot type and master username

    describe aws_rds_snapshot(db_snapshot_identifier: 'AWSRDS123') do
      its ('master_username')   { should eq 'DB-MAINTAIN' }
    end

### Tests the snapshot using cached resource data

    describe aws_rds_snapshot(resource_data: 'AWS_RDS_SNAPSHOT') do
        its ('engine')         { should eq 'MYSQL' }
        its ('engine_version') { should eq '5.6.37' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_rds_snapshot(db_snapshot_identifier: 'AnExistingRDS') do
      it { should exist }
    end

    describe aws_rds_snapshot(db_snapshot_identifier: 'ANonExistentRDS') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DBSnapshotMessage` action with Effect set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
