---
title: About the aws_rds_snapshots Resource
platform: aws
---

# aws\_rds\_snapshots

Use the `aws_rds_snapshots` InSpec audit resource to test properties of a collection of AWS RDS snapshots.

## Syntax

 Ensure you have exactly 3 snapshots

    describe aws_rds_snapshots do
      its('db_snapshot_identifiers.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on RDS](https://docs.aws.amazon.com/rds/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|db\_snapshot\_identifiers    | The unique IDs of the RDS snapshots returned. |
|entries                      | Provides access to the raw results of the query, which can be treated as an array of hashes. |
   
## Examples

##### Ensure a specific snapshot exists
    describe aws_rds_snapshots do
      its('db_snapshot_identifiers') { should include 'rds-12345678' }
    end

##### Use the InSpec resource to request the IDs of all RDS snapshots, then test in-depth using `aws_rds_snapshot` to ensure all snapshots are encrypted and have a sensible size.
    aws_rds_snapshots.db_snapshot_identifiers.each do |db_snapshot_identifier|
      describe aws_rds_snapshot(db_snapshot_identifier) do
        it { should be_encrypted }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_rds_snapshots do
      it { should exist }
    end
      
    describe aws_rds_snapshots do
      it { should_not exist }
    end

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeSnapshots`, and `iam:GetSnapshotProfile` actions set to allow.
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
