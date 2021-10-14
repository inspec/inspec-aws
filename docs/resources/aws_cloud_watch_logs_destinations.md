---
title: About the aws_cloudwatch_logs_destinations Resource
platform: aws
---

# aws_cloudwatch_logs_destinations

Use the `aws_cloudwatch_logs_destinations` InSpec audit resource to test properties of the plural resource of AWS Logs Destination.

The AWS::Logs::Destination resource specifies a CloudWatch Logs destination. A destination encapsulates a physical resource (such as an Amazon Kinesis data stream) and enables you to subscribe that resource to a stream of log events.

## Syntax

Ensure that the destination name exists.

    describe aws_cloudwatch_logs_destinations do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS::Logs::Destination.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| destination_names | The name of the destination. | destination_name |
| target_arns | The Amazon Resource Name (ARN) of the physical target where the log events are delivered (for example, a Kinesis stream). | target_arn |
| role_arns | A role for impersonation, used when delivering log events to the target. | role_arn |
| access_policies | An IAM policy document that governs which Amazon Web Services accounts can create subscription filters against this destination. | access_policy |
| arns | The ARN of this destination. | arn |
| creation_times | The creation time of the destination, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | creation_time |

## Examples

### Ensure a destination name is available.
    describe aws_cloudwatch_logs_destinations do
      its('destination_names') { should include 'DestinationName' }
    end

### Ensure a destination role arn is available.
    describe aws_cloudwatch_logs_destinations do
        its('role_arns') { should include 'RoleARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_logs_destinations do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_logs_destinations do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeDestinationsResponse` action with `Effect` set to `Allow`.