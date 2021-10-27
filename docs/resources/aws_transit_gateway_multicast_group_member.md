---
title: About the aws_transit_gateway_multicast_group_member Resource
platform: aws
---

# aws\_transit\_gateway\_multicast\_group\_member

Use the `aws_transit_gateway_multicast_group_member` InSpec audit resource to test properties of a single specific AWS EC2 transit gateway multicast group member.

The `AWS::EC2::TransitGatewayMulticastGroupMember` resource registers members (network interfaces) with the transit gateway multicast group.

## Syntax

Ensure that transit gateway group member exists.

    describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should exist }
    end

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

The transit_gateway_multicast_domain_id is the ID of the multicast domain transit gateway.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayMulticastGroupMember](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupmember.html).

## Properties

| Property | Description|
| --- | --- |
| group_ip_address | The IP address of the transit gateway multicast group. |
| transit_gateway_attachment_id | The attachment ID of the transit gateway. |
| subnet_id | The ID of the subnet. |
| resource_id | The ID of the resource. |
| resource_type | The type of the resource. |
| resource_owner_id | The Owner ID of the resource. |
| network_interface_id | The network interface ID of the resource. |
| group_member | The resource is a group member. Valid values are `true` and `false`. |
| group_source | The resource is a group source. Valid values are `true` and `false`. |
| member_type | The member type. Valid values are `igmp` and `static`. |
| source_type | The source type. Valid values are `igmp` and `static`. |

## Examples

### Ensure a group IP address is available.

    describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      its('group_ip_address') { should eq 'GROUP_IP_ADDRESS' }
    end

### Ensure that the resource type is `vpc`.

    describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
        its('resource_type') { should eq 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_transit_gateway_multicast_group_member(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:SearchTransitGatewayMulticastGroupsResult` action with `Effect` set to `Allow`.
