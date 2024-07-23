+++
title = "aws_ebs_volumes Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ebs_volumes"
identifier = "inspec/resources/aws/aws_ebs_volumes Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ebs_volumes` InSpec audit resource to test the properties of a collection of AWS EBS volumes.

EBS volumes are persistent block storage volumes for Amazon EC2 instances in the AWS Cloud.

For additional information, including details on parameters and properties, see the [AWS documentation on EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 Ensure you have exactly three volumes.

```ruby
describe aws_ebs_volumes do
  its('VOLUME_ID_COUNT') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`attachments`
: The EBS volume attachments returned.

`availability_zones`
: The list of availability zones in use by the EBS volumes.

`create_times`
: The creation times of the EBS volumes.

`encrypted`
: The list of true/false values indicating whether the EBS volumes are encrypted.

`fast_restored`
: The list of true/false values indicating whether the EBS volume is created with a snapshot enabled for fast snapshot restore.

`iops`
: The list of I/O per second for each EBS volume.

`kms_key_ids`
: The list of ARNs for EBS volume KMS keys.

`multi_attach_enabled`
: The list of boolean values indicating whether the EBS volume is multi-attach enabled.

`outpost_arns`
: The list of ARNs of outposts.

`sizes`
: The list of EBS volume sizes.

`snapshot_ids`
: The list of snapshots from which EBS volumes are created.

`states`
: The list of volume states returned.

`tags`
: The list of volume tags returned.

`volume_ids`
: The unique IDs of the EBS volumes returned.

`volume_types`
: The list of volume types returned.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a specific volume exists.**

```ruby
describe aws_ebs_volumes do
  its('VOLUME_IDs') { should include 'VOLUME-12345678' }
end
```

**Request the EBS volumes IDs.**

Test in-depth using `aws_ebs_volume` to ensure all volumes are encrypted and have a sensible size.

```ruby
aws_ebs_volumes.volume_ids.each do |volume_id|
  describe aws_ebs_volume(volume_id) do
    it          { should be_encrypted }
    its('size') { should be > 10 }
    its('iops') { should cmp 100 }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_ebs_volumes do
  it { should exist }
end
```

```ruby
describe aws_ebs_volumes do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVolumesResult" %}}
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
