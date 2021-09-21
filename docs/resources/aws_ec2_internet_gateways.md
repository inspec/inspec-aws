---
title: About the aws_ec2_internet_gateways Resource
platform: aws
---

# aws_ec2_internet_gateways

Use the `aws_ec2_internet_gateways` InSpec audit resource to test properties of multiple AWS EC2 internet gateways.

The `AWS::EC2::InternetGateway` resource allocates an internet gateway for use with a VPC. After creating the internet gateway, you then attach it to a VPC.

## Syntax

Ensure that an internet gateway exists.

    describe aws_ec2_internet_gateways do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 internet gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html).

## Properties

| Property | Description| Field |
| --- | --- | --- |
| attachments | The attachments of the internet gateways. | attachments |
| attachments_states | The current attachment states. For an internet gateway, the state is available when attached to a VPC; otherwise, this value is not returned. | attachments (state) |
| attachments_vpc_ids | The IDs of the VPCs. | attachments (vpc_id) |
| internet_gateway_ids | The IDs of the internet gateways. | internet_gateway_id |
| owner_ids | The IDs of the AWS accounts that own the internet gateways. | owner_id |
| tags | The key/value combination of tags assigned to the resources. | tags |

## Examples

### Ensure an attachment is available.

    describe aws_ec2_internet_gateways do
      its('attachments') { should_not be_empty }
    end

### Ensure that an attachment state is `available`.

    describe aws_ec2_internet_gateways do
        its('attachments_states') { should include 'available' }
    end

### Ensure an internet gateway ID is available.

    describe aws_ec2_internet_gateways do
      its('internet_gateway_ids') { should include 'INTERNET_GATEWAY_ID' }
    end

### Ensure an owner ID is available.

    describe aws_ec2_internet_gateways do
      its('owner_ids') { should include 'OWNER_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_internet_gateways do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_internet_gateways do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeInternetGatewaysResult` action with `Effect` set to `Allow`.
