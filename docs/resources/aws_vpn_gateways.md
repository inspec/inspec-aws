---
title: About the aws_vpn_gateways Resource
---

# aws\_vpn\_gateways

Use the `aws_vpn_gateways` InSpec audit resource to test the properties of all Amazon VPN gateways. To audit a single AWS VPN gateway, use the `aws_vpn_gateway` (singular) resource.

## Syntax

An `aws_vpn_gateways` resource block collects a group of AWS VPN descriptions and then tests that group.

    describe aws_vpn_gateways
      it { should exist }
    end

### Parameters

This resource does not expect any parameters.

## Properties

|Property                   | Description|
| ---                       | --- |
|vpn\_gateway\_ids          | List of unique identifiers that identifies a AWS VPN gateway.|
|states                     | List of the current state of the VPN gateway. Possible values are: `pending`, `available`, `deleting`, `deleted`. |
|types                      | List of the types of VPN connection the VPN gateway supports. |
|availability_zones         | List of Availability Zone where the virtual private gateway was created. If not applicable, this field will be be empty. |
|vpc_attachments            | List of VPCs attached to the virtual private gateway. It has a collection of key-pairs of `state` and `vpc_id`. |
|amazon\_side\_asns         | List of all the private Autonomous System Number (ASN) for the Amazon side of a BGP session. |
|tags                       | List of all tags that are associated with the VPN gateway. |

## Examples

### Ensure that exactly three AWS VPN gateways exist

    describe aws_vpn_gateways do
      its('count') { should eq 3 }
    end

### Request the IDs of all AWS VPN gateways, then test in-depth using `aws_vpn_gateway`.

    aws_vpn_gateways.vpn_gateway_ids.each do |vpn_gateway_id|
      describe aws_vpn_gateway(vpn_gateway_id) do
        it { should exists }
        it { should be_attached }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the 'describe' method returns at least one result.

    describe aws_vpn_gateways.where( <property>: <value>) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_vpn_gateways.where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVpnGatewaysResult` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.amazonaws.cn/en_us/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
