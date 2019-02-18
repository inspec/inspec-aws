---
title: About the aws_route_tables Resource
---

# aws\_route\_table

Use the `aws_route_tables` InSpec audit resource to test properties of all or a group of Route Tables. A Route Table contains a set of rules, called routes, that are used to determine where network traffic is directed.

<br>

## Syntax

  # Ensure that there is at least one route table
  describe aws_route_tables do
    it { should exist }
  end

## Matchers

### exist

Indicates that at least one Route Table was found.  Use should_not to test that no Route Tables should exist.

    describe aws_route_tables do
      it { should exist }
    end

    describe aws_route_tables do
      it { should_not exist }
    end

## Properties

### vpc\_ids

Lists all VPCs that are in the Route Tables.

    describe aws_route_tables do
      its('vpc_ids') { should include 'vpc_12345678' }
    end


### route\_table\_ids

Lists all of the Route Table IDs.

    describe aws_route_tables do
      its('route_table_ids') { should include 'rtb-12345678' }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeRouteTables` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
