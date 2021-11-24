---
title: About the aws_ec2_eips Resource
platform: aws
---

# aws\_ec2\_eips

Use the `aws_ec2_eips` InSpec audit resource to test properties of some or all AWS Elastic IP addresses.

## Syntax

Verify that a public IP address exists.

    describe aws_ec2_eips do
      it { should exist }
    end

An `aws_eips` resource block uses an optional filter to select a group of Elastic IPs and then test that group.

## Parameters

This resource does not expect any parameters.

See the [AWS documentation on Elastic IP (EIP)](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html) for additional information.

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

##### Ensure a Elastic IP(EIP) has Public IP.
    describe aws_ec2_eips do
      it { should exist }
    end

##### Match count of Elastic IP(EIP).
    describe aws_ec2_eips do
        its('count') { should eq 5 }
    end

##### Check Allocation ID whether it is correct or not
    describe aws_ec2_eips do
       its('allocation_ids') { should include "eipassoc-0ew2bc8cde18191da" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ec2_eips do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeAddressesResult` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
