+++
title = "aws_efs_mount_targets Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_efs_mount_targets"
identifier = "inspec/resources/aws/aws_efs_mount_targets Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_efs_mount_targets` InSpec audit resource to test properties of a plural EFS Mount Targets.

The AWS::EFS::MountTarget resource is an Amazon EFS resource that creates a mount target for an EFS file system. You can then mount the file system on Amazon EC2 instances or other resources by using the mount target.

For additional information, including details on parameters and properties, see the [AWS documentation on EFS Mount Target](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-efs-mounttarget.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that a file system exists.

```ruby
describe aws_efs_mount_targets(file_system_id: "FILE_SYSTEM_ID") do
  it { should exist }
end
```

## Parameters

`file_system_ids` _(required)_

## Properties

`owner_ids`
: The owner IDs of the mount targets.

`mount_target_ids`
: IDs of the file system whose mount targets you want to list (String).

`file_system_ids`
: The IDs of the file system for which to create the mount target.

`life_cycle_states`
: The life cycle states of the mount targets.

`ip_addresses`
: Valid IPv4 addresses within the address range of the specified subnet.

`network_interface_ids`
: The network interface IDs of the mount targets.

`availability_zone_ids`
: The availability zone IDs of the mount targets.

`availability_zone_names`
: The availability zone names of the mount targets.

`vpc_ids`
: The vpc IDs of the mount targets.

## Examples

**Ensure a owner ID is available.**

```ruby
describe aws_efs_mount_targets(file_system_id: "FILE_SYSTEM_ID") do
  its('owner_ids') { should include 'OWNER_ID' }
end
```

**Ensure that the IP address is available.**

```ruby
describe aws_efs_mount_targets(file_system_id: "FILE_SYSTEM_ID") do
    its('ip_addresses') { should include 'IP_ADDRESS' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.
```ruby
describe aws_efs_mount_targets(file_system_id: "FILE_SYSTEM_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.
```ruby
describe aws_efs_mount_targets(file_system_id: "FILE_SYSTEM_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the file system is available.
```ruby
describe aws_efs_mount_targets(file_system_id: "FILE_SYSTEM_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% aws_permissions_principal action="EFS:Client:DescribeMountTargetsResponse" %}}
