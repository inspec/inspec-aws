---
title: About the aws_ebs_snapshot Resource
platform: aws
---

# aws\_ebs\_snapshot

Use the `aws_ebs_snapshot` InSpec audit resource to test properties of a single AWS EBS Snapshot. These are point-in-time
incremental backups of AWS EBS Volumes that are saved to AWS S3.

## Syntax

Ensure an EBS snapshot exists:

    describe aws_ebs_snapshot(snapshot_id: 'snap-0123456789abcdef') do
      it { should exist }
    end

You may also use hash syntax to pass the EBS volume name:

    describe aws_ebs_snapshot(name: 'my-snapshot') do
      it { should exist }
    end

#### Parameters

This resource accepts a single parameter, either the EBS Snapshot ID or name (from the Name tag). At least one must be provided.

##### snapshot\_id

The EBS Snapshot ID which uniquely identifies the volume.
This can be passed as either a string or an `snapshot_id: 'value'` key-value entry in a hash.

See also the [AWS documentation on EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html).

##### name _(required if `snapshot_id` not provided)_

The EBS Volume Name from the Name tag. This must be passed as a `name: 'value'` key-value entry in a hash.
It is not advised to use this parameter if your Name tags for your snapshots are not unique, as at most one entry is returned.

## Properties

|Property     | Description|
| ---         | --- |
|snapshot\_id | The unique ID for the EBS Snapshot. |
|tags         | A hash of tags for the EBS Snapshot, e.g. {'Name' => 'snapshot-name'} . |
|encrypted    | A boolean indicating whether the snapshot is encrypted. |
|group        | Either set to 'all' if the EBS Snapshot is public (anyone can create a volume from the EBS Snapshot), or nil. |
|user\_ids    | An array of user\_ids (account numbers) that have been granted create volume permission, or an empty array if no other accounts have been granted permission to create a volume from this EBS Snapshot. |

There are also additional properties available, for instance `description`, `owner_id` and `volume_size`. For a comprehensive list,
see [the API reference documentation for EBS Snapshots](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Snapshot.html).

## Examples

##### Test that an EBS Snapshot is encrypted
    describe aws_ebs_snapshot(id: 'snap-12345678')do
      its('encrypted') { should eq true }
    end

##### Test that an EBS Snapshot has the expected Name tag
    describe aws_ebs_snapshot(id: 'snap-55555555') do
      its('tags') { should include(key: 'Name', value: 'My-Snapshot') }
    end

##### Tests that no specified accounts have been given access to create volumes from this EBS Snapshot
    describe aws_ebs_snapshot(id: 'snap-55555555') do
      its('user_ids') { should be_empty }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

    describe aws_ebs_snapshot(name: 'snap-a1b2c3d4') do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_ebs_snapshot(id: 'snap-012345678') do
      it { should_not exist }
    end

#### be\_encrypted

The `be_encrypted` matcher tests whether the described EBS Snapshot is encrypted.

    it { should be_encrypted }

#### be\_public

The `be_public` matcher tests whether the described EBS Snapshot is public, i.e. if anyone may create a volume from the EBS Snapshot.

    it { should be_public }

#### be\_private

The `be_private` matcher tests whether the described EBS Snapshot is private, i.e. not open for anyone to create a volume from
the EBS Snapshot. It does not check whether specific user\_ids (AWS accounts) have been given access to create a volume from the
EBS Snapshot). To check permissions for specific user\_ids, see the last example in the previous section.

    it { should be_private }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeSnapshots` and `ec2:DescribeSnapshotAttribute` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
