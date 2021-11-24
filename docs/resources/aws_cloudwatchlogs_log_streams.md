---
title: About the aws_cloudwatchlogs_log_streams Resource
platform: aws
---

# aws_cloudwatchlogs_log_streams

Use the `aws_cloudwatchlogs_log_streams` InSpec audit resource to test properties of the plural resource of AWS Logs log stream.

The AWS::Logs::LogStream resource specifies an Amazon CloudWatch Logs log stream in a specific log group. A log stream represents the sequence of events coming from an application instance or resource that you are monitoring.

## Syntax

Ensure that the log stream exists.

    describe aws_cloudwatchlogs_log_streams(log_group_name: "LOG_GROUP_NAME") do
      it { should exist }
    end

## Parameters

`log_group_name` _(required)_

The name of the log group.

For additional information, see the [AWS documentation on AWS Logs LogStream.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-logstream.html).

## Properties

| Property           | Description                   | Field                      |
| :----------------: | :---------------------------: | :------------------------: |
| log_stream_names   | The name of the log stream.   | log_stream_name            |
| creation_times     | The creation time of the stream, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | creation_time |
| first_event_timestamps | The time of the first event, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | first_event_timestamp |
| last_event_timestamps | The time of the most recent log event in the log stream in CloudWatch Logs. | last_event_timestamp |
| last_ingestion_times | The ingestion time, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | last_ingestion_time |
| upload_sequence_tokens | The sequence token. | upload_sequence_token |
| arns | The Amazon Resource Name (ARN) of the log stream. | arn |
| stored_bytes | The number of bytes stored. | stored_bytes |

## Examples

### Ensure a log stream name is available

    describe aws_cloudwatchlogs_log_streams(log_group_name: "LOG_GROUP_NAME") do
      its('log_stream_names') { should include 'LOG_STREAM_NAME' }
    end

### Ensure a log stream arn is available

    describe aws_cloudwatchlogs_log_streams(log_group_name: "LOG_GROUP_NAME") do
        its('arns') { should include 'LOG_STREAM_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatchlogs_log_streams(log_group_name: "LOG_GROUP_NAME") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatchlogs_log_streams(log_group_name: "LOG_GROUP_NAME") do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeLogStreamsResponse` action with `Effect` set to `Allow`.
