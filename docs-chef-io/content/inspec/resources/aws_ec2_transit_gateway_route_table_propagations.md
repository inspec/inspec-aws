+++
title = "aws_ec2_transit_gateway_route_table_propagations Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_transit_gateway_route_table_propagations"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_route_table_propagations Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_route_table_propagations` InSpec audit resource to test properties of multiple propagation routes between Transit Gateway attachments and a Transit Gateway route table.

The `AWS::EC2::TransitGatewayRouteTablePropagation` resource enables the specified attachment to propagate routes to the specified propagation route table.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS EC2 TransitGatewayRouteTablePropagation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetablepropagation.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a Transit Gateway route table id exists.

```ruby
describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

## Parameters

`transit_gateway_route_table_id` _(required)_

: The ID of the Transit Gateway route table.

## Properties

`transit_gateway_attachment_ids`
: A list of the attachment IDs.

: **Field**: `transit_gateway_attachment_id`

`resource_ids`
: A list of the resource IDs.

: **Field**: `resource_id`

`resource_types`
: A list of the resource types.

: **Field**: `resource_type`

`states`
: A list of the resource states.

: **Field**: `state`

## Examples

**Ensure that a Transit Gateway attachment ID is available.**

```ruby
describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  its('transit_gateway_attachment_ids') { should include 'TRANSIT_GATEWAY_ROUTE_TABLE_ID' }
end
```

**Ensure that a propagation route is `enabled`.**

```ruby
describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
    its('states') { should include 'enabled' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that an entity exists.

```ruby
describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

Use `should_not` to test an entity does not exist.

```ruby
describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if an entity is available.

```ruby
describe aws_ec2_transit_gateway_route_table_propagations(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetTransitGatewayRouteTablePropagationsResult" %}}
