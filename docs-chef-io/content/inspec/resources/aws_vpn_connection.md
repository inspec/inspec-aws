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
describe aws_vpn_connection(vpn_connection_id: 'vpn-01234567') do
  it { should exist }
end
```

The value of the `vpn_connection_id` can be provided as a string.

```ruby
describe aws_vpn_connection('vpn-01234567') do
  it { should exist }
end
```

## Parameters

The AWS VPN connection ID is required.

`vpn_connection_id` _(required)_

: It can be passed either as a string or as a `vpn_connection_id: 'value'` key-value entry in a hash.

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

### Test that a VPN Connection is available

```ruby
describe aws_vpn_connection('vpn-01234567') do
    its('status') { should eq 'available' }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

```ruby
describe aws_vpn_connection('vpn-01234567') do
    it { should exist }
end
```

### VPN Gateway

```ruby
describe aws_vpn_connection('vpn-01234567') do
    its('vpn_gateway_id') { should eq 'vpc-0a510beed76210f2f'}
end
```

## AWS Permissions

{{% aws_permissions_principal action="EC2:Client:DescribeVpnConnectionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
