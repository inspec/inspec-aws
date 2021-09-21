---
title: About the aws_ec2_customer_gateway Resource
platform: aws
---

# aws_ec2_customer_gateway

Use the `aws_ec2_customer_gateway` InSpec audit resource to test properties of a single specific AWS EC2 Customer Gateway.

The AWS::EC2::CustomerGateway resource specifies a customer gateway.

## Syntax

Ensure that the Customer Gateway Id exists.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CustomerGatewayId") do
      it { should exist }
    end

## Parameters

`customer_gateway_id` _(required)_

| Property | Description |
| --- | --- |
| customer_gateway_id | The ID of the customer gateway. |

For additional information, see the [AWS documentation on AWS EC2 Customer Gateway.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| bgp_asn | The customer gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | bgp_asn |
| customer_gateway_id | The ID of the customer gateway. | customer_gateway_id |
| ip_address | The Internet-routable IP address of the customer gateway's outside interface. | ip_address |
| certificate_arn | The Amazon Resource Name (ARN) for the customer gateway certificate. | certificate_arn |
| state | The current state of the customer gateway. | state |
| type | The type of VPN connection the customer gateway supports (ipsec.1). | type |
| device_name | The name of customer gateway device. | device_name |
| tags | Any tags assigned to the customer gateway. | tags |

## Examples

### Ensure a Customer Gateway Id is available.
    describe aws_ec2_customer_gateway(customer_gateway_id: "CustomerGatewayId") do
      its('customer_gateway_id') { should eq 'CustomerGatewayId' }
    end

### Ensure that the state is `available`.
    describe aws_ec2_customer_gateway(customer_gateway_id: "CustomerGatewayId") do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CustomerGatewayId") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_customer_gateway(customer_gateway_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_customer_gateway(customer_gateway_id: "CustomerGatewayId") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCustomerGatewaysResult` action with `Effect` set to `Allow`.