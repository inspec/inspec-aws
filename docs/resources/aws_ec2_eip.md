---
title: About the aws_ec2_eip Resource
platform: aws
---

# aws\_eip

Use the `aws_eip` InSpec audit resource to test properties of a single specific Elastic IP (EIP). 

A Elastic IP (EIP) is uniquely identified by the Public IP (e.g. 18.192.107.8)

## Syntax

Ensure that a Public IP exists.

    # Find a Public IP by public_ip
    describe aws_ec2_eip(public_ip: '18.192.107.8') do
      it { should exist }
    end
    
    # Hash syntax for public_ip
    describe aws_ec2_eip(public_ip: '18.192.107.8') do
      it { should exist }
    end

## Parameters

This resource expects the Public IP as a parameter.

See also the [AWS documentation on Elastic IP (EIP)](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html).

## Properties

| Property | Description|
| --- | --- |
| public_ip | The Elastic IP address, or the carrier IP address. |
| instance_id | The ID of the instance the address is associated with, if any. |
| allocation_id | The allocation ID for the address. |
| association_id | The association ID for the address. |
| domain | Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc). |
| network_interface_id | The ID of the network interface that the address is associated with, if any. |
| network_interface_owner_id | The AWS account ID of the owner. |
| private_ip_address | The private IP address associated with the Elastic IP address. |
| public_ipv_4_pool | The Elastic IPV4 pool address. |
| network_border_group | A unique set of Availability Zones, Local Zones, or Wavelength Zones from where AWS advertises IP addresses. |

## Examples

##### Ensure a Public IP is available.
    describe aws_ec2_eip(public_ip: '18.192.107.8') do
      its('public_ip') { should eq '18.192.107.8' }
    end

##### Ensure that the domain is vpc or standard.
    describe aws_ec2_eip(public_ip: '18.192.107.8') do
        its('domain') { should eq 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the describe returns at least one result.

#### exist

Use `should_not` to test the entity should not exist.

    describe aws_ec2_eip(public_ip: '18.192.107.8') do
      it { should exist }
    end
      
    describe aws_vpc_endpoint(public_ip: '18.192.101.8') do
      it { should_not exist }
    end

#### be_available

Checks if the Addresses is in available state.
Use `should_not` to test the entity should not exist.

    describe aws_ec2_eip(public_ip: '18.192.107.8') do
      it { should be_available }
    end
      
    describe aws_ec2_eip(public_ip: '18.192.101.8') do
      it { should_not be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeAddresses` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
