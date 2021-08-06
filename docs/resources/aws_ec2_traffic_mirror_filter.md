---
title: About the aws_ec2_traffic_mirror_filter Resource
platform: aws
---

# aws\_ec2\_launch_\template

Use the `aws_ec2_traffic_mirror_filter` InSpec audit resource to test properties of a single AWS Traffic Mirror Filter.

## Syntax

An `aws_ec2_traffic_mirror_filter` resource block declares the tests for a single  AWS Traffic Mirror Filter by aws_ec2_traffic_mirror_filter_id.

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'tmf-01a2349e94458a507') do
      it { should exist }
    end

    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'my-tmf-id') do
      it { should exist }
    end

#### Parameters

traffic_mirror_filter_id must be be provided.

##### traffic\_mirror\_filter\_id_

The ID of the EC2 Traffic Mirror. This is in the format of `tmf-` followed by 8 or 17 hexadecimal characters.
This can be passed either as a string or as an `aws_ec2_traffic_mirror_filter_id: 'value'` key-value entry in a hash.



## Properties

|Property                 | Description|
| ---                     | --- |
|traffic_mirror_filter_id     | The id of a Traffic mirror filter.|
|description                  | The description of a Traffic mirror filter.|
|tags                         | A list of hashes with each key-value pair corresponding to an EC2 instance tag, e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

##### Test that an EC2 Traffic Mirror should exist
    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'tmf-01a2349e94458a507') do
      it { should exist }
    end

##### Test that an EC2 Traffic Mirror description is correct
    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'tmf-01a2349e94458a507') do
      its('description') { should eq 1 }
    end

##### Test that an EC2 Traffic Mirror has the correct tag
    describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: 'tmf-01a2349e94458a507') do
      its('tags') { should eq 'test-lt' }
    end

