+++
title = "aws_transit_gateway_multicast_domains resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_transit_gateway_multicast_domains"
identifier = "inspec/resources/aws/aws_transit_gateway_multicast_domains resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway_multicast_domains` Chef InSpec audit resource to test properties of multiple AWS EC2 transit gateway multicast domains.

The `AWS::EC2::TransitGatewayMulticastDomain` resource creates a Connect attachment from a specified transit gateway attachment.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayMulticastDomain](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewaymulticastdomain.html).

## Syntax

Ensure that transit gateway multicast domain exists.

```ruby
describe aws_transit_gateway_multicast_domains do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`transit_gateway_multicast_domain_ids`
: The ID of the transit gateway multicast domain.

`transit_gateway_ids`
: The ID of the transit gateway.

`transit_gateway_multicast_domain_arns`
: The Amazon Resource Name (ARN) of the transit gateway multicast domain.

`owner_ids`
: The ID of the AWS account that owns the transit gateway multicast domain.

`options`
: The options for the transit gateway multicast domain.

`states`
: The state of the transit gateway multicast domain.

`creation_time`
: The time the transit gateway multicast domain was created.

`tags`
: The tags for the transit gateway multicast domain.

## Examples

**Ensure a specific transit gateway attachment ID is available.**

```ruby
describe aws_transit_gateway_multicast_domains do
  its('transit_gateway_multicast_domain_ids') { should include 'TRANSIT_GATEWAY_MULTICAST_DOMAIN_ID' }
end
```

**Ensure that the state is `available`.**

```ruby
describe aws_transit_gateway_multicast_domains do
  its('states') { should include 'available' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_transit_gateway_multicast_domains do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_transit_gateway_multicast_domains do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_transit_gateway_multicast_domains do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTransitGatewayMulticastDomainsResult" %}}
