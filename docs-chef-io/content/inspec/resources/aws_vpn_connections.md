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

Use the `aws_vpn_connections` InSpec audit resource to test the properties of all AWS VPN connections.

For additional information, including details on parameters and properties, see the [AWS documentation on VPN Connections](https://docs.aws.amazon.com/vpc/latest/userguide/vpn-connections.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that one or more VPN connections exist.

```ruby
describe aws_vpn_connections do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`vpn_connection_ids`
: This property provides all the IDs of the VPN connections.

`vpn_gateway_ids`
: This property provides all the IDs of the virtual private gateways associated with the VPN connections.

`outside_ip_addresses`
: This property provides the outside IP addresses of the VPN connections.

`tunnel_inside_cidrs`
: This property provides the tunnel inside CIDRs of the VPN connections.

`states`
: This property provides the current state of the VPN connections.

`types`
: This property provides the current types of VPN connections.

`tags`
: This property provides the current tags of the VPN connections.

## Examples

### Ensure that VPN connections are available

```ruby
describe aws_vpn_connections do
  its('state.uniq') { should eq ['available'] }
end
```

### To check tags

```ruby
describe aws_vpn_connections.where { tags["Name"] == "vpn-connection-example-123" } do
  it { should exist }
  its('count') { should be 3 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control passes if the describe returns at least one result.

```ruby
describe aws_vpn_connections do
  it { should exist }
end
```

### not exists

Use `should_not` to test whether the entity should not exist.

```ruby
describe aws_vpn_connections do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpnConnectionsResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
