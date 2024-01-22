+++
title = "aws_cloudwatchlogs_log_stream Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatchlogs_log_stream"
identifier = "inspec/resources/aws/aws_cloudwatchlogs_log_stream Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatchlogs_log_stream` InSpec audit resource to test properties of the singular resource of AWS Logs log stream.

The AWS::Logs::LogStream resource specifies an Amazon CloudWatch Logs log stream in a specific log group. A log stream represents the sequence of events coming from an application instance or resource you are monitoring.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Logs LogStream.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-logstream.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the log stream exists.

```ruby
describe aws_cloudwatchlogs_log_stream(log_group_name: "LOG_GROUP_NAME", log_stream_name_prefix: 'LOG_STREAM_NAME') do
  it { should exist }
end
```

## Parameters

`log_group_name` and `log_stream_name_prefix` _(required)_

`log_group_name`
: The name of the log group where the log stream is created.

`log_stream_name_prefix`
: The name of the log stream.

## Properties

`log_stream_name`
: The name of the log stream. The name must be unique within the log group.

`creation_time`
: The creation time of the stream, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

`first_event_timestamp`
: The time of the first event, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

`last_event_timestamp`
: The time of the most recent log event in the log stream in CloudWatch Logs.

`last_ingestion_time`
: The ingestion time, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

`upload_sequence_token`
: The sequence token.

`arn`
: The Amazon Resource Name (ARN) of the log stream.

`stored_bytes`
: The number of bytes stored.

## Examples

**Ensure a log stream name is available.**

```ruby
describe aws_cloudwatchlogs_log_stream(log_group_name: "LOG_GROUP_NAME", log_stream_name_prefix: 'LOG_STREAM_NAME') do
  its('log_stream_name') { should eq 'LOG_STREAM_NAME' }
end
```

**Ensure a log stream ARN is available.**

```ruby
describe aws_cloudwatchlogs_log_stream(log_group_name: "LOG_GROUP_NAME", log_stream_name_prefix: 'LOG_STREAM_NAME') do
    its('arn') { should eq 'LOG_STREAM_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatchlogs_log_stream(log_group_name: "LOG_GROUP_NAME", log_stream_name_prefix: 'LOG_STREAM_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudwatchlogs_log_stream(log_group_name: "LOG_GROUP_NAME", log_stream_name_prefix: 'LOG_STREAM_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudwatchlogs_log_stream(log_group_name: "LOG_GROUP_NAME", log_stream_name_prefix: 'LOG_STREAM_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeLogStreamsResponse" %}}
