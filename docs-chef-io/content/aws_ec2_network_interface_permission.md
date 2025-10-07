+++
title = "aws_ec2_network_interface_permission resource"

draft = false


[menu.aws]
title = "aws_ec2_network_interface_permission"
identifier = "inspec/resources/aws/aws_ec2_network_interface_permission resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_network_interface_permission` InSpec audit resource to test the properties of a single specific AWS EC2 network interface permission.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 Network Interface Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinterfacepermission.html).

## Syntax

Ensure that network interface permission ID exists.

```ruby
describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
  it { should exist }
end
```

## Parameters

`network_interface_permission_id` _(required)_

: The ID of the network interface permission.

## Properties

`network_interface_permission_id`
: The ID of the network interface.

`network_interface_id`
: The Amazon Web Services account ID.

`aws_account_id`
: The Amazon Web Service. Currently not supported.

`state`
: The state of the permission. Valid values are: "pending", "granted", "revoking", "revoked".

`status_message`
: The status message of the permission state.

## Examples

Ensure a network interface permission ID is available:

```ruby
describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
  its('network_interface_permission_id') { should eq 'NETWORK_INTERFACE_PERMISSION_ID' }
end
```

Ensure that the interface permission state is 'pending':

```ruby
describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
    its('state') { should eq 'pending' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NETWORK_INTERFACE_PERMISSION_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeNetworkInterfacePermissionsResult" %}}
