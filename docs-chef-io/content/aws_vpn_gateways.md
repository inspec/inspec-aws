+++
title = "aws_vpn_gateways resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_vpn_gateways"
identifier = "inspec/resources/aws/aws_vpn_gateways resource"
parent = "inspec/resources/aws"
+++

Use the `aws_vpn_gateways` InSpec audit resource to test the properties of all Amazon VPN gateways. To audit a single AWS VPN gateway, use the `aws_vpn_gateway` (singular) resource.

## Syntax

An `aws_vpn_gateways` resource block collects a group of AWS VPN descriptions and then tests that group.

```ruby
describe aws_vpn_gateways
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`vpn_gateway_ids`
: List of unique identifiers that identifies a AWS VPN gateway.

`states`
: List of the current state of the VPN gateway. Possible values are: `pending`, `available`, `deleting`, `deleted`.

`types`
: List of the types of VPN connection the VPN gateway supports.

`availability_zones`
: List of Availability Zone where the virtual private gateway was created. If not applicable, this field will be be empty.

`vpc_attachments`
: List of VPCs attached to the virtual private gateway. It has a collection of key-pairs of `state` and `vpc_id`.

`amazon_side_asns`
: List of all the private Autonomous System Number (ASN) for the Amazon side of a BGP session.

`tags`
: List of all tags that are associated with the VPN gateway.

## Examples

**Ensure that exactly three AWS VPN gateways exist.**

```ruby
describe aws_vpn_gateways do
  its('count') { should eq 3 }
end
```

**Request the IDs of all AWS VPN gateways, then test in-depth using `aws_vpn_gateway`.**

```ruby
aws_vpn_gateways.vpn_gateway_ids.each do |vpn_gateway_id|
  describe aws_vpn_gateway(vpn_gateway_id) do
    it { should exists }
    it { should be_attached }
  end
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the 'describe' method returns at least one result.

```ruby
describe aws_vpn_gateways.where( <property>: <value>) do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_vpn_gateways.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:DescribeVpnGatewaysResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
