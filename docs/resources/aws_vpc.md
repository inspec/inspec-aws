---
title: About the aws_vpc Resource
platform: aws
---

# aws\_vpc

Use the `aws_vpc` InSpec audit resource to test properties of a single AWS Virtual Private Cloud (VPC).

To test properties of all or multiple VPCs, use the `aws_vpcs` resource.

A VPC is a networking construct that provides an isolated environment. A VPC is contained in a geographic region, but spans availability zones in that region. A VPC may have multiple subnets, internet gateways, and other networking resources. Computing resources--such as EC2 instances--reside on subnets within the VPC.

Each VPC is uniquely identified by its VPC ID. In addition, each VPC has a non-unique CIDR IP Address range (such as 10.0.0.0/16) which it manages.

Every AWS account has at least one VPC, the "default" VPC, in every region.

<br>

## Syntax

An `aws_vpc` resource block identifies a VPC by id. If no VPC ID is provided, the default VPC is used.

    # Find the default VPC
    describe aws_vpc do
      it { should exist }
    end

    # Find a VPC by ID
    describe aws_vpc('vpc-12345678987654321') do
      it { should exist }
    end

    # Hash syntax for ID
    describe aws_vpc(vpc_id: 'vpc-12345678') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a VPC does not exist

    describe aws_vpc('vpc-87654321') do
      it { should_not exist }
    end

    describe aws_vpc('vpc-abcd123454321dcba') do
      it { should_not exist }
    end

### Test the CIDR of a named VPC

    describe aws_vpc('vpc-87654321') do
      its('cidr_block') { should cmp '10.0.0.0/16' }
    end

<br>

## Properties

* `cidr_block`, `dhcp_options_id`, `state`, `vpc_id`, `instance_tenancy`

<br>

## Property Examples

### cidr\_block

The IPv4 address range that is managed by the VPC.

    describe aws_vpc('vpc-87654321') do
      its('cidr_block') { should cmp '10.0.0.0/16' }
    end

### dhcp\_options\_id

The ID of the set of DHCP options associated with the VPC (or `default` if the default options are associated with the VPC).

    describe aws_vpc do
      its ('dhcp_options_id') { should eq 'dopt-a94671d0' }
    end

### instance\_tenancy

The allowed tenancy of instances launched into the VPC.

    describe aws_vpc do
      its ('instance_tenancy') { should eq 'default' }
    end

### state

The state of the VPC (`pending` | `available`).

    describe aws_vpc do
      its ('state') { should eq 'available' }
    end

### vpc\_id

The ID of the VPC.

    describe aws_vpc do
      its('vpc_id') { should eq 'vpc-87654321' }
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_default

The test will pass if the identified VPC is the default VPC for the region.

    describe aws_vpc('vpc-87654321') do
      it { should be_default }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpcs` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
