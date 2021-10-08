---
title: About the aws_ebs_snapshot Resource
platform: aws
---

# aws\_ebs\_snapshot

Use the `aws_ebs_snapshot` InSpec audit resource to test properties of a single AWS EBS Snapshot. These are point-in-time
incremental backups of AWS EBS volumes that are saved to AWS S3.

## Syntax

Ensure an EBS Snapshot exists:

    describe aws_ebs_snapshot(snapshot_id: 'SNAPSHOT_ID') do
      it { should exist }
    end

You may also use hash syntax to pass the EBS volume name:

    describe aws_ebs_snapshot(name: 'SNAPSHOT_ID') do
      it { should exist }
    end

### Parameters

This resource accepts a single parameter, either the EBS Snapshot ID or name (from the Name tag). At least one must be provided.

#### snapshot\_id

The EBS Snapshot ID which uniquely identifies the volume.
This can be passed as either a string or an `snapshot_id: 'value'` key-value entry in a hash.

For additional information, see the [AWS documentation on EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html).

#### name _(required if `snapshot_id` not provided)_

The EBS volume name from the name tag. This must be passed as a `name: 'value'` key-value entry in a hash.
It is not advised to use this parameter if your Name tags for your snapshots are not unique, as at most one entry is returned.

## Properties

|Property                  | Description|
| ---                      | --- |
|snapshot\_id              | The unique ID for the EBS Snapshot. |
|encrypted                 | A boolean indicating whether the EBS Snapshot is encrypted. |
|data\_encryption\_key\_id | The data encryption key identifier for the EBS Snapshot. |
|description               | The description for the EBS Snapshot. |
|group                     | Either set to `'all'` if the EBS Snapshot is public (anyone can create a volume from the EBS Snapshot), or `nil`. |
|kms\_key\_id              | The ARN of the AWS KMS customer master key that was used to protect the volume encryption key for the parent volume. |
|outpost\_arn              | The ARN of the AWS Outpost on which the EBS Snapshot is stored. |
|owner\_alias              | The AWS owner alias, from an Amazon-maintained list. |
|owner\_id                 | The AWS account ID of the EBS Snapshot owner. |
|progress                  | The progress of the EBS Snapshot, as a percentage, e.g. `'100%'`. |
|start\_time               | The time stamp when the EBS Snapshot was initiated. |
|state                     | The EBS Snapshot state. |
|state\_message            | A message about the EBS Snapshot state. | 
|tags                      | A hash of tags for the EBS Snapshot, e.g. `{'Name' => 'snapshot-name'}` . |
|user\_ids                 | An array of user\_ids (account numbers) that have been granted permission to create a volume from this EBS Snapshot. |
|volume\_id                | The ID of the volume that was used to create the EBS Snapshot. |
|volume\_size              | The size of the volume, in GiB. |

## Examples

### Test that an EBS Snapshot is encrypted

    describe aws_ebs_snapshot(id: 'SNAPSHOT_ID')do
      its('encrypted') { should eq true }
    end

### Test that an EBS Snapshot has the expected Name tag

    describe aws_ebs_snapshot(id: 'SNAPSHOT_ID') do
      its('tags') { should include(key: 'Name', value: 'SNAPSHOT_NAME') }
    end

### Tests that no specified accounts have been given access to create volumes from this EBS Snapshot

    describe aws_ebs_snapshot(id: 'SNAPSHOT_ID') do
      its('user_ids') { should be_empty }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

    describe aws_ebs_snapshot(name: 'SNAPSHOT_ID') do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_ebs_snapshot(id: 'SNAPSHOT_ID') do
      it { should_not exist }
    end

### be\_encrypted

The `be_encrypted` matcher tests whether the described EBS Snapshot is encrypted.

    it { should be_encrypted }

### be\_public

The `be_public` matcher tests whether the described EBS Snapshot is public, i.e. if anyone may create a volume from the EBS Snapshot.

    it { should be_public }

### be\_private

The `be_private` matcher tests whether the described EBS Snapshot is private, i.e. not open for anyone to create a volume from
the EBS Snapshot. It does not check whether specific user\_ids (AWS accounts) have been given access to create a volume from the
EBS Snapshot). To check permissions for specific user\_ids, see the last example in the previous section.

    it { should be_private }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client::DescribeSnapshotsResult` and `EC2:Client:DescribeSnapshotAttributeResult` actions with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
