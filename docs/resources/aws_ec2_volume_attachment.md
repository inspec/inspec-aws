---
title: About the aws_ec2_volume_attachment Resource
platform: aws
---

# aws_ec2_volume_attachment

Use the `aws_ec2_volume_attachment` InSpec audit resource to test properties of a single specific AWS EC2 volume attachment.

The `AWS::EC2::VolumeAttachment` resource attaches an Amazon EBS volume to a running instance and exposes it to the instance with the specified device name.

## Syntax

Ensure that volume attachment exists.

    describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
      it { should exist }
    end

## Parameters

`volume_id` _(required)_

The volume ID.

For additional information, see the [AWS documentation on AWS EC2 Volume Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volumeattachment.html).

## Properties

| Property | Description |
| --- | --- |
| attach_time | The time stamp when the attachment initiated. |
| device | The device name. |
| instance_id | The ID of the instance. |
| state | The attachment state of the volume. |
| volume_id | The ID of the volume. |
| delete_on_termination | Indicates whether the EBS volume is deleted on instance termination. |

## Examples

### Ensure a device is available.

    describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
      its('device') { should eq '/dev/sdf' }
    end

### Ensure that the state is `available`.

    describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_volume_attachment(volume_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_volume_attachment(volume_id: 'VOLUME_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVolumesResult` action with `Effect` set to `Allow`.
