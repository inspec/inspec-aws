---
title: About the aws_ec2_internet_gateway Resource
platform: aws
---

# aws_ec2_internet_gateway

Use the `aws_ec2_internet_gateway` InSpec audit resource to test properties of a single specific AWS EC2 internet gateway.

The `AWS::EC2::InternetGateway` resource allocates an internet gateway for use with a VPC. After creating the internet gateway, you then attach it to a VPC.

## Syntax

Ensure that internet gateway exists.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      it { should exist }
    end

## Parameters

`internet_gateway_id` _(required)_

The ID of the internet gateway.

For additional information, see the [AWS documentation on AWS EC2 internet gateway](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-internetgateway.html).

## Properties

| Property | Description |
| --- | --- |
| attachments | The attachment of the internet gateway. |
| attachments_states | The current state of the attachment. For an internet gateway, the state is available when attached to a VPC; otherwise, this value is not returned. |
| attachments_vpc_ids | The ID of the VPC. |
| internet_gateway_id | The ID of the internet gateway. |
| owner_id | The ID of the Amazon Web Services account that owns the internet gateway. |
| tags | The key/value combination of a tag assigned to the resource. |

## Examples

### Ensure an attachments is available.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      its('attachments') { should_not be_empty }
    end

### Ensure that the attachment state is `available`.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
        its('attachments_states') { should eq 'available' }
    end

### Ensure an internet gateway ID is available.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      its('internet_gateway_id') { should eq 'INTERNET_GATEWAY_ID' }
    end

### Ensure an owner ID is available.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      its('owner_id') { should eq 'OWNER_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_internet_gateway(internet_gateway_id: 'INTERNET_GATEWAY_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeInternetGatewaysResult` action with `Effect` set to `Allow`.
