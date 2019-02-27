---
title: About the aws_route_table Resource
platform: aws
---

# aws\_route\_table

Use the `aws_route_table` InSpec audit resource to test properties of a single Route Table. A route table contains a set of rules, called routes, that are used to determine where network traffic is directed.

<br>

## Syntax

This resource expects a single parameter that uniquely identifies the Route Table. You may pass it as a string, or as the value in a hash:

    describe aws_route_table('rtb-123abcde') do
      it { should exist }
    end
    # Same
    describe aws_route_table(route_table_id: 'rtb-123abcde') do
      it { should exist }
    end


<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Confirm that the route table has expected VPC identifier

    describe aws_route_table(route_table_id: 'rtb-123abcde') do
      its('vpc_id') { should eq 'vpc-01625e36123456789' }
    end

### Confirm that the route table has expected owner identifier

    describe aws_route_table(route_table_id: 'rtb-123abcde') do
      its('owner_id') { should eq '123456789012' }
    end

### Ensure the expected number of routes is present

    describe aws_route_table(route_table_id: 'rtb-123abcde') do
      its('routes.count') { should eq 2 }
    end

### Ensure the expected number of associations is present

    describe aws_route_table(route_table_id: 'rtb-123abcde') do
      its('associations.count') { should eq 1 }
    end

### Ensure there are no virtual private gateway (VGW) propagating routes

    describe aws_route_table(route_table_id: 'rtb-123abcde') do
      its('propagating_vgws') { should be_empty }
    end

<br>

## Properties

* associations
* owner_id
* propagating_vgws
* route_table_id
* routes
* tags
* vpc_id

<br>


## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Indicates that the Route Table provided was found.  Use `should_not` to test for Route Tables that should not exist.

    describe aws_route_table('should-be-there') do
      it { should exist }
    end

    describe aws_route_table('should-not-be-there') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeRouteTables` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
