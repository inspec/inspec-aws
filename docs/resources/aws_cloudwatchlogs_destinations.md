---
title: About the aws_cloudwatchlogs_destinations Resource
platform: aws
---

# aws_cloudwatchlogs_destinations

Use the `aws_cloudwatchlogs_destinations` InSpec audit resource to test properties of multiple AWS Logs destinations.

The `AWS::Logs::Destination` resource type specifies a CloudWatch Logs destination. A destination encapsulates a physical resource (such as an Amazon Kinesis data stream) and enables you to subscribe that resource to a stream of log events.

## Syntax

Ensure that the destination name exists.

    describe aws_cloudwatchlogs_destinations do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS::Logs::Destination.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html).

## Properties

| Property            | Description   | Field                |
| :-----------------: | :-----------: | :------------------: |
| destination_names   | The name of the destination. | destination_name |
| target_arns         | The Amazon Resource Name (ARN) of the physical target where the log events are delivered (for example, a Kinesis stream). | target_arn |
| role_arns           | The ARN of an IAM role that permits CloudWatch Logs to send data to the specified AWS resource. | role_arn |
| access_policies     | An IAM policy document governing the Amazon Web Services accounts, which can create subscription filters against this destination. | access_policy |
| arns                | The ARN of this destination. | arn |
| creation_time      | The creation time of the destination, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | creation_time |

## Examples

### Ensure a destination name is available

    describe aws_cloudwatchlogs_destinations do
      its('destination_names') { should include 'DESTINATION_NAME' }
    end

### Ensure a destination role ARN is available

    describe aws_cloudwatchlogs_destinations do
        its('role_arns') { should include 'ROLE_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that an entity exists.

    describe aws_cloudwatchlogs_destinations do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_cloudwatchlogs_destinations do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeDestinationsResponse` action with `Effect` set to `Allow`.
