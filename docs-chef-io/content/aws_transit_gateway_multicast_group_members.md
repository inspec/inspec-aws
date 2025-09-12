+++
title = "aws_transit_gateway_multicast_group_members resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_transit_gateway_multicast_group_members"
identifier = "inspec/resources/aws/aws_transit_gateway_multicast_group_members resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_multicast_group_members` Chef InSpec audit resource to test properties of multiple AWS EC2 transit gateway multicast group members.

The `AWS::EC2::TransitGatewayMulticastGroupMember` resource registers members (network interfaces) with the transit gateway multicast group.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayMulticastGroupMember](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupmember.html).

## Syntax

Ensure that transit gateway multicast group member exists.

```ruby
describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
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
: The attachment id of the transit gateway.

: **Field**: `transit_gateway_attachment_id`

`subnet_ids`
: The ID of the subnet.

: **Field**: `subnet_id`

`resource_ids`
: The ID of the resource.

: **Field**: `resource_id`

`resource_types`
: The type of the resource.

: **Field**: `resource_type`

`resource_owner_ids`
: The Owner ID of the resource.

: **Field**: `resource_owner_id`

`network_interface_ids`
: The network interface ID of the resource.

: **Field**: `network_interface_id`

`group_members`
: The resource is a group member. Valid values are `true` and `false`.

: **Field**: `group_member`

`group_sources`
: The resource is a group source. Valid values are `true` and `false`.

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
describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ATTACHMENT_ID' }
end
```

Ensure that the group members are available:

```ruby
describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
    its('group_members') { should include true }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:SearchTransitGatewayMulticastGroupsResult" %}}
