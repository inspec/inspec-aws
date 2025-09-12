+++
title = "aws_route_table resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_route_table"
identifier = "inspec/resources/aws/aws_route_table resource"
parent = "inspec/resources/aws"
+++

Use the `aws_route_table` InSpec audit resource to test the properties of a single route or route table. A route table contains a set of rules, called routes, that are used to determine where network traffic is directed.

For additional information, including details on parameters and properties, see the [AWS documentation on route tables](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route-table.html) and the [AWS documentation on routes](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-route.html#cfn-ec2-route-destinationcidrblock).

## Syntax

This resource expects a single parameter that uniquely identifies the route table. You may pass it as a string, or as the value in a hash:

```ruby
describe aws_route_table('ROUTE_TABLE_ID') do
  it { should exist }
end
```

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should exist }
end
```

## Parameters

`route_table_id` _(required)_

: This resource accepts a single parameter, the `route_table_id`.
  This can be passed either as a string or as a `route_table_id: 'value'` key-value entry in a hash.

## Properties

`route_table_id`
: The ID of the route table.

`owner_id`
: The ID of the AWS account that owns the route table.

`vpc_id`
: The ID of the VPC.

`routes`
: The routes in the route table.

`associations`
: The associations between the route table and one or more subnets.

`propagating_vgws`
: Any virtual private gateway (VGW) propagating routes.

`tags`
: Any tags assigned to the route table.

`routes(carrier_gateway_id)`
: The ID of the carrier gateway.

`routes(destination_cidr_block)`
: The IPv4 CIDR block used for the destination match.

`routes(destination_ipv_6_cidr_block)`
: The IPv6 CIDR block used for the destination match.

`routes(destination_prefix_list_id)`
: The prefix of the AWS service.

`routes(egress_only_internet_gateway_id)`
: The ID of the egress-only internet gateway.

`routes(gateway_id)`
: The ID of a gateway attached to your VPC.

`routes(instance_id)`
: The ID of a NAT instance in your VPC.

`routes(local_gateway_id)`
: The ID of the local gateway.

`routes(nat_gateway_id)`
: The ID of a NAT gateway.

`routes(network_interface_id)`
: The ID of the network interface.

`routes(transit_gateway_id)`
: The ID of a transit gateway.

`routes(vpc_peering_connection_id)`
: The ID of a VPC peering connection.

`routes(instance_owner_id)`
: The owner ID of a NAT instance in your VPC.

`routes(origin)`
: Describes how the route was created.

`routes(state)`
: The state of the route.

`associated_subnet_ids`
: List of associated subnet IDs.

`associated_gateway_ids`
: List of associated gateway IDs.

## Examples

**Confirm that the route table has expected VPC identifier.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('vpc_id') { should eq 'VPC_ID' }
end
```

**Confirm that the route table has expected owner identifier.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('owner_id') { should eq 'OWNER_ID' }
end
```

**Ensure the expected number of routes is present.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('routes.count') { should eq 2 }
end
```

**Ensure the expected number of associations is present.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('associations.count') { should eq 1 }
end
```

**Ensure the subnet ID of interest is associated.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('associated_subnet_ids') { should include 'SUBNET_ID' }
end
```

**Ensure no gateways are associated.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('associated_gateway_ids') { should be_empty }
end
```

**Ensure there are no virtual private gateway (VGW) propagating routes.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('propagating_vgws') { should be_empty }
end
```

**Confirm that the route table has the expected destination IPv4 CIDR block of the route.**

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  its('routes.first.destination_cidr_block') { should eq 'IPV4_CIDR_BLOCK' }
end
```

## Matchers

For a full list of available matchers, visit the [InSpec matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_route_table('should-be-there') do
  it { should exist }
end
```

```ruby
describe aws_route_table('should-not-be-there') do
  it { should_not exist }
end
```

### main

The control will pass if the route table is the main route table for the VPC.

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should be_main }
end
```

### have_subnet_associated

The control will pass if the subnet is associated with the route table.

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should have_subnet_associated('SUBNET_ID') }
end
```

### have_gateway_associated

The control will pass if the specified gateway is associated with the route table.

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should have_gateway_associated('GATEWAY_ID') }
end
```

### have_failed_association_value

The control will pass if the specified gateway, subnet, or association that is associated with the route table has a failed state.

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should have_failed_association_value(gateway_id: 'GATEWAY_ID') }
end
```

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should have_failed_association_value(subnet_id: 'SUBNET_ID') }
end
```

```ruby
describe aws_route_table(route_table_id: 'ROUTE_TABLE_ID') do
  it { should have_failed_association_value(route_table_association_id: 'ROUTE_TABLE_ASSOCIATION_ID') }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeRouteTablesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
