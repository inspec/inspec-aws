---
title: About the aws_ebs_volumes Resource
platform: aws
---

# aws\_ebs\_volumes

Use the `aws_ebs_volumes` InSpec audit resource to test properties of some or all AWS EBS volumes. To audit a single EBS volume, use `aws_ebs_volume` (singular).

EBS volumes are persistent block storage volumes for use with Amazon EC2 instances in the AWS Cloud.

Each EBS volume is uniquely identified by its ID.

<br>

## Syntax

An `aws_ebs_volumes` resource block collects a group of EBS volumes and then tests that group.

    # Ensure you have exactly 3 volumes
    describe aws_ebs_volumes do
      its('volume_ids.count') { should cmp 3 }
    end

    # Use the InSpec resource to enumerate IDs, then test in-depth using `aws_ebs_volume`.
    aws_ebs_volumes.volume_ids.each do |volume_id|
      describe aws_ebs_volume(volume_id) do
        it { should exist }
        it { should be_encrypted }
        its('size') { should cmp 8 }
        its('iops') { should cmp 100 }
      end
    end

<br>

## Examples

As this is the initial release of `aws_ebs_volumes`, its limited functionality precludes examples.

<br>

## Filter Criteria

This resource currently does not support any filter criteria; it will always fetch all volumes in the region.

## Properties

### entries

Provides access to the raw results of the query, which can be treated as an array of hashes. This can be useful for checking counts and other advanced operations.

    # Allow at most 100 EBS volumes on the account
    describe aws_ebs_volumes do
      its('entries.count') { should be <= 100 }
    end

### volume_ids

Provides a list of the volume ids that were found in the query.

    describe aws_ebs_volumes do
      its('volume_ids') { should include 'vol-12345678' }
      its('volume_ids.count') { should cmp 3 }
    end

<br>

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 

### exist

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # Verify that at least one EBS volume exists
    describe aws_ebs_volumes do
      it { should exist }
    end   
