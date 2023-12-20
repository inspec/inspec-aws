+++
title = "aws_ec2_network_interface_permissions Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_network_interface_permissions"
identifier = "inspec/resources/aws/aws_ec2_network_interface_permissions Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_interface_permissions` InSpec audit resource to test properties of multiple AWS EC2 network interface permission.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that network interface permission ID exists.

```ruby
describe aws_ec2_network_interface_permissions do
  it { should exist }
end
```

For additional information, see the [AWS documentation on AWS EC2 Network Interface Permissions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission.html).

## Parameters

This resource does not require any parameters.

## Properties

`network_interface_permission_ids`
: The ID of the network interface.

: **Field**: `network_interface_permission_id`

`network_interface_ids`
: The Amazon Web Services account ID.

: **Field**: `network_interface_id`

`aws_account_ids`
: The Amazon Web Service. Currently not supported.

: **Field**: `aws_account_id`

`states`
: The state of the permission.  String, one of "pending", "granted", "revoking", "revoked".

: **Field**: `state`

`status_messages`
: The status message of the permission state.

: **Field**: `status_message`

## Examples

**Ensure a network interface permission ID is available.**

```ruby
describe aws_ec2_network_interface_permissions do
  its('network_interface_permission_ids') { should include 'NETWORK_INTERFACE_PERMISSION_ID' }
end
```

**Ensure that the interface permission state is 'pending'.**

```ruby
describe aws_ec2_network_interface_permissions do
    its('states') { should include 'pending' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_interface_permissions do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_interface_permissions do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_network_interface_permissions do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInterfacePermissionsResult" %}}
