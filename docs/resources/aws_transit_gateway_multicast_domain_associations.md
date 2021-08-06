---
title: About the aws_transit_gateway_multicast_domain_associations Resource
platform: aws
---

# aws\_transit\_gateway\_multicast\_domain\_associations

Use the `aws_transit_gateway_multicast_domain_associations` InSpec audit resource to test properties of a plural AWS EC2 TransitGatewayMulticastDomainAssociation.

The AWS::EC2::TransitGatewayMulticastDomainAssociation resource associates the specified subnets and transit gateway attachments with the specified transit gateway multicast domain.

## Syntax

Ensure that transit gateway connect exists.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
      it { should exist }
    end

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

The transit_gateway_multicast_domain_id is the ID of the transit gateway multicast domain.

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayMulticastDomainAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomainassociation.html).

## Properties

| Property | Description|
| --- | --- |
| transit_gateway_attachment_ids | The ID of the Connect attachment. |
| resource_ids | The ID of the resource. |
| resource_types | The type of resource, for example a VPC attachment. |
| resource_owner_ids | The ID of the AWS account that owns the transit gateway multicast domain association resource. |
| subnets | The subnet associated with the transit gateway multicast domain. |

## Examples

### Ensure a transit gateway attachment id is available.
    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
      its('transit_gateway_attachment_ids') { should include 'tgw-attach-1234567890' }
    end

### Ensure that the resource type is `vpc`.
    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
        its('resource_types') { should include 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "tgw-mcast-domain-1234567890") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:get_transit_gateway_multicast_domain_associations` action with `Effect` set to `Allow`.