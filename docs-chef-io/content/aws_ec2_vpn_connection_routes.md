+++
title = "aws_ec2_vpn_connection_routes resource"

draft = false


[menu.aws]
title = "aws_ec2_vpn_connection_routes"
identifier = "inspec/resources/aws/aws_ec2_vpn_connection_routes resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_vpn_connection_routes` InSpec audit resource to test properties of multiple AWS EC2 VPN connection routes.

The `AWS::EC2::VPNConnectionRoute` resource specifies a static route for a VPN connection between an existing virtual private gateway and a VPN customer gateway. The static route allows traffic to be routed from the virtual private gateway to the VPN customer gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 VPN Connection Route.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-connection-route.html).

## Syntax

Ensure that VPN Connection ID exists.

```ruby
describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'VPN_CONNECTION_ID') do
  it { should exist }
end
```

## Parameters

`vpn_connection_id` _(required)_

: The ID of the VPN Connection.

## Properties

`destination_cidr_blocks`
: The CIDR block associated with the local subnet of the customer data center.

: **Field**: `destination_cidr_block`

`sources`
: Indicates how the routes were provided.

: **Field**: `source`

`states`
: The current state of the static route.

: **Field**: `state`

## Examples

Ensure a destination CIDR block is available:

```ruby
describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'VPN_CONNECTION_ID') do
  its('destination_cidr_blocks') { should eq [['CIDR_BLOCK']] }
end
```

Ensure that a VPN connection route is `available`:

```ruby
describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'VPN_CONNECTION_ID') do
    its('states') { should eq [['available']] }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'VPN_CONNECTION_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_vpn_connection_routes(vpn_connection_id: 'VPN_CONNECTION_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpnConnectionsResult" %}}
