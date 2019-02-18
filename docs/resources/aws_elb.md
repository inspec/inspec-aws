---
title: About the aws_elb Resource
platform: aws
---

# aws\_elb

Use the `aws_elb` InSpec audit resource to test properties of a single AWS Elastic Load Balancer (ELB, also known as a Classic Load Balancer).

To audit ELBs in bulk or to search, use `aws_elbs` (plural).

<br>

## Resource Parameters

An `aws_elb` resource block declares the tests for a single AWS ELB by ELB name.

    describe aws_elb('my-elb') do
      it { should exist }
    end

    describe aws_elb(load_balancer_name: 'my-elb') do
      its('instance_ids.count') { should cmp 2 }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that an ELB does not exist

    describe aws_elb('bad-elb') do
      it { should_not exist }
    end

### Test that an ELB has a presence in at least two availability zones

    describe aws_elb('web') do
      its('availability_zones.count') { should be > 1 }
    end

<br>

## Properties

### availability\_zones

Returns an array of strings identifying which availability zones in which the load balancer is located.

    # Verify we are in both us-east-2a and us-east-2b
    describe aws_elb('web-elb') do
      its('availability_zones') { should include 'us-east-2a' }
      its('availability_zones') { should include 'us-east-2b' }
    end

### dns\_name

Returns the FQDN of the load balancer.  This is the hostname which is exposed to the world.

    # Ensure that the ELB has a DNS name
    describe aws_elb('web-elb') do
      its('dns_name') { should match /\.com/ }
    end

### load\_balancer\_name

The name of the ELB within AWS. The load balancer name is unique within the region.

    # Ensure that the ELB's name is what we said it was
    describe aws_elb('web-elb') do
      its('load_balancer_name') { should match /web-elb/ }
    end

### external\_ports

Returns an array of integers reflecting the public-facing ports on which the load balancer will be listening for traffic.

    # Ensure that we are listening on port 80 and nothing else
    describe aws_elb('web-elb') do
      its('external_ports') { should include 80 }
      its('external_ports.count') { should cmp 1 }
    end

### instance\_ids

Returns an array of strings reflecting the instance IDs of the EC2 instances attached to the ELB.

    # Ensure that a specific instance is attached
    describe aws_elb('web-elb') do
      its('instance_ids') { should include 'i-12345678' }
    end


### internal\_ports

Returns an array of integers reflecting the EC2-facing ports on which the load balancer will be sending traffic to.

    # Ensure that we are sending traffic to port 80 on the instances and nothing else
    describe aws_elb('web-elb') do
      its('internal_ports') { should include 80 }
      its('internal_ports.count') { should cmp 1 }
    end

### security\_group\_ids

Returns an array of strings reflecting the security group IDs (firewall rule sets) assigned to the ELB.

    # Ensure that a specific SG ID is assigned
    describe aws_elb('web-elb') do
      its('security_group_ids') { should include 'sg-12345678' }
    end

### subnet\_ids

Returns an array of strings reflecting the subnet IDs on which the ELB is located.

    # Ensure that the ELB is on a specific subnet
    describe aws_elb('web-elb') do
      its('subnet_ids') { should include 'subnet-12345678' }
    end

### vpc\_id

Returns a String reflecting the ID of the VPC in which the ELB is located.

    # Ensure that the ELB is on a specific VPC
    describe aws_elb('web-elb') do
      its('vpc_id') { should cmp 'vpc-12345678' }
    end

<br>

## Matchers

This InSpec audit resource has no special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).


## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `elasticloadbalancing:DescribeLoadBalancers` action set to Allow.

You can find detailed documentation at [Authentication and Access Control for Your Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html)