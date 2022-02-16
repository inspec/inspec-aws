---
title: About the aws_rds_snapshot_attributes Resource
---

# aws_rds_snapshot_attributes

Use the `aws_rds_snapshotattributes` InSpec audit resource to test the detailed properties of an individual RDS snapshot attrbutes.

## Syntax

An `aws_rds_snapshot_attributes` resource block uses resource parameters to search for an RDS snapshot and test the respective RDS snapshot attributes.  

No error is raised if no RDS snapshots match. However, the `exists` matcher will return `false`, and all properties will be `nil`.  

An error is raised if more than one RDS snapshot matches (due to vague search parameters).

    describe aws_rds_snapshot_attributes('TEST-SNAPSHOT-ID') do
      it { should exist }
    end

    # Can also use hash syntax
    describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'TEST-SNAPSHOT-ID') do
      it { should exist }
    end

## Parameters

db_snapshot_identifier

This resource accepts a single parameter either as a string or a `db_snapshot_identifier: 'value'` key-value entry in a hash. This parameter is user-supplied DB snapshot identifier. This parameter isn't case-sensitive and is a required parameter.

See also the [AWS documentation on RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.html).

## Properties

|Property                     | Description|
| ---                         | --- |
|db\_snapshot\_identifier     | The unique ID of the RDS snapshot returned. |
|attribute_name               | The name of the attribute returned for a RDS snapshot. |
|attribute_values             | The attribute values associated with the attribute_name. |

## Examples

### Tests the attribute name of RDS snapshot

    describe aws_rds_snapshot-attributes(db_snapshot_identifier: 'AWSRDS123') do
      its ('attribute_name') { should eq 'restore' }
    end

### Tests the attribute value of attribute name for a RDS snapshot

    describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'AWSRDS123').where('attribute_name' == 'restore') do
      its('attribute_values') { should_not include 'all' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'AnExistingRDS') do
      it { should exist }
    end

    describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'ANonExistentRDS') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBSnapshotAttributesResult` action with Effect set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
