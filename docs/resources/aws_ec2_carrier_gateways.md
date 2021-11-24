---
title: About the aws_ec2_carrier_gateways Resource
platform: aws
---

# aws_ec2_carrier_gateways

Use the `aws_ec2_carrier_gateways` InSpec audit resource to test properties of the plural resource of AWS EC2 carrier gateway.

The AWS::EC2::CarrierGateway resource creates a carrier gateway.

## Syntax

Ensure that the carrier gateway exists.

    describe aws_ec2_carrier_gateways do
      it { should exist }
    end

## Parameters

See the [AWS documentation on AWS EC2 Carrier Gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-carriergateway.html) for additional information.

## Properties

| Property             | Description                                                                    | Field              |
| :------------------: | :----------------------------------------------------------------------------: | :----------------- |
| carrier_gateway_ids  | The ID of the carrier gateway.                                                 | carrier_gateway_id |
| vpc_ids              | The ID of the VPC (Virtual Private Cloud) associated with the carrier gateway. | vpc_id             |
| states               | The state of the carrier gateway.                                              | state              |
| owner_ids            | The Amazon Web Services account ID of the owner of the carrier gateway.        | owner_id           |
| tags                 | The tags assigned to the carrier gateway.                                      | tags               |

## Examples

### Ensure a carrier gateway ID is available

    describe aws_ec2_carrier_gateways do
      its('carrier_gateway_ids') { should include 'GATEWAY_ID' }
    end

### Ensure that the state is `available`

    describe aws_ec2_carrier_gateways do
        its('states') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_carrier_gateways do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_carrier_gateways do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeCarrierGatewaysResult` action with `Effect` set to `Allow`.
