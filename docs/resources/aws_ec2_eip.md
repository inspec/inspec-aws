---
title: About the aws_ec2_eip Resource
platform: aws
---

# aws\_ec2\_eip

Use the `aws_ec2_eip` InSpec audit resource to test properties of a single specific Elastic IP (EIP).

An Elastic IP (EIP) is uniquely identified by the public IPv4 address, for example `192.0.2.0`.

## Syntax

Ensure that a Public IP exists.

    describe aws_ec2_eip(public_ip: '192.0.2.0') do
      it { should exist }
    end

## Parameters

`public_ip` _(required)_

For additional information, see the [AWS documentation on Elastic IP (EIP)](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html).

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

### Ensure a Public IP is available.
    describe aws_ec2_eip(public_ip: '192.0.2.0') do
      its('public_ip') { should eq '192.0.2.0' }
    end

### Ensure that the domain is `vpc` or `standard`.
    describe aws_ec2_eip(public_ip: '192.0.2.0') do
        its('domain') { should eq 'vpc' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_eip(public_ip: '192.0.2.0') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_vpc_endpoint(public_ip: '192.0.2.0') do
      it { should_not exist }
    end

### be_available

Check if the IP address is available.

    describe aws_ec2_eip(public_ip: '192.0.2.0') do
      it { should be_available }
    end

Use `should_not` to test an IP address that should not exist.

    describe aws_ec2_eip(public_ip: '192.0.2.0') do
      it { should_not be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeAddressesResult` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
