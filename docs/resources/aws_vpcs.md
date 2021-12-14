---
title: About the aws_vpcs Resource
platform: aws
---

# aws\_vpcs

Use the `aws_vpcs` InSpec audit resource to test the properties of some or all AWS Virtual Private Clouds (VPCs) and the CIDR block that is used within the VPC.

Each VPC is uniquely identified by its `VPC ID`. In addition, each VPC has a non-unique CIDR IP address range (such as 10.0.0.0/16), which it manages.

Every AWS account has at least one VPC, the "default" VPC, in every region.

This resource also have the functionality to test the CIDR block. The VPCCidrBlock associates a CIDR block with your VPC. You can only associate a single IPv6 CIDR block with your VPC. The IPv6 CIDR block size is fixed at /56.

## Syntax

An `aws_vpcs` resource block uses an optional filter to select a group of VPCs and then tests that group.

    # Since you always have at least one VPC, this will always pass.
    describe aws_vpcs do
      it { should exist }
    end

#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on VPCs](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
See also the [AWS documentation on VPCCidrBlock](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpccidrblock.html).

## Properties

|Property           | Description                           | Fields                        |
| ---               | ---                                   | ---                           |
| cidr\_blocks | The cidr\_blocks property provides a list of the CIDR blocks that the matched VPCs serve as strings. | cidr_block |
| dhcp\_options\_ids | The dhcp\_option\_set\_ids property provides a de-duplicated list of the DHCP option set IDs that the matched VPCs use when assigning IPs to resources. | dhcp_options_id |
| vpc\_ids | The vpc\_ids property provides a list of the IDs of the matched VPCs. | vpc_id |
| states   | The current state of the VPC. | state |
| instance_tenancies | The allowed tenancy of instances launched into the VPC. | instance_tenancy |
| is_default | Indicates whether the VPC is the default VPC. | is_default |
| defaults | List of all the VPCs that are default. | defaults |
| tags | A hash of key-value pairs corresponding to the tags associated with the entity. | tags |
| cidr_block_association_ids | List of all the association ID of the IPv4 CIDR blocks. | cidr_block_association_ids |
| associated_cidr_blocks | List of all the associated CIDR blocks. | associated_cidr_blocks |
| cidr_block_states | List of all the states of the CIDR blocks. | cidr_block_states |
| ipv6_cidr_block_association_ids | List of all the association ID of the IPv6 CIDR blocks. | ipv6_cidr_block_association_ids |
| ipv6_cidr_blocks | List of all the associated IPV6 CIDR blocks. | ipv6_cidr_blocks |
| ipv6_cidr_block_states | List of all the states of the IPV6 CIDR blocks. | ipv6_cidr_block_states |
| ipv6_network_border_groups | List of all the network border group options. | ipv6_network_border_groups |
| ipv6_pools | List of all IDs of the IPv6 address pool from which the IPv6 CIDR block is allocated. | ipv6_pools |
| entries | Provides access to the raw results of the query, which can be treated as an array of hashes. |  |

## Examples

### Ensure all VPCs use the same DHCP option set

    describe aws_vpcs.where { dhcp_options_id != 'DOPT-12345678' } do
      it { should_not exist }
    end

### Check for a Particular VPC ID

    describe aws_vpcs do
      its('vpc_ids') { should include 'VPC-12345678' }
    end

### Use the VPC IDs to get a list of Default Security Groups

    aws_vpcs.vpc_ids.each do |vpc_id|
      describe aws_security_group(vpc_id: vpc_id, group_name: 'DEFAULT') do
        it { should_not allow_in(port: 22) }
      end
    end

### We shun the `10.0.0.0/8` space

    describe aws_vpcs.where { cidr_block.start_with?('10') } do
      it { should_not exist }
    end

### Check tags

    describe aws_vpc do
      its('tags') { should include(:Environment => 'ENV-NAME',
                                   :Name => 'VPC-NAME')}
    end

### Ensure AWS VPC IPV6 CIDR Block plural resource has the correct properties

    describe aws_vpcs.where { ipv6_cidr_blocks.include?('2600:1F16:409:6700::/56') } do
        it { should exist }
    end

### Ensure AWS VPC CIDR BLOCK failed associations are not fetched

    describe aws_vpcs.where { cidr_block_states.reject?('FAILED') } do
        it { should exist }
    end

### Ensure AWS VPC CIDR Block plural resource has the associated id

    describe aws_vpcs do
        its ('CIDR_BLOCK_ASSOCIATION_IDS') { should include "VPC-CIDR-ASSOC-0123456789" }
    end

### Ensure AWS VPC IPv6 CIDR Block plural resource has the associated id

    describe aws_vpcs do
        its ('IPV6_CIDR_BLOCK_ASSOCIATION_IDS') { should include "VPC-CIDR-ASSOC-0123456789" }
    end

### Ensure AWS VPC CIDR BLOCK disassociated associations are fetched

    describe aws_vpcs.where { ipv6_cidr_block_states.select?('DISASSOCIATED') } do
        it { should exist }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a complete list of the available matchers, visit [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the `describe` returns at least one result.

Use `should_not` to test the entity should not exist

    describe aws_vpcs do
      it { should exist }
    end

    describe aws_vpcs.where( <property> : <value>) do
      it { should_not exist }
    end

### include

    describe aws_vpcs do
      its ('IPV_6_CIDR_ASSOCIATION_IDS')  { should include "VPC-CIDR-ASSOC-0123456789" }
      its ('IPV_6_CIDR_STATES') { should include "ASSOCIATED" }
      its ('IPV_6_CIDR_NETWORK_BORDER_GROUPS')  { should include "US-EAST-2" }
      its ('IPV_6_CIDR_IPV_6_POOLS')  { should include "AMAZON" }
    end

### be_empty

    describe aws_vpcs do
      its ('IPV_6_CIDR_STATUS_MESSAGES')  { should be_empty }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal), will need the `EC2:Client:DescribeVpcsResult` action with `Effect` set to `Allow`.

You can find detailed documentation at the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
