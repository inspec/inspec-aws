+++
title = "aws_vpn_connections Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_vpn_connections"
identifier = "inspec/resources/aws/aws_vpn_connections Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpn_connections` InSpec audit resource to test properties of all AWS VPN Connections.

For additional information, including details on parameters and properties, see the [AWS documentation on VPN Connections](https://docs.aws.amazon.com/vpc/latest/userguide/vpn-connections.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that one or more VPN Connections exist.

```ruby
describe aws_vpn_connections do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`vpn_connection_ids`
: This property provides all the IDs of the VPN Connections.

`vpn_gateway_ids`
: This property provides all the IDs of the virtual private gateways associated with the VPN Connections.

`outside_ip_addresses`
: This property provides the outside IP addresses of the VPN Connections.

`tunnel_inside_cidrs`
: This property provides the tunnel inside cidrs of the VPN Connections.

`states`
: This property provides the current state of the VPN Connections.

`types`
: This property provides the current types of the VPN Connections.

`tags`
: This property provids the current tags of the VPN Connections.

## Examples

**Ensure that VPN connections are available.**

```ruby
describe aws_vpn_connections do
  its('state.uniq') { should eq ['available'] }
end
```

**Check tags    .**

```ruby
describe aws_vpn_connections.where { tags["Name"] == "vpn-connection-example-123" } do
  it { should exist }
  its('count') { should be 3 }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_vpn_connections do
  it { should exist }
end
```

```ruby
describe aws_vpn_connections do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="EC2:Client:DescribeVpnConnectionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
