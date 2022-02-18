---
title: About the aws_ec2_traffic_mirror_sessions Resource
platform: aws
---

# aws_ec2_traffic_mirror_sessions

Use the `aws_ec2_traffic_mirror_sessions` InSpec audit resource to test properties of all AWS Traffic Mirror sessions.

## Syntax

An `aws_ec2_traffic_mirror_sessions` resource block declares the tests for all the  AWS Traffic Mirror sessions.

```ruby
describe aws_ec2_traffic_mirror_sessions do
  it { should exist }
end
```

## Parameters

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on the `AWS::Batch::JobDefinition` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).


For additional information, see [the API reference documentation for AWS Traffic Mirror Session](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_TrafficMirrorSession.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| traffic_mirror_session_ids | The ID for the Traffic Mirror session.| traffic_mirror_session_id |
| traffic_mirror_target_ids | The ID of the Traffic Mirror target. | traffic_mirror_target_id |
| traffic_mirror_filter_ids | The ID of the Traffic Mirror filter.| traffic_mirror_filter_id |
| network_interface_ids | The ID of the Traffic Mirror session's network interface. | network_interface_id |
| owner_ids | The ID of the account that owns the Traffic Mirror session.| owner_id |
| packet_lengths | The number of bytes in each packet to mirror. | packet_length |
| session_numbers | The session number determines the order in which sessions are evaluated when an interface is used by multiple sessions. | session_number |
| virtual_network_ids | The virtual network ID associated with the Traffic Mirror session. | virtual_network_id |
| descriptions | The description of the Traffic Mirror session. | description |
| tags  | The tags assigned to the Traffic Mirror session.| tags |


## Examples

### Test that an AWS Traffic Mirror session exists

    describe aws_ec2_traffic_mirror_sessions do
      it { should exist }
    end

### Test that Traffic Mirror target includes a value

    describe aws_ec2_traffic_mirror_sessions do
      its('traffic_mirror_target_ids') { should include 'TRAFFIC_MIRROR_TARGET_ID' }
    end

### Test the a Traffic Mirror session has a description.

    describe aws_ec2_traffic_mirror_sessions do
      its('description') { should include 'DESCRIPTION_TEXT' }
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_traffic_mirror_sessions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_traffic_mirror_sessions do
      it { should_not exist }
    end
### be_available

Check if the Traffic mirror session is available.

    describe aws_ec2_traffic_mirror_sessions do
      it { should be_available }
    end

Use `should_not` to test a Traffic mirror session that should not exist.

    describe aws_ec2_traffic_mirror_sessions do
      it { should_not be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeTrafficMirrorSessionsResult` action with Effect set to Allow.
