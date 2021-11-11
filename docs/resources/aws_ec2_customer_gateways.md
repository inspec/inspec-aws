---
title: About the aws_ec2_customer_gateways Resource
platform: aws
---

# aws_ec2_customer_gateways

Use the `aws_ec2_customer_gateways` InSpec audit resource to test properties of the plural resource of AWS EC2 customer gateway.

The `AWS::EC2::CustomerGateway` resource type specifies a customer gateway.

## Syntax

Ensure that the customer gateway exists.

    describe aws_ec2_customer_gateways do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 customer gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-customer-gateway.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| bgp_asns | The customer gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN). | bgp_asn |
| customer_gateway_ids | The ID of the customer gateway. | customer_gateway_id |
| ip_addresses | The Internet-routable IP address of the customer gateway's outside interface. | ip_address |
| certificate_arns | The Amazon Resource Name (ARN) for the customer gateway certificate. | certificate_arn |
| states | The current state of the customer gateway. | state |
| types | The type of VPN connection the customer gateway supports (ipsec.1). | type |
| device_names | The name of customer gateway device. | device_name |
| tags | Any tags assigned to the customer gateway. | tags |

## Examples

### Ensure a customer gateway ID is available.

    describe aws_ec2_customer_gateways do
      its('customer_gateway_ids') { should include 'CUSTOMER_GATEWAY_ID' }
    end

### Ensure that the state is `available`.

    describe aws_ec2_customer_gateways do
        its('states') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_customer_gateways do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_customer_gateways do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_customer_gateways do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCustomerGatewaysResult` action with `Effect` set to `Allow`.
