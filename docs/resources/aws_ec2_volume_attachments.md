---
title: About the aws_ec2_volume_attachments Resource
platform: aws
---

# aws\_ec2\_volume\_attachments

Use the `aws_ec2_volume_attachments` InSpec audit resource to test properties of multiple AWS EBS volume attachments to running instances.

The `AWS::EC2::VolumeAttachment` resource attaches an Amazon EBS volume to a running instance and exposes it to the instance with the specified device name.

## Syntax

Ensure that a volume id exists.

    describe aws_ec2_volume_attachments(volume_id: 'VOLUME_ID') do
      it { should exist }
    end

## Parameters

`volume_id` _(required if name not provided)_

The volume ID.

`name` _(required if volume_id not provided)_

The volume name.

For additional information, see the [AWS documentation on AWS EC2 Volume Attachments](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_VolumeAttachment.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| attach_times | A list of the time stamps when the attachment is initiated. | attach_time |
| devices | A list of the device names specified in the block device mapping (for example, `/dev/sda1` ). | device |
| instance_ids | A list of the instance IDs of that the volume is attached to. | instance_id |
| states | A list of the attachment states. | state |
| volume_ids | A list of the volume IDs. | volume_id |
| delete_on_terminations | A list indicating whether the EBS volumes are deleted on instance termination. | delete_on_termination |

## Examples

### Ensure a volume ID is available.

    describe aws_ec2_volume_attachments(volume_id: 'VOLUME_ID') do
      its('volume_ids') { should include 'VOLUME_ID' }
    end

### Ensure that the device is `/dev/sda1`.

    describe aws_ec2_volume_attachments(volume_id: 'VOLUME_ID') do
        its('devices') { should include '/dev/sda1' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_volume_attachments(volume_id: 'VOLUME_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_volume_attachments(volume_id: 'VOLUME_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_volume_attachments(volume_id: 'VOLUME_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVolumesResult` action with `Effect` set to `Allow`.
