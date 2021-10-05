---
title: About the aws_vpc Resource
platform: aws
---

# aws\_vpc

Use the `aws_vpc` InSpec audit resource to test the properties of a single AWS Virtual Private Cloud (VPC) and the CIDR Block that is used within the VPC.

Each VPC is uniquely identified by its ID. In addition, each VPC has a non-unique CIDR IP address range (such as 10.0.0.0/16), which it manages.

Every AWS account has at least one VPC, the "default" VPC, in every region.

## Syntax

An `aws_vpc` resource block identifies a VPC by ID. If no VPC ID is provided, the default VPC is used.

    # Find the default VPC
    describe aws_vpc do
      it { should exist }
    end

    # Find a VPC by ID
    describe aws_vpc('VPC-12345678987654321') do
      it { should exist }
    end

    # Hash syntax for ID
    describe aws_vpc(vpc_id: 'VPC-12345678') do
      it { should exist }
    end

#### Parameters

If no parameter is provided, the subscription's default VPC will be returned.

##### vpc\_id _(optional)_

This resource accepts a single parameter, the VPC ID.
This can be passed either as a string or as a `vpc_id: 'VALUE'` key-value entry in a hash.

See also the [AWS documentation on VPCs](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).

## Properties

|Property         | Description|
| ---             | --- |
|cidr\_block       | The IPv4 address range that is managed by the VPC. |
|dhcp\_options\_id  | The ID of the set of DHCP options associated with the VPC (or `default` if the default options are associated with the VPC). |
|instance\_tenancy | The allowed tenancy of the instances launched into the VPC. |
|state            | The state of the VPC. Valid values: `pending` and `available`. |
|vpc\_id           | The ID of the VPC. |
|tags             | The tags of the VPC. |
|associated_cidr_blocks | The associated CIDR blocks. |
|disassociated_cidr_blocks | The CIDR blocks that are disassociated. |
|failed_cidr_blocks | The failed CIDR block associations. |
|associating_cidr_blocks | The CIDR block associations that are yet in the pending stage. |
|disassociating | The CIDR block associations that are yet in the disassociating stage. |
|failing | The CIDR block associations that are yet in failing stage. |

## Examples

The following examples show how to use this InSpec audit resource.

### Test the CIDR Block of a named VPC

    describe aws_vpc('VPC-87654321') do
      its('cidr_block') { should cmp '10.0.0.0/16' }
    end

### Test the state of the VPC

    describe aws_vpc do
      its ('STATE') { should eq 'AVAILABLE' }
      # or equivalently
      it { should be_available }
    end

### Test the allowed tenancy of instances launched into the VPC

    describe aws_vpc do
      its ('INSTANCE_TENANCY') { should eq 'DEFAULT' }
      it { should be_default_instance }
      it { should_not be_dedicated_instance }
      it { should_not be_host_instance }
    end

### Test tags on the VPC

    describe aws_vpc do
      its('TAGS') { should include(:Environment => 'ENV-NAME',
                                   :Name => 'VPC-NAME')}
    end

### Test if the IPV6 CIDR Block is associated to a named VPC

    describe aws_vpc do
      it { should have_ipv6_cidr_block_associated?(aws_ipv_6_cidr_block_association_set_ipv_6_cidr_block) }
    end

### Test if the CIDR Block is associated to a named VPC

    describe aws_vpc do
      it { should have_cidr_block_associated?(aws_cidr_block) }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a complete list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_default

The test will pass if the identified VPC is the default VPC for the region.

    describe aws_vpc('VPC-87654321') do
      it { should be_default }
    end

### be\_available

The test will pass if the identified VPC has a `available` state.

    describe aws_vpc('VPC-87654321') do
      it { should be_available }
    end

### be\_pending

Check if the identified VPC has a `pending` state.

    describe aws_vpc('VPC-123456') do
        it { should be_pending }
    end

### be\_default\_instance

Check if the identified VPC has a `default` instance tendency.

    describe aws_vpc('VPC-87654321') do
        it { should be_default_instance }
    end

### be\_dedicated\_instance

Check if the identified VPC has a `dedicated` instance tendency.

    describe aws_vpc('VPC-87654321') do
        it { should be_dedicated_instance }
    end

### be\_host\_instance

Check if the identified VPC has a `host` instance tendency.

    describe aws_vpc('VPC-87654321') do
        it { should be_host_instance }
    end

### have\_cidr\_block\_associated

Check if a cidr block is associated to the identified VPC.

    describe aws_vpc('VPC-87654321') do
        it { should have_cidr_block_associated('10.0.0.0/27') }
    end

### have\_cidr\_block\_association\_failed

Check if a cidr block has failed to associated to the identified VPC.

    describe aws_vpc('VPC-87654321') do
        it { should have_cidr_block_failed('10.0.0.0/27') }
    end

### have\_cidr\_block\_disassociated

Check if a cidr block has failed to associated to the identified VPC.

    describe aws_vpc('VPC-87654321') do
        it { should have_cidr_block_disassociated('10.0.0.0/27') }
    end

### have\_ipv6\_cidr\_block\_associated

Check if the IPV6 cidr block is associated to the identified VPC.

    describe aws_vpc('VPC-87654321') do
      it { should have_ipv6_cidr_block_associated('2600:1f16:409:6700::/56') }
    end

### have\_ipv6\_cidr\_block\_disassociated

Check if the IPV6 cidr block is disassociated to the identified VPC.

    describe aws_vpc('VPC-87654321') do
      it { should have_ipv6_cidr_block_disassociated('2600:1f16:409:6700::/56') }
    end

### have\_ipv6\_cidr\_block\_association_failed

Check if the IPV6 cidr block failed to associate to the identified VPC.

    describe aws_vpc('VPC-87654321') do
      it { should have_ipv6_cidr_block_association_failed('2600:1f16:409:6700::/56') }
    end

### have\_network\_border\_group\_value

Check if the associated IPV6 cidr block has valid network border group value for the identified VPC.

    describe aws_vpc('VPC-87654321') do
      it { should have_network_border_group_value(ipv6_cidr_block: '2600:1f16:409:6700::/56', network_border_group: 'us-east-2a') }
    end

### have\_ipv6\_pool\_value

Check if the associated IPV6 cidr block has valid IPv6 Pool value for the identified VPC.

    describe aws_vpc('VPC-87654321') do
      it { should have_ipv6_pool_value(ipv6_cidr_block: '2600:1f16:409:6700::/56', ipv6_pool: 'Amazon') }
    end

## AWS Permissions

To set the permission for the [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal), you need the `ec2:DescribeVpcs` action with effect set to `Allow`.

You can find the detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).