---
title: About the aws_vpn_gateway Resource
---

# aws_vpn_gateway

Use the `aws_vpn_gateway` InSpec audit resource to test the properties of a single AWS VPN gateway.

The `AWS::EC2::VPNGateway` specifies a virtual private gateway. A virtual private gateway is the endpoint on the VPC side of your VPN connection.

## Syntax

An `aws_vpn_gateway` resource block declares the tests for a single AWS VPN gateway by `vpn_gateway_id`.

Ensure that the vpn gateway exists.

    describe aws_vpn_gateway(vpn_gateway_id: 'VPN_GATEWAY_ID') do
      it { should exist }
    end

The value of the `vpn_gateway_id` can be provided as a string.

    describe aws_vpn_gateway('VPN_GATEWAY_ID') do
      it { should exist }
    end

## Parameters

The AWS VPN gateway ID is required.

`vpn_group_id` _(required)_

The ID of the VPN gateway:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `vgw-`
- cannot end with a hyphen or contain two consecutive hyphens

It can be passed either as a string or as a `vpn_gateway_id: 'value'` key-value entry in a hash.

There are also additional properties available. For a comprehensive list, see [AWS documentation on `AWS::EC2::VPNGateway` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpn-gateway.html).

## Properties

| Property | Description |
| :---: | :--- |
| vpn_gateway_id | The identifier of the AWS VPN gateway. |
| state | The current state of the VPN gateway. Possible values are: `pending`, `available`, `deleting`, `deleted`. |
| type | The type of VPN connection that the VPN gateway supports. |
| availability_zone | The Availability Zone where the virtual private gateway was created. If not applicable, this field will be be empty. |
| vpc_id | The ID of the associated VPC. |
| amazon_side_asn | The private Autonomous System Number (ASN) for the Amazon side of a BGP session. |
| tags | All tags that are associated to the VPN gateway. |

## Examples

### Test that a VPN Gateway is available and attached

    describe aws_vpn_gateway('VPN_GATEWAY_ID') do
        its('status') { should eq 'available' }
        it { should be_attached }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Use `should` to test that the entity exists.

    describe aws_vpn_gateway('VPN_GATEWAY_ID') do
        it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_vpn_gateway('VPN_GATEWAY_ID') do
      it { should_not exist }
    end

### be_attached to a VPC

    describe aws_vpn_gateway('VPN_GATEWAY_ID') do
        it { should be_attached }
        its('vpc_id') { should eq 'VPC_ID'}
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpnGatewaysResult` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
