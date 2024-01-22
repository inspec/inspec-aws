+++
title = "aws_ec2_vpn_gateway_route_propagations Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_vpn_gateway_route_propagations"
identifier = "inspec/resources/aws/aws_ec2_vpn_gateway_route_propagations Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_vpn_gateway_route_propagations` InSpec audit resource to test if virtual private gateways can propagate routes to multiple AWS EC2 route tables.

The `AWS::EC2::VPNGatewayRoutePropagation` resource enables a virtual private gateway (VGW) to propagate routes to the specified route table of a VPC.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 VPNGatewayRoutePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gatewayrouteprop.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a route table exists.

```ruby
describe aws_ec2_vpn_gateway_route_propagations do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`route_table_ids`
: The ID of the route table.

: **Field**: `route_table_id`

`propagating_vgws_gateway_ids`
: The ID of the virtual private gateway.

: **Field**: `propagating_vgws_gateway_ids`

## Examples

**Ensure a VPN gateway ID is available.**

```ruby
describe aws_ec2_vpn_gateway_route_propagations do
  its('propagating_vgws_gateway_ids') { should include 'VPN_GATEWAY_ID' }
end
```

**Ensure a route table ID is available.**

```ruby
describe aws_ec2_vpn_gateway_route_propagations do
    its('route_table_ids') { should include 'ROUTE_TABLE_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_vpn_gateway_route_propagations do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_vpn_gateway_route_propagations do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_vpn_gateway_route_propagations do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeRouteTablesResult" %}}
