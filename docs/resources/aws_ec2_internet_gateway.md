---
title: About the aws_ec2_internet_gateway Resource
platform: aws
---

# aws_ec2_internet_gateway

Use the `aws_ec2_internet_gateway` InSpec audit resource to test properties of a single specific AWS EC2 Internet Gateway.

The AWS::EC2::InternetGateway resource allocates an internet gateway for use with a VPC. After creating the Internet gateway, you then attach it to a VPC..

## Syntax

Ensure that function exists.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      it { should exist }
    end

## Parameters

`internet_gateway_id` _(required)_

| Property | Description |
| --- | --- |
| internet_gateway_id | The ID of the Internet gateway. |

For additional information, see the [AWS documentation on AWS EC2 Internet Gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| attachments | The attachment of the Internet gateway. | attachments |
| attachments_states | The | attachments (state) |
| attachments_vpc_ids | The | attachments (vpc_id) |
| internet_gateway_id | The ID of the Internet gateway. | internet_gateway_id |
| owner_id | The ID of the Amazon Web Services account that owns the internet gateway. | owner_id |
| tags | The key/value combination of a tag assigned to the resource.  | tags |

## Examples

### Ensure a attachments is available.
    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      its('attachments') { should_not be_empty }
    end

### Ensure that the attachment state is `available`.
    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
        its('attachments_states') { should eq 'available' }
    end

### Ensure a internet gateway id is available.
    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      its('internet_gateway_id') { should eq 'InternetGatewayId' }
    end

### Ensure a owner id is available.
    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      its('owner_id') { should eq '1234567890' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'InternetGatewayId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:client:DescribeInternetGatewaysResult` action with `Effect` set to `Allow`.