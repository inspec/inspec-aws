---
title: About the aws_vpn_gateway Resource
---

# aws_vpn_gateway

Use the `aws_vpn_gateway` InSpec audit resource to test the properties of a single AWS VPN Gateway.

## Syntax

An `aws_vpn_gateway` resource block declares the tests for a single AWS VPN Gateway by `vpn_gateway_id`.

    describe aws_vpn_gateway(vpn_gateway_id: 'vgw-014aef8a0689b8f43') do
      it { should exist }
    end

The value of the `vpn_gateway_id` can be provided as a string.

    describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
      it { should exist }
    end

### Parameters

The AWS VPN Gateway ID is required.

#### vpn\_group\_id _(required)_

The ID of the VPN Gateway ID:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `vgw-`
- cannot end with a hyphen or contain two consecutive hyphens

It can be passed either as a string or as a `vpn_gateway_id: 'value'` key-value entry in a hash.

## Properties

|Property               | Description |
| ---                   | --- |
|vpn\_gateway\_id | The user-supplied identifier of the AWS VPN Gateway. This identifier is a unique key that identifies a AWS VPN Gateway.|
|state                 | The current state of the VPN Gateway. It's values are one of `pending`, `available`, `deleting`, `deleted`
|type                  | The type of VPN connection the VPN gateway supports.
|availability_zone     | The Availability Zone where the virtual private gateway was created. If not applicable, this field will be be empty.
|vpc_id                | The ID of the associated VPC
|amazon\_side\_asn     | The private Autonomous System Number (ASN) for the Amazon side of a BGP session.|
|tags                  | All tags that are associated to the VPN Gateway|


There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/EC2/Types/VpnGateway.html).

## Examples

### Test that an VPN Gateway is available and attached

    describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
        its('status') { should eq 'available' }
        it { should be_attached }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).


### exist

    describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
        it { should exist }
    end

### be_attached to a VPC

    describe aws_vpn_gateway('vgw-014aef8a0689b8f43') do
        it { should be_attached }
        its('vpc_id') { should eq 'vpc-0a510beed76210f2f'}
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpnGateways` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).