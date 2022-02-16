---
title: About the aws_transit_gateway_multicast_group_source Resource
platform: aws
---

# aws\_transit\_gateway\_multicast\_group\_source

Use the `aws_transit_gateway_multicast_group_source` InSpec audit resource to test properties of a single source (network interface) of an AWS EC2 transit gateway multicast domain group.

The `AWS::EC2::TransitGatewayMulticastGroupSource` resource registers sources (network interfaces) with the specified transit gateway multicast domain.

## Syntax

Ensure that a transit gateway group source exists.

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should exist }
    end

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

The ID of the transit gateway multicast domain.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayMulticastGroupSource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastgroupsource.html).

## Properties

| Property | Description |
| :---: | :--- |
| group_ip_address | The IP address of the transit gateway multicast group. |
| transit_gateway_attachment_id | The attachment ID of the transit gateway. |
| subnet_id | The ID of the subnet. |
| resource_id | The ID of the resource. |
| resource_type | The type of the resource. Valid values are `vpc`, `vpn`, `direct-connect-gateway`, and `tgw-peering`.|
| resource_owner_id | The owner ID of the resource. |
| network_interface_id | The network interface ID of the resource. |
| group_member | Whether the resource is a group member. Valid values are `true` and `false`. |
| group_source | Whether the resource is a group source. Valid values are `true` and `false`. |
| member_type | The member type. Valid values are `igmp` and `static`. |
| source_type | The source type. Valid values are `igmp` and `static`. |

## Examples

### Ensure a group IP address is available.

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      its('group_ip_address') { should eq 'IP_ADDRESS' }
    end

### Ensure that the resource type is `vpc`.

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
        its('resource_type') { should eq 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `search` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_transit_gateway_multicast_group_source(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:SearchTransitGatewayMulticastGroupsResult` action with `Effect` set to `Allow`.