---
title: About the aws_ec2_traffic_mirror_sessions Resource
platform: aws
---

# aws\_ec2\_traffic_\mirror_\sessions

Use the `aws_ec2_traffic_mirror_sessions` InSpec audit resource to test properties of a all the AWS Traffic Mirror Sessions.

## Syntax

An `aws_ec2_traffic_mirror_sessions` resource block declares the tests for a all the  AWS Traffic Mirror Sessions

describe aws_ec2_traffic_mirror_sessions do
  it { should exist }
end


##### aws_\ec2\_traffic\_mirror\_sessions

The ID of the AWS Traffic Mirror Session ID. This is in the format of `tms-` followed by 8 or 17 hexadecimal characters.
This can be passed either as a string or as an `aws_ec2_traffic_mirror_sessions: 'value'` key-value entry in a hash.

## Properties

|Property                     | Description|
| ---                         | --- |
|traffic_mirror_session_ids    | The ID for the Traffic Mirror session.|
|traffic_mirror_target_ids     | The ID of the Traffic Mirror target. |
|traffic_mirror_filter_ids    | The ID of the Traffic Mirror filter.|
|network_interface_ids         | The ID of the Traffic Mirror session's network interface. |
|owner_ids                     | The ID of the account that owns the Traffic Mirror session.|
|packet_length                | The number of bytes in each packet to mirror. |
|virtual_network_ids           | The virtual network ID associated with the Traffic Mirror session. |
|description                  | The description of the Traffic Mirror session. |
|tags                         | The tags assigned to the Traffic Mirror session., e.g, `[{:key=>"Name", :value=>"Testing Box"}, {:key=>"Environment", :value=>"Dev"}]`|

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_Instance.html)

## Examples

##### Test that an AWS Traffic Mirror Session should exist
describe aws_ec2_traffic_mirror_sessions do
  it { should exist }
end

##### Test that Traffic  mirror target includes a value
describe aws_ec2_traffic_mirror_sessions do
  its('traffic_mirror_target_id') { should include 'test-mirror-id' }
end

##### Test that description is present
describe aws_ec2_traffic_mirror_sessions do
  its('description') { should include 'test-description' }
end


## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/). 
