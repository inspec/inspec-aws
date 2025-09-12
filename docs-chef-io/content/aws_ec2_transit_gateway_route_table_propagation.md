+++
title = "aws_ec2_transit_gateway_route_table_propagation resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_transit_gateway_route_table_propagation"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_route_table_propagation resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_route_table_propagation` InSpec audit resource to test properties of a propagation route between a Transit Gateway attachment and a Transit Gateway route table.

The `AWS::EC2::TransitGatewayRouteTablePropagation` resource enables the specified attachment to propagate routes to the specified propagation route table.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html).

## Syntax

Ensure that a Transit Gateway route table id exists.

```ruby
describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
  it { should exist }
end
```

## Parameters

`transit_gateway_route_table_id` _(required)_

: The ID of the Transit Gateway route table.

`transit_gateway_attachment_id` _(required)_

: The ID of the attachment.

## Properties

`transit_gateway_attachment_id`
: The ID of the attachment.

`resource_id`
: The ID of the resource.

`resource_type`
: The type of resource.

`state`
: The state of the resource.

## Examples

**Ensure a Transit Gateway attachment ID is available.**

```ruby
describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
  its('transit_gateway_attachment_id') { should eq 'TRANSIT_GATEWAY_ROUTE_TABLE_ID' }
end
```

**Ensure that the state is `enabled`.**

```ruby
describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
    its('state') { should eq 'enabled' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ec2_transit_gateway_route_table_propagation(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID', transit_gateway_attachment_id: "TRANSIT_GATEWAY_ATTACHMENT_ID") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetTransitGatewayRouteTablePropagationsResult" %}}
