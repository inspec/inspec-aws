---
title: About the aws_transit_gateway_multicast_domain Resource
platform: aws
---

# aws\_transit\_gateway\_multicast\_domain

Use the `aws_transit_gateway_multicast_domain` Chef InSpec audit resource to test properties of an AWS EC2 transit gateway multicast domain.

The `AWS::EC2::TransitGatewayMulticastDomain` resource creates a multicast domain using the specified transit gateway.

## Syntax

Ensure that transit gateway connect exists.

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should exits }
    end

## Parameters

`transit_gateway_attachment_id` _(required)_

The ID of the transit gateway multicast domain.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayConnect](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayconnect.html).

## Properties

| Property | Description|
| --- | --- |
| transit_gateway_multicast_domain_id | The ID of the transit gateway multicast domain. |
| transit_gateway_id | The ID of the transit gateway. |
| transit_gateway_multicast_domain_arn | The Amazon Resource Name (ARN) of the transit gateway multicast domain. |
| owner_id | The ID of the AWS account that owns the transit gateway multicast domain. |
| options (igmpv_2_support) | The options for the transit gateway multicast domain. Indicates whether Internet Group Management Protocol (IGMP) version 2 is turned on for the transit gateway multicast domain. |
| options (static_sources_support) | The options for the transit gateway multicast domain. Indicates whether support for statically configuring transit gateway multicast group sources is turned on. |
| options (auto_accept_shared_associations) | The options for the transit gateway multicast domain. Indicates whether to automatically cross-account subnet associations that are associated with the transit gateway multicast domain. |
| state | The state of the transit gateway multicast domain. |
| creation_time | The time the transit gateway multicast domain was created. |
| tags | The tags for the transit gateway multicast domain. |

## Examples

### Ensure a transit gateway multicast domain ID is available.

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      its('transit_gateway_multicast_domain_id') { should eq 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID' }
    end

### Ensure that the state is `available`.

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should exits }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should_not exits }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_transit_gateway_multicast_domain(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeTransitGatewayMulticastDomainsResult` action with `Effect` set to `Allow`.