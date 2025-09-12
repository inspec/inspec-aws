+++
title = "aws_ebs_snapshots resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ebs_snapshots"
identifier = "inspec/resources/aws/aws_ebs_snapshots resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ebs_snapshots` InSpec audit resource to test properties of a collection of AWS EBS Snapshots.

For additional information, including details on parameters and properties, see the [AWS documentation on EBS Snapshots](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSsnapshots.html).

## Syntax

 Ensure you have exactly 3 EBS Snapshots:

```ruby
describe aws_ebs_snapshots do
  its('snapshot_ids.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`snapshot_ids`
: An array of the unique IDs of the EBS Snapshots that are returned.

`owner_ids`
: An array of AWS Account IDs of the owners of the EBS Snapshots that are returned.

`encrypted`
: An array of booleans indicating whether the EBS Snapshots returned are encrypted.

`tags`
: An array of hashes; each hash is a set of keys and values for tags for one of the EBS Snapshots returned, and may be empty.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a specific EBS Snapshot exists.**

```ruby
describe aws_ebs_snapshots do
  its('snapshot_ids') { should include 'SNAPSHOT_ID' }
end
```

**Use the InSpec resource to request the IDs of all EBS Snapshots, then test in-depth using `aws_ebs_snapshot` to ensure all EBS Snapshots are encrypted and not public.**

```ruby
aws_ebs_snapshots.snapshot_ids.each do |snapshot_id|
  describe aws_ebs_snapshot(snapshot_id: snapshot_id) do
    it { should be_encrypted }
    it { should_not be_public }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_ebs_snapshots do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ebs_snapshots do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client::DescribeSnapshotsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
