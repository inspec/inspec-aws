+++
title = "aws_ec2_client_vpn_route Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_client_vpn_route"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_route Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_route` InSpec audit resource to test properties of a single specific AWS EC2 Client VPN route.

The `AWS::EC2::ClientVpnRoute` specifies a network route to add to a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 ClientVpnRoute.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnroute.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the client VPN endpoint exists.

```ruby
describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
  it { should exist }
end
```

## Parameters

`client_vpn_endpoint_id` _(required)_

: The ID of the Client VPN endpoint with which the route is associated.

`target_subnet` _(required)_

: The ID of the subnet through which traffic is routed.

## Properties

`client_vpn_endpoint_id`
: The ID of the Client VPN endpoint with which the route is associated.

: **Field**: `carrier_gateway_id`

`destination_cidr`
: The IPv4 address range, in CIDR notation, of the route destination.

: **Field**: `carrier_gateway_id`

`target_subnet`
: The ID of the subnet through which traffic is routed.

: **Field**: `carrier_gateway_id`

`type`
: The route type.

: **Field**: `carrier_gateway_id`

`origin`
: Indicates how the route was associated with the Client VPN endpoint. associate indicates that the route was automatically added when the target network was associated with the Client VPN endpoint.

: **Field**: `carrier_gateway_id`

`status.code`
: The state of the Client VPN endpoint route.

: **Field**: `carrier_gateway_id`

`status.message`
: A message about the status of the Client VPN endpoint route, if applicable.

: **Field**: `carrier_gateway_id`

`description`
: A brief description of the route.

: **Field**: `carrier_gateway_id`

## Examples

**Ensure a client VPN endpoint ID is available.**

```ruby
describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
  its('client_vpn_endpoint_id') { should eq 'CLIENT_VPN_ENDPOINT_ID' }
end
```

**Ensure that the status code is `active`.**

```ruby
describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
    its('status.code') { should eq 'active' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_route(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID", target_subnet: "TARGET_SUBNET") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnRoutesResult" %}}
