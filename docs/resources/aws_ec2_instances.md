---
title: About the aws_ec2_instances Resource
platform: aws
---

# aws\_ec2\_instances

Use the `aws_ec2_instances` InSpec audit resource to test properties of some or all AWS EC2 instances. To audit a single EC2 instance, use `aws_ec2_instance` (singular).

EC2 instances are the basic unit of computing within AWS.  An instance is a virtual machine that contains a running OS, and may be created or destroyed by code.

Each EC2 instance is uniquely identified by its ID.

<br>

## Syntax

An `aws_ec2_instances` resource block collects a group of EC2 Instances and then tests that group.

    # Ensure you have exactly 3 instances
    describe aws_ec2_instances do
      its('instance_ids.count') { should cmp 3 }
    end

    # Use the InSpec resource to enumerate IDs, then test in-depth using `aws_ec2_instance`.
    aws_ec2_instances.instance_ids.each do |instance_id|
      describe aws_ec2_instance(instance_id) do
        its('key_name') { should cmp 'admin-ssh-key' }
      end 
    end

<br>

## Examples

As this is the initial release of `aws_ec2_instances`, its limited functionality precludes examples.

<br>

## Filter Criteria

This resource currently does not support any filter criteria; it will always fetch all instances in the region.

## Properties

### entries

Provides access to the raw results of the query, which can be treated as an array of hashes. This can be useful for checking counts and other advanced operations.

    # Allow at most 100 EC2 Instances on the account
    describe aws_ec2_instances do
      its('entries.count') { should be <= 100}
    end


### instance_ids

Provides a list of the instance ids that were found in the query.

    describe aws_ec2_instances do
      its('instance_ids') { should include('i-12345678') }
      its('instance_ids.count') { should cmp 3) }
    end

<br>

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

### exist

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # Verify that at least one EC2 Instance exists.
    describe aws_ec2_instances
      it { should exist }
    end   

