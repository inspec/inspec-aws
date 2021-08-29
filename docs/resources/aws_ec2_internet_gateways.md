---
title: About the aws_ec2_internet_gateways Resource
platform: aws
---

# aws_ec2_internet_gateways

Use the `aws_ec2_internet_gateways` InSpec audit resource to test properties of a plural AWS EC2 Internet Gateway.

The AWS::EC2::InternetGateway resource allocates an internet gateway for use with a VPC. After creating the Internet gateway, you then attach it to a VPC..

## Syntax

Ensure that internet gateway exists.

    describe aws_ec2_internet_gateways do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 Internet Gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html).

## Properties

| Property | Description|
| --- | --- |
| attachments | The attachment of the Internet gateway. | attachments |
| attachments_states | The | attachments (state) |
| attachments_vpc_ids | The | attachments (vpc_id) |
| internet_gateway_ids | The ID of the Internet gateway. | internet_gateway_id |
| owner_ids | The ID of the Amazon Web Services account that owns the internet gateway. | owner_id |
| tags | The key/value combination of a tag assigned to the resource.  | tags |

## Examples

### Ensure a attachments is available.
    describe aws_ec2_internet_gateways do
      its('attachments') { should_not be_empty }
    end

### Ensure that the attachment state is `available`.
    describe aws_ec2_internet_gateways do
        its('attachments_states') { should include 'available' }
    end

### Ensure a internet gateway id is available.
    describe aws_ec2_internet_gateways do
      its('internet_gateway_ids') { should include 'InternetGatewayId' }
    end

### Ensure a owner id is available.
    describe aws_ec2_internet_gateways do
      its('owner_ids') { should include '1234567890' }
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