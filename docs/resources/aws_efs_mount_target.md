---
title: About the aws_efs_mount_target Resource
platform: aws
---

# aws\_efs\_mount\_target

Use the `aws_efs_mount_target` InSpec audit resource to test properties of a single specific EFS Mount Target.

The AWS::EFS::MountTarget resource is an Amazon EFS resource that creates a mount target for an EFS file system. You can then mount the file system on Amazon EC2 instances or other resources by using the mount target.

## Syntax

Ensure that a mount target id exists.

    describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
      it { should exist }
    end

## Parameters

`mount_target_id` _(required)_

For additional information, see the [AWS documentation on EFS Mount Target](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget.html).

## Properties

| Property | Description |
| :---: | :--- |
| owner_id | The owner ID of the mount targets. |
| mount_target_id | ID of the file system whose mount targets you want to list (String). |
| file_system_id | The ID of the file system for which to create the mount target. |
| life_cycle_state | The life cycle state of the mount targets. |
| ip_address | Valid IPv4 address within the address range of the specified subnet. |
| network_interface_id | The network interface ID of the mount targets. |
| availability_zone_id | The availability zone ID of the mount targets. |
| availability_zone_name | The availability zone name of the mount targets. |
| vpc_id | The VPC ID of the mount targets. |

## Examples

### Ensure a owner ID is available.

    describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
      its('owner_id') { should eq '012345678912' }
    end

### Ensure that the life cycle state is available.

    describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
        its('life_cycle_state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the mount target id is available.

    describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EFS:Client:DescribeMountTargetsResponse` action with `Effect` set to `Allow`.
