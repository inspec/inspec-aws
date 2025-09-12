+++
title = "aws_ec2_transit_gateway_route_table resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ec2_transit_gateway_route_table"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_route_table resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_route_table` InSpec audit resource to test properties of a single specific Transit Gateway route table association.

A Transit Gateway route table association associates the specified attachment with the specified Transit Gateway route table.

For additional information, including details on parameters and properties, see the [AWS documentation on Transit Gateway route table](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetable.html).

## Syntax

Ensure that a Transit Gateway route table ID exists.

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
  it { should exist }
end
```

## Parameters

`transit_gateway_route_table_id` _(required)_

: The ID of the Transit Gateway route table.

## Properties

`transit_gateway_route_table_id`
: The ID of the Transit Gateway route table.

`transit_gateway_id`
: The ID of the Transit Gateway.

`state`
: The state of the route table. Relevant values are: `available`, `deleting`, `deleted`, and `pending`.

`default_association_route_table`
: Indicates whether this is the default association route table for the Transit Gateway. Default values are `true` and `false`.

`default_propagation_route_table`
: Indicates whether this is the default propagation route table for the Transit Gateway. Default values are `true` and `false`.

`creation_time`
: The creation time of the Transit Gateway route table.

`tags`
: The tags of the Transit Gateway route table.

## Examples

**Ensure a Transit Gateway route table ID is available.**

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
  its('transit_gateway_route_table_id') { should eq 'tgw-rtb-052d947d91b6bb69f' }
end
```

**Ensure that the state is `available` or `deleted`.**

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
    its('state') { should eq 'available' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
  it { should_not exist }
end
```

### be_available

Check if the Transit Gateway route table ID is available.

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
  it { should be_available }
end
```

Use `should_not` to test an Transit Gateway route table ID that should not exist.

```ruby
describe aws_ec2_transit_gateway_route_table(transit_gateway_route_table_id: 'tgw-rtb-052d947d91b6bb69f') do
  it { should_not be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ec2:describe_transit_gateway_route_tables" %}}

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
