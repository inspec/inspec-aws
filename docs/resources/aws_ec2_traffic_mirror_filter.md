---
title: About the aws_ec2_traffic_mirror_filter Resource
platform: aws
---

# aws\_ec2\_traffic\_mirror\_filter

Use the `aws_ec2_traffic_mirror_filter` InSpec audit resource to test properties of a single AWS traffic mirror filter.

## Syntax

An `aws_ec2_traffic_mirror_filter` resource block declares the tests for a single AWS traffic mirror filter.

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
      it { should exist }
    end

    describe aws_ec2_traffic_mirror_filter('TRAFFIC_MIRROR_FILTER_ID') do
      it { should exist }
    end

## Parameters

`traffic_mirror_filter_id` _(required)_

The ID of the EC2 traffic mirror. This is in the format of `tmf-` followed by 8 or 17 hexadecimal characters.
This can be passed either as a string or as an `aws_ec2_traffic_mirror_filter_id: 'value'` key-value entry in a hash.

## Properties

|Property                     | Description|
| ---                         | --- |
|traffic_mirror_filter_id     | The ID of a traffic mirror filter.|
|description                  | The description of a traffic mirror filter.|
|tags                         | A list of hashes with each key-value pair corresponding to a traffic mirror tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TrafficMirrorFilter.html)

## Examples

### Test that an EC2 traffic mirror should exist

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
      it { should exist }
    end

### Test that an EC2 traffic mirror description is correct

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
      its('description') { should eq "DESCRIPTION_TEXT" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
      it { should_not exist }
    end

### be_available

Check if the test the entity is available.

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'TRAFFIC_MIRROR_FILTER_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeTrafficMirrorFiltersResult` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
