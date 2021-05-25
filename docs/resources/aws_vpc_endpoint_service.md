---
title: About the aws_vpc_endpoint_service Resource
platform: aws
---

# aws_vpc_endpoint_service

Use the `aws_vpc_endpoint_service` InSpec audit resource to test the properties of a single AWS VPC Endpoint Service.

## Syntax

An `aws_vpc_endpoint_service` resource block declares the tests for a single AWS VPC Endpoint Service by `service_name`.

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
      it { should exist }
    end

### Parameters

The AWS VPC Endpoint Service table ID and CIDR block is required.

#### transit\_gateway\_route\_table\_id _(required)_

The ID of the AWS VPC Endpoint Service table:

- must contain between 1 and 50 alphanumeric characters or hyphens
- should start with `tgw-rtb-`
- cannot end with a hyphen or contain two consecutive hyphens

It should be passed as a `service_name: 'value'` key-value entry in a hash.

#### cidr\_block _(required)_

The CIDR Block Range of the route associated to AWS VPC Endpoint Service table

It should be passed as a `cidr_block: 'value'` key-value entry in a hash.

## Properties

|Property               | Description                                             |
| ---                   | ---                                                     |
|cidr_block             | The CIDR block used for destination matches.            |
|prefix_list_id         | The ID of the prefix list used for destination matches. |
|type                   | The type of route. Valid values: `propagated` or `static`. |
|state                  | The state of the route. Valid values: `active` or `blackhole`. |
|attachment_resource_id | The resource ID of the transit gateway attachment. Identifiers of relevant resource type.                  |
|attachment_id          | The ID of the transit gateway attachment.                                      |
|attachment_resource_type| The attachment resource type. Valid values are `vpc`, `vpn`, `direct-connect-gateway`, `peering`, `connect`. |

## Examples

### Test if a transit gateway route exists for a transit gateway route table and CIDR block range

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        it { should exist }
    end

### Test that the ID of the attached VPC is `vpc-00727fc4213acee4a`

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        its('attachment_resource_id') { should eq 'vpc-00727fc4213acee4a' }
    end

### Test that the ID of the Transit Gateway Attachment is `tgw-attach-0aab89f748131532e`

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        its('attachment_id') { should eq 'tgw-attach-0aab89f748131532e' }
    end

### Test that the attachment resource type is `vpc`

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        its('attachment_resource_type') { should eq 'vpc' }
    end


### Test that the prefix list ID is `pl-4ca54025`

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        its('prefix_list_id') { should eq 'pl-4ca54025' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        it { should exist }
    end

### be_static

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        it { should be_static }
    end

### be_propagated

    describe aws_vpc_endpoint_service(service_name: 'tgw-rtb-08acd74550c99e911', cidr_block: '0.0.0.0/16') do
        it { should be_propagated }
    end

### be_active

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        it { should be_active }
    end

### be_blackhole

    describe aws_vpc_endpoint_service(service_name: 'tgw-rtb-08acd74550c99e911', cidr_block: '0.0.0.0/17') do
        it { should be_blackhole }
    end

### be_vpc_attachment

    describe aws_vpc_endpoint_service(service_name: 'aws.sagemaker.us-east-2.notebook') do
        it { should be_vpc_attachment }
    end

### be_vpn_attachment

    describe aws_vpc_endpoint_service(service_name: 'tgw-rtb-08acd74550c99e711', cidr_block: '0.0.0.0/16') do
        it { should be_vpn_attachment }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeTransitGatewayRouteTables` action set to `allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for transit gateway route](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-policy-examples.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).