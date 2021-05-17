---
title: About the aws_vpcs Resource
platform: aws
---

# aws\_vpcs

Use the `aws_vpcs` InSpec audit resource to test properties of some or all AWS Virtual Private Clouds (VPCs)and the CIDR Block that is used within the VPC.

Each VPC is uniquely identified by its `VPC ID`. In addition, each VPC has a non-unique CIDR IP address range (such as 10.0.0.0/16), which it manages.

Every AWS account has at least one VPC, the "default" VPC, in every region.

## Syntax

An `aws_vpcs` resource block uses an optional filter to select a group of VPCs and then tests that group.

    # Since you always have at least one VPC, this will always pass.
    describe aws_vpcs do
      it { should exist }
    end

#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on VPCs](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).

## Properties

|Property           | Description|
| ---               | --- |
|cidr\_blocks       | The cidr\_blocks property provides a list of the CIDR blocks that the matched VPCs serve as strings. |
|dhcp\_options\_ids | The dhcp\_option\_set\_ids property provides a de-duplicated list of the DHCP Option Set IDs that the matched VPCs use when assigning IPs to resources. |
|vpc\_ids           | The vpc\_ids property provides a list of the IDs of the matched VPCs. |
|tags               | A hash of key-value pairs corresponding to the tags associated with the entity. |
|entries            | Provides access to the raw results of the query, which can be treated as an array of hashes. |
|ipv\_6\_cidr\_block\_association\_sets | The IPv6 CIDR block associated with the VPC. |
|cidr\_block\_association\_set (association\_id) | The association ID for a CIDR block associated with the VPC. |
|cidr\_block\_association\_set (cidr\_block\_state (state)) | The state of a CIDR block associated with the VPC. |
|cidr\_block\_association\_set (cidr\_block\_state (status\_message)) | The status message of a CIDR block associated with the VPC. |

## Examples

### Ensure all VPCs use the same DHCP option set.
    describe aws_vpcs.where { dhcp_options_id != 'dopt-12345678' } do
      it { should_not exist }
    end


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

### We shun the `10.0.0.0/8` space
    describe aws_vpcs.where { cidr_block.start_with?('10') } do
      it { should_not exist }
    end

### Check tags
    describe aws_vpc do
      its('tags') { should include(:Environment => 'env-name',
                                   :Name => 'vpc-name')}
    end

### Ensure AWS VPC CIDR Block plural resource has the correct properties.
    describe aws_vpcs do
    it { should exist }
    its('count')             { should be <= 100 }
    its('cidr_blocks')       { should include aws_vpc_cidr_block }
    its ('ipv_6_cidr_block_association_sets') { should_not be_empty }
    its ('cidr_block_association_sets') { should_not be_empty }
    its('cidr_block_association_sets')       { should include(cidr_block_association_set_association_ids: aws_cidr_block_association_set_association_id,
                                                              cidr_block_association_set_status_messages: aws_cidr_block_association_set_cidr_block_state_state,
                                                              cidr_block_association_set_statuses: aws_cidr_block_association_set_cidr_block_state_status_message) }
    its ('ipv_6_cidr_block_association_set') { should be_empty }
end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_vpcs do
      it { should exist }
    end

    describe aws_vpcs.where( <property>: <value>) do
      it { should_not exist }
    end

### include

    describe aws_vpcs do
        its('cidr_block_association_sets') { should include(cidr_block_association_set_association_ids: aws_cidr_block_association_set_association_id,
                                                              cidr_block_association_set_status_messages: aws_cidr_block_association_set_cidr_block_state_state,
                                                                cidr_block_association_set_statuses: aws_cidr_block_association_set_cidr_block_state_status_message) }
    end

### be_empty

    describe aws_vpcs do
        its ('cidr_block_association_set.first.cidr_block_state.status_message') { should be_empty }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpcs` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
