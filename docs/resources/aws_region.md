---
title: About the aws_region Resource
platform: aws
---

# aws\_region

Use the `aws_region` InSpec audit resource to test properties of a single AWS region.

<br>

## Syntax

An `aws_region` resource block identifies an AWS region by id. If no region is provided, the current default is used.

    # Check a region exists
    describe aws_region('eu-west-2') do
      it { should exist }
    end

    describe aws_region(region_name: 'us-east-1') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test whether a region exists

    describe aws_region('region-not-real') do
      it { should_not exist }
    end

### Test the Region Endpoint

    describe aws_region(region_name: 'eu-west-2') do
      its('endpoint') { should eq 'ec2.eu-west-2.amazonaws.com' }
    end

<br>

## Properties

* `region_name`, `endpoint`

<br>

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeRegions` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
