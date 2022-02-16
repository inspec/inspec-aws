---
title: About the aws_transit_gateway_multicast_domain_associations Resource
platform: aws
---

# aws_transit_gateway_multicast_domain_associations

Use the `aws_transit_gateway_multicast_domain_associations` Chef InSpec audit resource to test properties of multiple AWS EC2 transit gateway multicast domain associations.

The `AWS::EC2::TransitGatewayMulticastDomainAssociation` resource associates the specified subnets and transit gateway attachments with the specified transit gateway multicast domain.

## Syntax

Ensure that transit gateway connect exists.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should exist }
    end

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

The ID of the transit gateway multicast domain.

For additional information, see the [AWS documentation on the `rwgrwgrwgrwg` resource]().

For additional information, see the [AWS documentation on AWS EC2 TransitGatewayMulticastDomainAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomainassociation.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| transit_gateway_attachment_ids | The ID of the transit gateway attachment. | transit_gateway_attachment_id |
| resource_ids | The ID of the resource. | resource_id |
| resource_types | The type of resource, for example a VPC attachment. | resource_type |
| resource_owner_ids | The ID of the AWS account that owns the transit gateway multicast domain association resource. | resource_owner_id |
| subnets | The subnet associated with the transit gateway multicast domain. | subnets |

## Examples

### Ensure a transit gateway attachment ID is available.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ATTACHMENT_ID' }
    end

### Ensure that the resource type is `vpc`.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
        its('resource_types') { should include 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:GetTransitGatewayMulticastDomainAssociationsResult` action with `Effect` set to `Allow`.
