---
title: About the aws_ec2_customer_gateway Resource
platform: aws
---

# aws_ec2_customer_gateway

Use the `aws_ec2_customer_gateway` InSpec audit resource to test properties of a single AWS EC2 customer gateway.

The `AWS::EC2::CustomerGateway` resource type specifies a customer gateway.

## Syntax

Ensure that the customer gateway Id exists.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
      it { should exist }
    end

## Parameters

`customer_gateway_id` _(required)_

The ID of the customer gateway.

For additional information, see the [AWS documentation on AWS EC2 customer gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html).

## Properties

| Property | Description |
| :---: | :--- |
| bgp_asn | The customer gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). |
| customer_gateway_id | The ID of the customer gateway. |
| ip_address | The internet-routable IP address of the customer gateway's outside interface. |
| certificate_arn | The Amazon Resource Name (ARN) for the customer gateway certificate. |
| state | The current state of the customer gateway. |
| type | The type of VPN connection the customer gateway supports (ipsec.1). |
| device_name | The name of customer gateway device. |
| tags | Any tags assigned to the customer gateway. |

## Examples

### Ensure a customer gateway ID is available.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
      its('customer_gateway_id') { should eq 'CUSTOMER_GATEWAY_ID' }
    end

### Ensure that the state is `available`.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CUSTOMER_GATEWAY_ID") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCustomerGatewaysResult` action with `Effect` set to `Allow`.
