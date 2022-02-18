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

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on the `AWS::Batch::JobDefinition` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).


See the [AWS documentation on Elastic IP (EIP)](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html) for additional information.

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| public_ips | The Elastic IP address, or the carrier IP address. | public_ip |
| instance_ids | The ID of the instance the address is associated with, if any. | instance_id |
| allocation_ids | The allocation ID for the address. | allocation_id |
| association_ids | The association ID for the address. | association_id |
| domains | Indicates whether the address is for use in EC2-Classic (standard) or in a VPC (vpc). | domain |
| network_interface_ids | The ID of the network interface that the address is associated with, if any. | network_interface_id |
| network_interface_owner_ids | The AWS account ID of the owner. | network_interface_owner_id |
| private_ip_addresses | The private IP address associated with the Elastic IP address. | private_ip_address |
| public_ipv_4_pools | The Elastic IPV4 pool address. | public_ipv_4_pool |
| network_border_groups | A unique set of Availability Zones, Local Zones, or Wavelength Zones from where AWS advertises IP addresses. | network_border_group |

## Examples

##### Match count of Elastic IP (EIP).
    describe aws_ec2_eips do
        its('count') { should eq 5 }
    end

##### Check Allocation ID whether it is correct or not
    describe aws_ec2_eips do
       its('allocation_ids') { should include "ALLOCATION_ID" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should` to test that the entity exists.

    describe aws_ec2_eips do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_eips do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeAddressesResult` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
