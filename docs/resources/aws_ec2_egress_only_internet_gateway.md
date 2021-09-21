---
title: About the aws_ec2_egress_only_internet_gateway Resource
platform: aws
---

# aws_ec2_egress_only_internet_gateway

Use the `aws_ec2_egress_only_internet_gateway` InSpec audit resource to test properties of a single specific AWS EC2 Egress Only Internet Gateway.

The AWS::EC2::EgressOnlyInternetGateway resource specifies an egress-only internet gateway for your VPC.

## Syntax

Ensure that the Egress Only Internet Gateway Id exists.

    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EgressOnlyInternetGatewayId') do
      it { should exist }
    end

## Parameters

`egress_only_internet_gateway_id` _(required)_

| Property | Description |
| --- | --- |
| egress_only_internet_gateway_id | The ID of the egress-only internet gateway. |

For additional information, see the [AWS documentation on AWS EC2 Egress Only Internet Gateway.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-egressonlyinternetgateway.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| attachments | Information about the attachment of the egress-only internet gateway. | attachments |
| attachments_states | The current state of the attachment. | state |
| attachments_vpc_ids | The ID of the VPC. | vpc_id |
| egress_only_internet_gateway_id | The ID of the egress-only internet gateway. | egress_only_internet_gateway_id |
| tags | The tags assigned to the egress-only internet gateway. | tags |

## Examples

### Ensure an Egress Only Internet Gateway Id is available.
    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EgressOnlyInternetGatewayId') do
      its('egress_only_internet_gateway_id') { should eq 'EgressOnlyInternetGatewayId' }
    end

### Ensure that the attachments states is `attached`.
    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EgressOnlyInternetGatewayId') do
        its('attachments_states') { should eq 'attached' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EgressOnlyInternetGatewayId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: 'EgressOnlyInternetGatewayId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeEgressOnlyInternetGatewaysResult` action with `Effect` set to `Allow`.