+++
title = "aws_transit_gateway_multicast_group_member Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_transit_gateway_multicast_group_member"
identifier = "inspec/resources/aws/aws_transit_gateway_multicast_group_member Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_multicast_group_member` InSpec audit resource to test properties of a single specific AWS EC2 transit gateway multicast group member.

The `AWS::EC2::TransitGatewayMulticastGroupMember` resource registers members (network interfaces) with the transit gateway multicast group.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayMulticastGroupMember](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupmember.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that transit gateway group member exists.

```ruby
describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should exist }
end
```

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

: The transit_gateway_multicast_domain_id is the ID of the multicast domain transit gateway.

## Properties

`group_ip_address`
: The IP address of the transit gateway multicast group.

`transit_gateway_attachment_id`
: The attachment ID of the transit gateway.

`subnet_id`
: The ID of the subnet.

`resource_id`
: The ID of the resource.

`resource_type`
: The type of the resource.

`resource_owner_id`
: The Owner ID of the resource.

`network_interface_id`
: The network interface ID of the resource.

`group_member`
: The resource is a group member. Valid values are `true` and `false`.

`group_source`
: The resource is a group source. Valid values are `true` and `false`.

`member_type`
: The member type. Valid values are `igmp` and `static`.

`source_type`
: The source type. Valid values are `igmp` and `static`.

## Examples

**Ensure a group IP address is available.**

```ruby
describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  its('group_ip_address') { should eq 'GROUP_IP_ADDRESS' }
end
```

**Ensure that the resource type is `vpc`.**

```ruby
describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
    its('resource_type') { should eq 'vpc' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "dummy") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:SearchTransitGatewayMulticastGroupsResult" %}}
