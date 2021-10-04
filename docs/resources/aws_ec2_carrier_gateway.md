---
title: About the aws_ec2_carrier_gateway Resource
platform: aws
---

# aws_ec2_carrier_gateway

Use the `aws_ec2_carrier_gateway` InSpec audit resource to test properties of a single specific AWS EC2 Carrier Gateway.

The AWS::EC2::CarrierGateway resource creates a carrier gateway.

## Syntax

Ensure that the carrier gateway exists.

    describe aws_ec2_carrier_gateway(carrier_gateway_id: "CarrierGatewayId") do
      it { should exist }
    end

## Parameters

`carrier_gateway_id` _(required)_

| Property | Description |
| --- | --- |
| carrier_gateway_id | The ID of the carrier gateway. |

For additional information, see the [AWS documentation on AWS EC2 Carrier Gateway.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-carriergateway.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| carrier_gateway_id | The ID of the carrier gateway. | carrier_gateway_id |
| vpc_id | The ID of the VPC associated with the carrier gateway. | vpc_id |
| state | The state of the carrier gateway. | state |
| owner_id | The Amazon Web Services account ID of the owner of the carrier gateway. | owner_id |
| tags | The tags assigned to the carrier gateway. | tags |

## Examples

### Ensure a carrier gateway id is available.
    describe aws_ec2_carrier_gateway(carrier_gateway_id: "CarrierGatewayId") do
      its('carrier_gateway_id') { should eq 'CarrierGatewayId' }
    end

### Ensure that the state is `available`.
    describe aws_ec2_carrier_gateway(carrier_gateway_id: "CarrierGatewayId") do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_carrier_gateway(carrier_gateway_id: "CarrierGatewayId") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_carrier_gateway(carrier_gateway_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_carrier_gateway(carrier_gateway_id: "dummy") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCarrierGatewaysResult` action with `Effect` set to `Allow`.