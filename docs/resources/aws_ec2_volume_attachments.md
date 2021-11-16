---
title: About the aws_ec2_volume_attachments Resource
platform: aws
---

# aws_ec2_volume_attachments

Use the `aws_ec2_volume_attachments` InSpec audit resource to test properties of multiple AWS EC2 volume attachments.

The `AWS::EC2::VolumeAttachment` resource attaches an Amazon EBS volume to a running instance and exposes it to the instance with the specified device name.

## Syntax

Ensure that volume attachment exists.

    describe aws_ec2_volume_attachments do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS EC2 Volume Attachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-ebs-volumeattachment.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| attach_times | The time stamp when the attachment initiated. | attach_time |
| devices | The device name. | device |
| instance_ids | The ID of the instance. | instance_id |
| states | The attachment state of the volume. | state |
| volume_ids | The ID of the volume. | volume_id |
| delete_on_terminations | Indicates whether the EBS volume is deleted on instance termination. | delete_on_termination |

## Examples

### Ensure a device is available.

    describe aws_ec2_volume_attachments do
      its('devices') { should include '/dev/sdf' }
    end

### Ensure that the state is `available`.

    describe aws_ec2_volume_attachments do
        its('states') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_volume_attachments do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_volume_attachments do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVolumesResult` action with `Effect` set to `Allow`.
