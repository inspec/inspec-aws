+++
title = "aws_vpn_gateway resource"

draft = false


[menu.aws]
title = "aws_vpn_gateway"
identifier = "inspec/resources/aws/aws_vpn_gateway resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpn_gateway` InSpec audit resource to test the properties of a single AWS VPN gateway.

## Syntax

An `aws_vpn_gateway` resource block declares the tests for a single AWS VPN gateway by `vpn_gateway_id`.

```ruby
describe aws_vpn_gateway(vpn_gateway_id: 'vgw-014aef8a0689b8f43') do
  it { should exist }
end
```

The value of the `vpn_gateway_id` can be provided as a string.

```ruby
describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
  it { should exist }
end
```

## Parameters

The AWS VPN gateway ID is required.

`vpn_group_id` _(required)_

: The ID of the VPN gateway:

: - must contain between 1 and 50 alphanumeric characters or hyphens

- should start with `vgw-`
- cannot end with a hyphen or contain two consecutive hyphens

: It can be passed either as a string or as a `vpn_gateway_id: 'value'` key-value entry in a hash.

## Properties

`vpn_gateway_id`
: The identifier of the AWS VPN gateway.

`state`
: The current state of the VPN gateway. Possible values are: `pending`, `available`, `deleting`, `deleted`.

`type`
: The type of VPN connection that the VPN gateway supports.

`availability_zone`
: The Availability Zone where the virtual private gateway was created. If not applicable, this field will be be empty.

`vpc_id`
: The ID of the associated VPC.

`amazon_side_asn`
: The private Autonomous System Number (ASN) for the Amazon side of a BGP session.

`tags`
: All tags that are associated to the VPN gateway.

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Types/VpnGateway.html).

## Examples

Test that a VPN Gateway is available and attached:

```ruby
describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
    its('status') { should eq 'available' }
    it { should be_attached }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

```ruby
describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
    it { should exist }
end
```

### be_attached to a VPC

```ruby
describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
    it { should be_attached }
    its('vpc_id') { should eq 'vpc-0a510beed76210f2f'}
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpnGatewaysResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
