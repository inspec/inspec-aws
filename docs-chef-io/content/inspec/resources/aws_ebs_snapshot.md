+++
title = "aws_ebs_snapshot Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ebs_snapshot"
identifier = "inspec/resources/aws/aws_ebs_snapshot Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ebs_snapshot` InSpec audit resource to test properties of a single AWS EBS Snapshot. These are point-in-time
incremental backups of AWS EBS volumes that are saved to AWS S3.

For additional information, including details on parameters and properties, see the [AWS documentation on EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure an EBS Snapshot exists:

```ruby
describe aws_ebs_snapshot(snapshot_id: 'SNAPSHOT_ID') do
  it { should exist }
end
```

You may also use hash syntax to pass the EBS volume name:

```ruby
describe aws_ebs_snapshot(name: 'SNAPSHOT_ID') do
  it { should exist }
end
```

## Parameters

This resource accepts a single parameter, either the EBS Snapshot ID or name (from the Name tag). At least one must be provided.

`snapshot_id`

: The EBS Snapshot ID which uniquely identifies the volume.
  This can be passed as either a string or an `snapshot_id: 'value'` key-value entry in a hash.

`name` _(required if `snapshot_id` not provided)_

: The EBS volume name from the name tag. This must be passed as a `name: 'value'` key-value entry in a hash.
  It is not advised to use this parameter if your Name tags for your snapshots are not unique, as at most one entry is returned.

## Properties

`snapshot_id`
: The unique ID for the EBS Snapshot.

`encrypted`
: A boolean indicating whether the EBS Snapshot is encrypted.

`data_encryption_key_id`
: The data encryption key identifier for the EBS Snapshot.

`description`
: The description for the EBS Snapshot.

`group`
: Either set to `'all'` if the EBS Snapshot is public (anyone can create a volume from the EBS Snapshot), or `nil`.

`kms_key_id`
: The ARN of the AWS KMS customer master key that was used to protect the volume encryption key for the parent volume.

`outpost_arn`
: The ARN of the AWS Outpost on which the EBS Snapshot is stored.

`owner_alias`
: The AWS owner alias, from an Amazon-maintained list.

`owner_id`
: The AWS account ID of the EBS Snapshot owner.

`progress`
: The progress of the EBS Snapshot, as a percentage, e.g. `'100%'`.

`start_time`
: The time stamp when the EBS Snapshot was initiated.

`state`
: The EBS Snapshot state.

`state_message`
: A message about the EBS Snapshot state.

`tags`
: A hash of tags for the EBS Snapshot, e.g. `{'Name' => 'snapshot-name'}` .

`user_ids`
: An array of user_ids (account numbers) that have been granted permission to create a volume from this EBS Snapshot.

`volume_id`
: The ID of the volume that was used to create the EBS Snapshot.

`volume_size`
: The size of the volume, in GiB.

## Examples

**Test that an EBS Snapshot is encrypted.**

```ruby
describe aws_ebs_snapshot(id: 'SNAPSHOT_ID')do
  its('encrypted') { should eq true }
end
```

**Test that an EBS Snapshot has the expected Name tag.**

```ruby
describe aws_ebs_snapshot(id: 'SNAPSHOT_ID') do
  its('tags') { should include(key: 'Name', value: 'SNAPSHOT_NAME') }
end
```

**Tests that no specified accounts have been given access to create volumes from this EBS Snapshot.**

```ruby
describe aws_ebs_snapshot(id: 'SNAPSHOT_ID') do
  its('user_ids') { should be_empty }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_ebs_snapshot(name: 'SNAPSHOT_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ebs_snapshot(id: 'SNAPSHOT_ID') do
  it { should_not exist }
end
```

### be_encrypted

The `be_encrypted` matcher tests whether the described EBS Snapshot is encrypted.

```ruby
it { should be_encrypted }
```

### be_public

The `be_public` matcher tests whether the described EBS Snapshot is public, i.e. if anyone may create a volume from the EBS Snapshot.

```ruby
it { should be_public }
```

### be_private

The `be_private` matcher tests whether the described EBS Snapshot is private, i.e. not open for anyone to create a volume from
the EBS Snapshot. It does not check whether specific user_ids (AWS accounts) have been given access to create a volume from the
EBS Snapshot). To check permissions for specific user_ids, see the last example in the previous section.

```ruby
it { should be_private }
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client::DescribeSnapshotsResult` and `EC2:Client:DescribeSnapshotAttributeResult` actions with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
