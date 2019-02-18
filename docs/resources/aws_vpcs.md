---
title: About the aws_vpcs Resource
platform: aws
---

# aws\_vpcs

Use the `aws_vpcs` InSpec audit resource to test properties of some or all AWS Virtual Private Clouds (VPCs).

A VPC is a networking construct that provides an isolated environment. A VPC is contained in a geographic region, but spans availability zones in that region. A VPC may have multiple subnets, internet gateways, and other networking resources. Computing resources--such as EC2 instances--reside on subnets within the VPC.

Each VPC is uniquely identified by its VPC ID. In addition, each VPC has a non-unique CIDR IP Address range (such as 10.0.0.0/16) which it manages.

Every AWS account has at least one VPC, the "default" VPC, in every region.

<br>

## Syntax

An `aws_vpcs` resource block uses an optional filter to select a group of VPCs and then tests that group.

    # The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # Since you always have at least one VPC, this will always pass.
    describe aws_vpcs do
      it { should exist }
    end

    # Insist that all VPCs use the same DHCP option set.
    describe aws_vpcs.where { dhcp_options_id != 'dopt-12345678' } do
      it { should_not exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Check for a Particular VPC ID

    describe aws_vpcs do
      its('vpc_ids') { should include 'vpc-12345678' }
    end

### Use the VPC IDs to Get a List of Default Security Groups

    aws_vpcs.vpc_ids.each do |vpc_id|
      describe aws_security_group(vpc_id: vpc_id, group_name: 'default') do
        it { should_not allow_in(port: 22) }
      end
    end

<br>

## Filter Criteria

### cidr_block

Filters the results to include only those VPCs that match the given IPv4 range.  This is a string value.

    # We shun the 10.0.0.0/8 space
    describe aws_vpcs.where { cidr_block.start_with?('10') } do
      it { should_not exist }
    end

### dhcp_option_id

Filters the results to include only those VPCs that have the given DHCP Option Set.

    # Insist on one DHCP option set for all VPCs.
    describe aws_vpcs.where { dhcp_options_id != 'dopt-12345678' } do
      it { should_not exist }
    end

## Properties

### cidr_blocks

The cidr_blocks property provides a list of the CIDR blocks that the matched VPCs serve as strings.

    describe aws_vpcs do
      # This is simple array membership checking - not subnet membership
      its('cidr_blocks') { should include '179.0.0.0/16' }
    end

### dhcp_options_ids

The dhcp_option_set_ids property provides a de-duplicated list of the DHCP Option Set IDs that the matched VPCs use when assigning IPs to resources.

    describe aws_vpcs do
      its('dhcp_options_ids') { should include 'dopt-12345678' }
    end

### vpc_ids

The vpc_ids property provides a list of the IDs of the matched VPCs.

    describe aws_vpcs do
      its('vpc_ids') { should include 'vpc-12345678' }
    end

    # Get a list of all VPC IDs
    aws_vpcs.vpc_ids.each do |vpc_id|
      # Do something with vpc_id
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # You will always have at least one VPC
    describe aws_vpcs
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpcs` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
