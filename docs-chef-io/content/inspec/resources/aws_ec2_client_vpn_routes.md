+++
title = "aws_ec2_client_vpn_routes Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_client_vpn_routes"
identifier = "inspec/resources/aws/aws_ec2_client_vpn_routes Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_client_vpn_routes` InSpec audit resource to test properties of a single specific AWS EC2 Client VPN route.

The `AWS::EC2::ClientVpnRoute` specifies a network route to add to a Client VPN endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 ClientVpnRoute.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-clientvpnroute.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the client VPN endpoint exists.

```ruby
describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

## Parameters

`client_vpn_endpoint_id` _(required)_

: The ID of the Client VPN endpoint with which the route is associated.

## Properties

`client_vpn_endpoint_ids`
: The ID of the Client VPN endpoint with which the route is associated.

: **Field**: `client_vpn_endpoint_id`

`destination_cidrs`
: The IPv4 address range, in CIDR notation, of the route destination.

: **Field**: `destination_cidr`

`target_subnets`
: The ID of the subnet through which traffic is routed.

: **Field**: `target_subnet`

`types`
: The route type.

: **Field**: `type`

`origins`
: Indicates how the route was associated with the Client VPN endpoint. associate indicates that the route was automatically added when the target network was associated with the Client VPN endpoint.

: **Field**: `origin`

`status_codes`
: The state of the Client VPN endpoint route.

: **Field**: `status.code`

`status_messages`
: A message about the status of the Client VPN endpoint route, if applicable.

: **Field**: `status.message`

`descriptions`
: A brief description of the route.

: **Field**: `carrier_gateway_id`

## Examples

**Ensure a client VPN endpoint ID is available.**

```ruby
describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  its('client_vpn_endpoint_ids') { should include 'CLIENT_VPN_ENDPOINT_ID' }
end
```

**Ensure that the status code is `active`.**

```ruby
describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
    its('status_codes') { should include 'active' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_client_vpn_routes(client_vpn_endpoint_id: "CLIENT_VPN_ENDPOINT_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeClientVpnRoutesResult" %}}
