---
title: About the aws_subnet Resource
platform: aws
---

# aws\_subnet

Use the `aws_subnet` InSpec audit resource to test properties of a vpc subnet.

To test properties of a single VPC subnet, use the `aws_subnet` resource.

To test properties of all or a group of VPC subnets, use the `aws_subnets` resource.

<br>

## Syntax

An `aws_subnet` resource block uses the parameter to select a VPC and a subnet in the VPC.

    describe aws_subnet(subnet_id: 'subnet-1234567') do
      it { should exist }
      its('cidr_block') { should eq '10.0.1.0/24' }
    end

<br>

## Resource Parameters

This InSpec resource accepts the following parameters, which are used to search for the VPCs subnet.

### subnet\_id

A string identifying the subnet that the VPC contains.

    # This will error if there is more than the default SG
    describe aws_subnet(subnet_id: 'subnet-12345678') do
      it { should exist }
    end

<br>

## Properties

* `availability_zone`, `available_ip_address_count`, `cidr_block`, `subnet_id`, `vpc_id`

<br>

## Property Examples

### availability\_zone

Provides the Availability Zone of the subnet.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      its('availability_zone') { should eq 'us-east-1c' }
    end

### available\_ip\_address\_count

Provides the number of available IPv4 addresses on the subnet.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      its('available_ip_address_count') { should eq 251 }
    end

### cidr\_block

Provides the block of ip addresses specified to the subnet.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      its('cidr_block') { should eq '10.0.1.0/24' }
    end

### subnet\_id

Provides the ID of the Subnet.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      its('subnet_id') { should eq 'subnet-12345678' }
    end

### vpc\_id

Provides the ID of the VPC the subnet is in.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      its('vpc_id') { should eq 'vpc-12345678' }
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### assigning\_ipv\_6\_address\_on\_creation

Detects if the network interface on the subnet accepts IPv6 addresses.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      it { should be_assigning_ipv_6_address_on_creation }
    end

### available

Provides the current state of the subnet.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      it { should be_available }
    end

### default\_for\_az

Detects if the subnet is the default subnet for the Availability Zone.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      it { should be_default_for_az }
    end

### exist

The `exist` matcher indicates that a subnet exists for the specified vpc.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      it { should exist }
    end

### mapping\_public\_ip\_on\_launch

Provides the VPC ID for the subnet.

    describe aws_subnet(subnet_id: 'subnet-12345678') do
      it { should be_mapping_public_ip_on_launch }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeSubnets` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
