+++
title = "aws_route_tables resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_route_tables"
identifier = "inspec/resources/aws/aws_route_tables resource"
parent = "inspec/resources/aws"
+++

Use the `aws_route_tables` InSpec audit resource to test the properties of all route tables or a group of route tables, and all routes or a group of routes. A route table contains a set of rules, called routes, that are used to determine where network traffic is directed.

For additional information, including details on parameters and properties, see the [AWS documentation on route tables](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route-table.html).

## Syntax

```ruby
describe aws_route_tables do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`route_table_ids`
: The route table IDs.

: **Field**: `route_table_id`

`vpc_ids`
: The VPC IDs.

: **Field**: `vpc_id`

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

: **Field**: Not Applicable

`routes(carrier_gateway_ids)`
: The ID of the carrier gateway.

: **Field**: `carrier_gateway_id`

`routes(destination_cidr_blocks)`
: The IPv4 CIDR block used for the destination match.

: **Field**: `destination_cidr_block`

`routes(destination_ipv_6_cidr_blocks)`
: The IPv6 CIDR block used for the destination match.

: **Field**: `destination_ipv_6_cidr_block`

`routes(destination_prefix_list_ids)`
: The prefix of the AWS service.

: **Field**: `destination_prefix_list_id`

`routes(egress_only_internet_gateway_ids)`
: The ID of the egress-only internet gateway.

: **Field**: `egress_only_internet_gateway_id`

`routes(gateway_ids)`
: The ID of a gateway attached to your VPC.

: **Field**: `gateway_id`

`routes(instance_ids)`
: The ID of a NAT instance in your VPC.

: **Field**: `instance_id`

`routes(local_gateway_ids)`
: The ID of the local gateway.

: **Field**: `instance_owner_id`

`routes(nat_gateway_ids)`
: The ID of a NAT gateway.

: **Field**: `nat_gateway_id`

`routes(network_interface_ids)`
: The ID of the network interface.

: **Field**: `network_interface_id`

`routes(transit_gateway_ids)`
: The ID of a transit gateway.

: **Field**: `transit_gateway_id`

`routes(vpc_peering_connection_ids)`
: The ID of a VPC peering connection.

: **Field**: `vpc_peering_connection_id`

`routes(instance_owner_ids)`
: The owner ID of a NAT instance in your VPC.

: **Field**: `instance_owner_id`

`routes(origins)`
: Describes how the route was created.

: **Field**: `origin`

`routes(states)`
: The state of the route.

: **Field**: `state`

`route_table_association_ids`
: List of associated route table association IDs.

: **Field**: `route_table_association_ids`

`association_subnet_ids`
: List of all association states(`associated`, `failed`, `disassociated`) subnet IDs.

: **Field**: `association_subnet_ids`

`associated_subnet_ids`
: List of associated subnet IDs.

: **Field**: `associated_subnet_ids`

`association_gateway_ids`
: List of all association states(`associated`, `failed`, `disassociated`) gateway IDs.

: **Field**: `association_gateway_ids`

`associated_gateway_ids`
: List of associated gateway IDs.

: **Field**: `associated_gateway_ids`

`association_states`
: List of all association states(`associated`, `failed`, `disassociated`).

: **Field**: `association_states`

`main`
: flag to indicate the main route table.

: **Field**: `main`

## Examples

Confirm that a route table exists:

```ruby
describe aws_route_tables do
  its('vpc_ids') { should include 'VPC_ID' }
end
```

Confirm a route table exists:

```ruby
describe aws_route_tables do
  its('route_table_ids') { should include 'ROUTE_TABLE_ID' }
end
```

Confirm a destination_cidr_blocks is there in the routes:

```ruby
describe aws_route_tables do
  its('destination_cidr_blocks') { should include "IPV4_CIDR_BLOCK" }
end
```

Ensure subnet ID of interest is associated :

```ruby
describe aws_route_tables do
  its('associated_subnet_ids') { should include 'SUBNET_ID' }
end
```

Filter only main route tables:

```ruby
describe aws_route_tables.where(main: true) do
  it { should exist }
end
```

Filter all failed associations:

```ruby
describe aws_route_tables.where{ association_states.include?('associated') } do
  it { should exist }
end
```

## Matchers

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should not exist.

```ruby
describe aws_route_tables do
  it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeRouteTablesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
