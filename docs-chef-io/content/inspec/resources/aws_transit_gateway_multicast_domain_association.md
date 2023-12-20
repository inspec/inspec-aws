+++
title = "aws_transit_gateway_multicast_domain_association Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_transit_gateway_multicast_domain_association"
identifier = "inspec/resources/aws/aws_transit_gateway_multicast_domain_association Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_multicast_domain_association` Chef InSpec audit resource to test properties of a single AWS EC2 transit gateway multicast domain association.

The `AWS::EC2::TransitGatewayMulticastDomainAssociation` resource associates the specified subnets and transit gateway attachments with the specified transit gateway multicast domain.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayMulticastDomainAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomainassociation.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the transit gateway multicast domain association exists.

```ruby
describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  it { should exits }
end
```

## Parameters

`transit_gateway_multicast_domain_id` _(required)_

: The ID of the transit gateway multicast domain.

## Properties

`transit_gateway_attachment_id`
: The ID of the Connect attachment.

`resource_id`
: The ID of the resource.

`resource_type`
: The type of resource, for example a VPC attachment.

`resource_owner_id`
: The ID of the AWS account that owns the transit gateway multicast domain association resource.

`subnet (subnet_id)`
: The subnet associated with the transit gateway multicast domain. The ID of the subnet.

`subnet (state)`
: The subnet associated with the transit gateway multicast domain. The state of the subnet association.

## Examples

**Ensure a transit gateway attachment ID is available.**

```ruby
describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  its('transit_gateway_attachment_id') { should eq 'tgw-attach-1234567890' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
    its('subnet.state') { should eq 'associated' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  it { should exits }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: "TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID") do
  it { should_not exits }
end
```

### be_available

Use `should` to check if the transit gateway multicast domain association is available.

```ruby
describe aws_transit_gateway_multicast_domain_association(transit_gateway_multicast_domain_id: 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetTransitGatewayMulticastDomainAssociationsResult" %}}
