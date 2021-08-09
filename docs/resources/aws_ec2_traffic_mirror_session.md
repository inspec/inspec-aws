---
title: About the aws_ec2_traffic_mirror_sessions 
platform: aws
---

# aws\_ec2\_traffic_\mirror_\session

Use the `aws_ec2_traffic_mirror_session` InSpec audit resource to test properties an AWS Traffic Mirror Session

## Syntax

An `aws_ec2_traffic_mirror_session` resource block declares the tests for an  AWS Traffic Mirror Sessions

## Syntax

An `aws_ec2_traffic_mirror_session` resource block declares the tests for a single  AWS Traffic Mirror Session by traffic_mirror_session_id.

    describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'test-traffic_mirror_session_id') do
      it { should exist }
    end

#### Parameters

traffic_mirror_session_id must be be provided.

##### traffic\_mirror_\session_\id

The ID of the AWS Traffic Mirror Session. This is in the format of `tms-` followed by 8 or 17 hexadecimal characters.
This can be passed either as a string or as an `launch_template_id: 'value'` key-value entry in a hash.

## Properties

|Property                     | Description|
| ---                         | --- |
|traffic_mirror_session_id    | The ID for the Traffic Mirror session.|
|traffic_mirror_target_id     | The ID of the Traffic Mirror target. |
|traffic_mirror_filter_id     | The ID of the Traffic Mirror filter.|
|network_interface_id         | The ID of the Traffic Mirror session's network interface. |
|owner_id                     | The ID of the account that owns the Traffic Mirror session.|
|packet_length                | The number of bytes in each packet to mirror. |
|virtual_network_id           | The virtual network ID associated with the Traffic Mirror session. |
|description                  | The description of the Traffic Mirror session. |
|tags                         | The tags assigned to the Traffic Mirror session., e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

##### Test that a Traffic mirror session should exist
    describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'test-traffic_mirror_session_id') do
      it { should exist }
    end

##### Test the packet_length of a Traffic mirror session
    describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'test-traffic_mirror_session_id') do
      its('packet_length') { should eq 1 }
    end

##### Test that a Traffic mirror session has the correct ID 
    describe aws_ec2_traffic_mirror_session(traffic_mirror_session_id: 'test-traffic_mirror_session_id') do
      its('traffic_mirror_session_id') { should eq 'test-lt' }
    end

