+++
title = "aws_ec2_volume_attachments resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_volume_attachments"
identifier = "inspec/resources/aws/aws_ec2_volume_attachments resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_volume_attachments` InSpec audit resource to test properties of multiple AWS EC2 volume attachments.

The `AWS::EC2::VolumeAttachment` resource attaches an Amazon EBS volume to a running instance and exposes it to the instance with the specified device name.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Volume Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volumeattachment.html).

## Syntax

Ensure that volume attachment exists.

```ruby
describe aws_ec2_volume_attachments do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`attach_times`
: The time stamp when the attachment initiated.

: **Field**: `attach_time`

`devices`
: The device name.

: **Field**: `device`

`instance_ids`
: The ID of the instance.

: **Field**: `instance_id`

`states`
: The attachment state of the volume.

: **Field**: `state`

`volume_ids`
: The ID of the volume.

: **Field**: `volume_id`

`delete_on_terminations`
: Indicates whether the EBS volume is deleted on instance termination.

: **Field**: `delete_on_termination`

## Examples

**Ensure a device is available.**

```ruby
describe aws_ec2_volume_attachments do
  its('devices') { should include '/dev/sdf' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_ec2_volume_attachments do
    its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_volume_attachments do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_volume_attachments do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVolumesResult" %}}
