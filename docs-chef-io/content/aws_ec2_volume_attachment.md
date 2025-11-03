+++
title = "aws_ec2_volume_attachment resource"

draft = false


[menu.aws]
title = "aws_ec2_volume_attachment"
identifier = "inspec/resources/aws/aws_ec2_volume_attachment resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_volume_attachment` InSpec audit resource to test properties of a single specific AWS EC2 volume attachment.

The `AWS::EC2::VolumeAttachment` resource attaches an Amazon EBS volume to a running instance and exposes it to the instance with the specified device name.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Volume Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volumeattachment.html).

## Syntax

Ensure that volume attachment exists.

```ruby
describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
  it { should exist }
end
```

## Parameters

`volume_id` _(required)_

: The volume ID.

## Properties

`attach_time`
: The time stamp when the attachment initiated.

`device`
: The device name.

`instance_id`
: The ID of the instance.

`state`
: The attachment state of the volume.

`volume_id`
: The ID of the volume.

`delete_on_termination`
: Indicates whether the EBS volume is deleted on instance termination.

## Examples

Ensure a device is available:

```ruby
describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
  its('device') { should eq '/dev/sdf' }
end
```

Ensure that the state is `available`:

```ruby
describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_volume_attachment(volume_id: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVolumesResult" %}}
