+++
title = "aws_vpn_connection Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_vpn_connection"
identifier = "inspec/resources/aws/aws_vpn_connection Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpn_connection` InSpec audit resource to test the properties of a single AWS VPN connection.

## Installation

{{% inspec_aws_install %}}

## Syntax

An `aws_vpn_connection` resource block declares the tests for a single AWS VPN connection by `vpn_connection_id`.

```ruby
describe aws_vpn_connection(vpn_connection_id: 'vpn-1234567890') do
  it { should exist }
end
```

```ruby
describe aws_vpn_connection('vpn-1234567890') do
  it { should exist }
end
```

## Parameters

`vpn_connection_id` _(required)_
: The identifier of the AWS VPN connection. It can be passed either as a string or as a `vpn_connection_id: 'value'` hash key-value entry.

## Properties

`vpn_connection_id`
: The identifier of the AWS VPN connection.

`state`
: The current state of the VPN connection. Possible values are: `pending`, `available`, `deleting`, and `deleted`.

`type`
: The type of VPN connection that the VPN connection supports.

`vpn_gateway_id`
: The ID of the associated VPN.

`tags`
: All tags that are associated with the VPN connection.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Types/VpnConnection.html).

## Examples

### Test that a VPN connection is available

```ruby
describe aws_vpn_connection('vpn-1234567890') do
    its('vpn_connection_id') { should eq 'vpn-1234567890' }
end
```

### Test that a VPN connection status is available

```ruby
describe aws_vpn_connection('vpn-1234567890') do
    its('status') { should eq 'available' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_vpn_connection('vpn-1234567890') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_vpn_connection('vpn-1234567890') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="EC2:Client:DescribeVpnConnectionsResult" %}}
