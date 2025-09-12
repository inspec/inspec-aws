+++
title = "aws_transit_gateway resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_transit_gateway"
identifier = "inspec/resources/aws/aws_transit_gateway resource"
parent = "inspec/resources/aws"
+++

Use the `aws_transit_gateway` InSpec audit resource to test properties of a transit gateway.

For additional information, including details on parameters and properties, see the [AWS documentation on Transit Gateways](https://docs.aws.amazon.com/vpc/latest/tgw/).

## Syntax

An `aws_transit_gateway` resource block uses the parameter to select a transit gateway.

```ruby
describe aws_transit_gateway(transit_gateway_id: 'tgw-1234567') do
  it { should exist }
end
```

## Parameters

`transit_gateway_id` _(required)_

: This resource accepts a single parameter, the Transit Gateway ID.
  This can be passed either as a string or as a `transit_gateway_id: 'value'` key-value entry in a hash.

## Properties

`transit_gateway_id`
: Provides the ID of the Transit Gateway.

`transit_gateway_arn`
: Provides the ARN of the Transit Gateway.

`transit_gateway_owner_id`
: Provides the id of the owner of the Transit Gateway.

`default_route_table_id`
: Provides the id of the default route table of the Transit Gateway.

`propagation_default_route_table_id`
: Provides the propagation default route table id for the Transit gateway.

`dns_support`
: Provides the status of dns support for the Transit Gateway.

`vpn_ecmp_support`
: Provides the status of vpn ecmp support for the Transit Gateway.

## Examples

**Check the owner id zone of the Transit Gateway.**

```ruby
describe aws_transit_gateway(transit_gateway_id: 'tgw-0e231ae7f5e5e7bd5') do
  its('transit_gateway_owner_id') { should eq 'owner_id' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The `exist` matcher indicates that a transit gateway exists.

```ruby
describe aws_transit_gateway(transit_gateway_id: 'tgw-0e231ae7f5e5e7bd5') do
      it { should exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeTransitGatewaysResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
