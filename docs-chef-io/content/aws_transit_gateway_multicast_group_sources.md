+++
title = "aws_transit_gateway_multicast_group_sources resource"

draft = false


[menu.aws]
title = "aws_transit_gateway_multicast_group_sources"
identifier = "inspec/resources/aws/aws_transit_gateway_multicast_group_sources resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_multicast_group_sources` InSpec audit resource to test properties of the sources (network interfaces) of multiple AWS EC2 transit gateway multicast domain groups.

The `AWS::EC2::TransitGatewayMulticastGroupSource` resource registers sources (network interfaces) with the specified transit gateway multicast domain.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayMulticastGroupSource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupsource.html).

## Syntax

Ensure that a transit gateway multicast group source exists.

```ruby
describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should exist }
end
```

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

: The ID of the transit gateway multicast domain.

## Properties

`group_ip_addresses`
: The IP address of the transit gateway multicast group.

: **Field**: `group_ip_address`

`transit_gateway_attachment_ids`
: The attachment ID of the transit gateway.

: **Field**: `transit_gateway_attachment_id`

`subnet_ids`
: The ID of the subnet.

: **Field**: `subnet_id`

`resource_ids`
: The ID of the resource.

: **Field**: `resource_id`

`resource_types`
: The type of the resource. Valid values are `vpc`, `vpn`, `direct-connect-gateway`, and `tgw-peering`.

: **Field**: `resource_type`

`resource_owner_ids`
: The Owner ID of the resource.

: **Field**: `resource_owner_id`

`network_interface_ids`
: The network interface ID of the resource.

: **Field**: `network_interface_id`

`group_members`
: Wether the resource is a group member. Valid values are `true` and `false`.

: **Field**: `group_member`

`group_sources`
: Wether the resource is a group source. Valid values are `true` and `false`.

: **Field**: `group_source`

`member_types`
: The member type. Valid values are `igmp` and `static`.

: **Field**: `member_type`

`source_types`
: The source type. Valid values are `igmp` and `static`.

: **Field**: `source_type`

## Examples

Ensure a transit gateway attachment ID is available:

```ruby
describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  its('transit_gateway_attachment_ids') { should include 'ATTACHMENT_ID' }
end
```

Ensure that a group source is available:

```ruby
describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
    its('group_sources') { should include true }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_transit_gateway_multicast_group_sources(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:SearchTransitGatewayMulticastGroupsResult" %}}
