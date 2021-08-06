---
title: About the aws_ec2_traffic_mirror_filters Resource
platform: aws
---

# aws_\ec2_\traffic_\mirror_\filters

Use the `aws_ec2_traffic_mirror_filters` InSpec audit resource to test properties of a multiple AWS Traffic Mirror Filter.

## Syntax

An `aws_ec2_traffic_mirror_filters` resource block declares the tests for a set of  AWS Traffic Mirror Filter by aws_ec2_traffic_mirror_filters_id.

    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end

    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end

#### Parameters

No required parameters

## Properties

|Property                 | Description|
| ---                     | --- |
|traffic_mirror_filter_ids     | The id of a Traffic mirror filter.|
|descriptions                  | The description of a Traffic mirror filter.|
|tags                         | A list of hashes with each key-value pair corresponding to an EC2 instance tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

##### Test that EC2 Traffic Mirror filters should exist
    describe aws_ec2_traffic_mirror_filters do
      it { should exist }
    end

##### Test that EC2 Traffic Mirror filter's description is correct
    describe aws_ec2_traffic_mirror_filters do
      its('description') { should include 'test-des' }
    end

##### Test that an EC2 Traffic Mirror has the correct tag
    describe aws_ec2_traffic_mirror_filters do
      its('tags') { should eq 'test-tmf' }
    end

