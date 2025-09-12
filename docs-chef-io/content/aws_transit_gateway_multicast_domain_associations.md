+++
title = "aws_transit_gateway_multicast_domain_associations resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_transit_gateway_multicast_domain_associations"
identifier = "inspec/resources/aws/aws_transit_gateway_multicast_domain_associations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_multicast_domain_associations` Chef InSpec audit resource to test properties of multiple AWS EC2 transit gateway multicast domain associations.

The `AWS::EC2::TransitGatewayMulticastDomainAssociation` resource associates the specified subnets and transit gateway attachments with the specified transit gateway multicast domain.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayMulticastDomainAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomainassociation.html).

## Syntax

Ensure that transit gateway connect exists.

```ruby
describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  it { should exist }
end
```

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

: The ID of the transit gateway multicast domain.

## Properties

`transit_gateway_attachment_ids`
: The ID of the transit gateway attachment.

`resource_ids`
: The ID of the resource.

`resource_types`
: The type of resource, for example a VPC attachment.

`resource_owner_ids`
: The ID of the AWS account that owns the transit gateway multicast domain association resource.

`subnets`
: The subnet associated with the transit gateway multicast domain.

## Examples

**Ensure a transit gateway attachment ID is available.**

```ruby
describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ATTACHMENT_ID' }
end
```

**Ensure that the resource type is `vpc`.**

```ruby
describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
    its('resource_types') { should include 'vpc' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_transit_gateway_multicast_domain_associations(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetTransitGatewayMulticastDomainAssociationsResult" %}}
