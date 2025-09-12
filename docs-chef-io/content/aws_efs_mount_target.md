+++
title = "aws_efs_mount_target resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_efs_mount_target"
identifier = "inspec/resources/aws/aws_efs_mount_target resource"
parent = "inspec/resources/aws"
+++

Use the `aws_efs_mount_target` InSpec audit resource to test properties of a single specific EFS Mount Target.

The AWS::EFS::MountTarget resource is an Amazon EFS resource that creates a mount target for an EFS file system. You can then mount the file system on Amazon EC2 instances or other resources by using the mount target.

For additional information, including details on parameters and properties, see the [AWS documentation on EFS Mount Target](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget.html).

## Syntax

Ensure that a mount target id exists.

```ruby
describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
  it { should exist }
end
```

## Parameters

`mount_target_id` _(required)_

## Properties

`owner_id`
: The owner ID of the mount targets.

`mount_target_id`
: ID of the file system whose mount targets you want to list (String).

`file_system_id`
: The ID of the file system for which to create the mount target.

`life_cycle_state`
: The life cycle state of the mount targets.

`ip_address`
: Valid IPv4 address within the address range of the specified subnet.

`network_interface_id`
: The network interface ID of the mount targets.

`availability_zone_id`
: The availability zone ID of the mount targets.

`availability_zone_name`
: The availability zone name of the mount targets.

`vpc_id`
: The VPC ID of the mount targets.

## Examples

Ensure a owner ID is available:

```ruby
describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
  its('owner_id') { should eq '012345678912' }
end
```

Ensure that the life cycle state is available:

```ruby
describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
    its('life_cycle_state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the mount target id is available.

```ruby
describe aws_efs_mount_target(mount_target_id: 'MOUNT_TARGET_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EFS:Client:DescribeMountTargetsResponse" %}}
