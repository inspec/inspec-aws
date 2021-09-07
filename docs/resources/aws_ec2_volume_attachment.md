---
title: About the aws_ec2_volume_attachment Resource
platform: aws
---

# aws\_ec2\_volume\_attachment

Use the `aws_ec2_volume_attachment` InSpec audit resource to test properties of a single specific AWS EC2 Volume Attachment.

The AWS::EC2::VolumeAttachment resource attaches an Amazon EBS volume to a running instance and exposes it to the instance with the specified device name.

## Syntax

Ensure that a volume id exists.

    describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
      it { should exist }
    end

## Parameters

`volume_id or name` _(required)_

## Properties of the Required Parameter

| Property | Description|
| --- | --- |
| volume_id | The volume ID. |
| name | The volume name. |

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| attach_time | The time stamp when the attachment initiated. | attach_time |
| device | The device name specified in the block device mapping (for example, /dev/sda1 ). | device |
| instance_id | The ID of the instance the volume is attached to. | instance_id |
| state | The attachment state. | state |
| volume_id | The volume ID. | volume_id |
| delete_on_termination | Whether the volume is deleted on instance termination. | delete_on_termination |

## Examples

### Ensure a volume id is available.
    describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
      its('volume_id') { should eq 'vol-1234567890' }
    end

### Ensure that the device is `/dev/sda1`.
    describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
        its('device') { should eq '/dev/sda1' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_volume_attachment(volume_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVolumesResult` action with `Effect` set to `Allow`.