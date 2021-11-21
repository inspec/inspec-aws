---
title: About the aws_ebs_snapshots Resource
platform: aws
---

# aws\_ebs\_snapshots

Use the `aws_ebs_snapshots` InSpec audit resource to test properties of a collection of AWS EBS Snapshots.

## Syntax

 Ensure you have exactly 3 EBS Snapshots:

    describe aws_ebs_snapshots do
      its('snapshot_ids.count') { should cmp 3 }
    end

#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSsnapshots.html).

## Properties

|Property      | Description|
| ---          | --- |
|snapshot\_ids | An array of the unique IDs of the EBS Snapshots that are returned. |
|owner\_ids    | An array of AWS Account IDs of the owners of the EBS Snapshots that are returned. |
|encrypted     | An array of booleans indicating whether the EBS Snapshots returned are encrypted. |
|tags          | An array of hashes; each hash is a set of keys and values for tags for one of the EBS Snapshots returned, and may be empty. |
|entries       | Provides access to the raw results of the query, which can be treated as an array of hashes. |

## Examples

### Ensure a specific EBS Snapshot exists

    describe aws_ebs_snapshots do
      its('snapshot_ids') { should include 'SNAPSHOT_ID' }
    end

### Use the InSpec resource to request the IDs of all EBS Snapshots, then test in-depth using `aws_ebs_snapshot` to ensure all EBS Snapshots are encrypted and not public

    aws_ebs_snapshots.snapshot_ids.each do |snapshot_id|
      describe aws_ebs_snapshot(snapshot_id: snapshot_id) do
        it { should be_encrypted }
        it { should_not be_public }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

    describe aws_ebs_snapshots do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_ebs_snapshots do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client::DescribeSnapshotsResult` actions with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
