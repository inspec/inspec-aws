---
title: About the aws_transit_gateway_multicast_group_members Resource
platform: aws
---

# aws\_transit\_gateway\_multicast\_group\_members

Use the `aws_transit_gateway_multicast_group_members` Chef InSpec audit resource to test properties of multiple AWS EC2 transit gateway multicast group members.

The `AWS::EC2::TransitGatewayMulticastGroupMember` resource registers members (network interfaces) with the transit gateway multicast group.

## Syntax

Ensure that transit gateway multicast group member exists.

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should exist }
    end

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

The ID of the transit gateway multicast domain.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayMulticastGroupMember](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupmember.html).

## Properties

| Property | Description | Field Name |
| --- | --- | --- |
| group_ip_addresses | The IP address of the transit gateway multicast group. | group_ip_address |
| transit_gateway_attachment_ids | The attachment id of the transit gateway. | transit_gateway_attachment_id |
| subnet_ids | The ID of the subnet. | subnet_id |
| resource_ids | The ID of the resource. | resource_id |
| resource_types | The type of the resource. | resource_type |
| resource_owner_ids | The Owner ID of the resource. | resource_owner_id |
| network_interface_ids | The network interface ID of the resource. | network_interface_id |
| group_members | The resource is a group member. Valid values are `true` and `false`. | group_member |
| group_sources | The resource is a group source. Valid values are `true` and `false`. | group_source |
| member_types | The member type. Valid values are `igmp` and `static`. | member_type |
| source_types | The source type. Valid values are `igmp` and `static`. | source_type |

## Examples

### Ensure a transit gateway attachment ID is available.

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ATTACHMENT_ID' }
    end

### Ensure that the group members are available.

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
        its('group_members') { should include true }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_transit_gateway_multicast_group_members(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:SearchTransitGatewayMulticastGroupsResult` action with `Effect` set to `Allow`.
