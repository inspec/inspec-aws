+++
title = "aws_ec2_transit_gateway_route_table_association Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_transit_gateway_route_table_association"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_route_table_association Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_route_table_association` InSpec audit resource to test properties of a single AWS transit gateway route table association.

A transit gateway route table association associates the specified attachment with the specified transit gateway route table. You can associate only one route table with an attachment.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a transit gateway route table ID exists.

```ruby
describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

## Parameters

`transit_gateway_route_table_id` _(required)_

: For additional information, check out the [AWS documentation on transit gateway route table association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetableassociation.html).

## Properties

`transit_gateway_route_table_id`
: The ID of the transit gateway route table.

`resource_type`
: The resource type. Valid values are: `vpc`, `vpn`, `direct-connect-gateway`, `peering`, and `connect`.

`resource_id`
: The ID of the resource.

`state`
: The possible states of the route table are: `available`, `deleting`, `deleted`, and `pending`.

## Examples

**Ensure that the transit gateway route table ID is available.**

```ruby
describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  its('transit_gateway_attachment_id') { should eq ''TRANSIT_GATEWAY_ATTACHMENT_ID'' }
end
```

**Ensure that the state is available or deleted.**

```ruby
describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
    its('state') { should eq 'available' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For the complete list of available matchers, visit [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test whether the entity exists.

```ruby
describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check whether the transit gateway route table ID is available.

```ruby
describe aws_ec2_transit_gateway_route_table_association(transit_gateway_route_table_id: 'TRANSIT_GATEWAY_ROUTE_TABLE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ec2:client:get_transit_gateway_route_table_associations" %}}

For addition information, check out the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation.
