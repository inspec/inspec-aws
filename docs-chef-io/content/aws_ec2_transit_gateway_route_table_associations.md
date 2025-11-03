+++
title = "aws_ec2_transit_gateway_route_table_associations resource"

draft = false


[menu.aws]
title = "aws_ec2_transit_gateway_route_table_associations"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_route_table_associations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_route_table_associations` InSpec audit resource to test properties of some or all AWS transit gateway route table associations.

An AWS transit gateway route table association associates the specified attachment with the specified transit gateway route table. You can associate only one route table with an attachment.

## Syntax

Verify whether a transit gateway route table ID exists.

```ruby
describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

## Parameters

`transit_gateway_route_table_id` _(required)_

: For addition information, check out the [AWS documentation on transit gateway route table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html).

## Properties

`transit_gateway_route_table_ids`
: The ID of the transit gateway route table.

`resource_types`
: The resource type. Valid values are: `vpc`, `vpn`, `direct-connect-gateway`, `peering`, and `connect`.

`resource_ids`
: The ID of the resource.

`states`
: The possible states of the route table are: `available`, `deleting`, `deleted`, and `pending`.

## Examples

Ensure a transit gateway route table exists:

```ruby
describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

Match count of transit gateway route table:

```ruby
describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
    its('count') { should eq 5 }
end
```

Check the state of the route table:

```ruby
describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
   its('states') { should include "available" }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For the complete list of available matchers, visit [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the `describe` returns at least one result.

Use `should` to test whether the entity exists.

```ruby
describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_ec2_transit_gateway_route_table_associations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetTransitGatewayRouteTableAssociationsResult" %}}

For addition information, check out the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation.
