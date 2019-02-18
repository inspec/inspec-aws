---
title: About the aws_regions Resource
platform: aws
---

# aws\_regions

Use the `aws_regions` InSpec audit resource to test properties of some or all AWS regions in bulk.  

Note that this resource lists all AWS regions that are currently available to the caller.

<br>

## Syntax

An `aws_regions` resource block uses an optional filter to select a group of regions and then tests that group.

    describe aws_regions.where { region_name: 'us-not-there-1' } do
      it { should_not exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Check for a Particular Region

    describe aws_regions do
      its('region_names') { should include 'eu-west-2' }
    end
    
    
### Check an endpoint exists

    describe aws_regions do
      its('endpoints') { should include 'ec2.eu-west-2.amazonaws.com' }
    end

### Use the regions resource to check single regions in more detail

    aws_regions.region_names.each do |aws_region_name|
      describe aws_region(region_name: aws_region_name) do
        it { should exist }
      end
    end

<br>


## Filter Criteria

This resource supports the following filter criteria:  `region_names` and `endpoints`. Any of these may be used with `where`, as a block or as a method.

## Properties

*  `region_names` - an array of aws_region name strings
*  `endpoints` - an array of aws_region url strings

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVpcs` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
