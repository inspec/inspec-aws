+++
title = "aws_ec2_transit_gateway_route_tables Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ec2_transit_gateway_route_tables"
identifier = "inspec/resources/aws/aws_ec2_transit_gateway_route_tables Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ec2_transit_gateway_route_tables` InSpec audit resource to test properties of some or all Transit Gateway route tables.

This resource does not expect any parameters.

For additional information, including details on parameters and properties, see the [AWS documentation on Transit Gateway route tables](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-transitgatewayroutetable.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Verify that a Transit Gateway route table ID exists.

```ruby
describe aws_ec2_transit_gateway_route_tables do
  it { should exist }
end
```

An `aws_ec2_transit_gateway_route_tables` resource block uses an optional filter to select a group of Elastic IPs and then test that group.

## Parameters

This resource does not require any parameters.

## Properties

`transit_gateway_route_table_ids`
: The ID of the Transit Gateway route table.

`transit_gateway_ids`
: The ID of the Transit Gateway.

`states`
: The state of the route table. Relevant values are: `available`, `deleting`, `deleted`, and `pending`.

`default_association_route_tables`
: Indicates whether this is the default association route table for the Transit Gateway. Default values are `true` and `false`.

`default_propagation_route_tables`
: Indicates whether this is the default propagation route table for the Transit Gateway. Default values are `true` and `false`.

`creation_times`
: The creation time of the Transit Gateway route table.

`tags`
: The tags of the Transit Gateway route table.

## Examples

**Ensure a Transit Gateway route table has route table ID.**

```ruby
describe aws_ec2_transit_gateway_route_tables do
  it { should exist }
end
```

**Match count of Transit Gateway route table.**

```ruby
describe aws_ec2_transit_gateway_route_tables do
    its('count') { should eq 5 }
end
```

**Check State whether it is available or not.**

```ruby
describe aws_ec2_transit_gateway_route_tables do
   its('states') { should include "available" }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_ec2_transit_gateway_route_tables do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_ec2_transit_gateway_route_tables do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTransitGatewayRouteTablesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
