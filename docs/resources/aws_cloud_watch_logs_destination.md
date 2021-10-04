---
title: About the aws_cloud_watch_logs_destination Resource
platform: aws
---

# aws_cloud_watch_logs_destination

Use the `aws_cloud_watch_logs_destination` InSpec audit resource to test properties of a single specific AWS Logs Destination.

The AWS::Logs::Destination resource specifies a CloudWatch Logs destination. A destination encapsulates a physical resource (such as an Amazon Kinesis data stream) and enables you to subscribe that resource to a stream of log events.

## Syntax

Ensure that the destination name exists.

    describe aws_cloud_watch_logs_destination(destination_name_prefix: "DestinationName") do
      it { should exist }
    end

## Parameters

`destination_name_prefix` _(required)_

| Property | Description |
| --- | --- |
| destination_name_prefix | The name of the destination. |

For additional information, see the [AWS documentation on AWS::Logs::Destination.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| destination_name | The name of the destination. | destination_name |
| target_arn | The Amazon Resource Name (ARN) of the physical target where the log events are delivered (for example, a Kinesis stream). | target_arn |
| role_arn | A role for impersonation, used when delivering log events to the target. | role_arn |
| access_policy | An IAM policy document that governs which Amazon Web Services accounts can create subscription filters against this destination. | access_policy |
| arn | The ARN of this destination. | arn |
| creation_time | The creation time of the destination, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | creation_time |

## Examples

### Ensure a iam fleet role is available.
    describe aws_cloud_watch_logs_destination(destination_name_prefix: "DestinationName") do
      its('iam_fleet_role') { should eq 'IAMFleetRole' }
    end

### Ensure that the state is `active`.
    describe aws_cloud_watch_logs_destination(destination_name_prefix: "DestinationName") do
        its('spot_fleet_request_state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloud_watch_logs_destination(destination_name_prefix: "DestinationName") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloud_watch_logs_destination(destination_name_prefix: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloud_watch_logs_destination(destination_name_prefix: "DestinationName") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeDestinationsResponse` action with `Effect` set to `Allow`.