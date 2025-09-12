+++
title = "aws_lambda_event_source_mappings resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_event_source_mappings"
identifier = "inspec/resources/aws/aws_lambda_event_source_mappings resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_event_source_mappings` InSpec audit resource to test properties of multiple mappings between AWS event sources and AWS Lambda functions.

The `AWS::Lambda::EventSourceMapping` resource creates a mapping between an event source and an AWS Lambda function. Lambda reads items from the event source and triggers the function.

For additional information, including details on parameters and properties, see the [AWS documentation on Athena Work Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Syntax

Ensure that a mapping exists.

```ruby
describe aws_lambda_event_source_mappings do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`uuids`
: The identifier of the event source mapping.

`starting_positions`
: The position in a stream from which to start reading. Required for Amazon Kinesis, Amazon DynamoDB, and Amazon MSK Streams sources. `AT_TIMESTAMP` is only supported for Amazon Kinesis streams.

`starting_position_timestamps`
: With `StartingPosition` set to `AT_TIMESTAMP`, the time from which to start reading.

`batch_sizes`
: The maximum number of items to retrieve in a single batch.

`maximum_batching_window_in_seconds`
: (Streams and SQS standard queues) The maximum amount of time to gather records before invoking the function, in seconds. The default value is zero.

`parallelization_factors`
: (Streams) The number of batches to process from each shard concurrently. The default value is 1.

`event_source_arns`
: The Amazon Resource Name (ARN) of the event source.

`function_arns`
: The ARN of the Lambda function.

`last_modified`
: The date that the event source mapping was last updated, or its state changed.

`last_processing_results`
: The result of the last AWS Lambda invocation of your Lambda function.

`states`
: The state of the event source mapping. It can be one of the following: `Creating`, `Enabling`, `Enabled`, `Disabling`, `Disabled`, `Updating`, or `Deleting`.

`state_transition_reasons`
: Indicates whether the last change to the event source mapping was made by a user, or by the Lambda service.

`destination_configs`
: The destination configuration of the destination resource.

`topics`
: The name of the Kafka topic.

`queues`
: (Amazon MQ) The name of the Amazon MQ broker destination queue to consume.

`source_access_configurations`
: An array of the authentication protocol, or the VPC components to secure your event source.

`maximum_record_age_in_seconds`
: (Streams) Discard records older than the specified age. The default value is infinite (-1). When set to infinite (-1), failed records are retried until the record expires.

`bisect_batch_on_function_errors`
: (Streams only) If the function returns an error, split the batch in two and retry. The default value is false.

`maximum_retry_attempts`
: (Streams only) Discard records after the specified number of retries. The default value is infinite (-1). When set to infinite (-1), failed records are retried until the record expires.

## Examples

**Ensure an UUID is available.**

```ruby
describe aws_lambda_event_source_mappings do
  its('uuids') { should include 'EVENT_SOURCE_MAPPING_UUID' }
end
```

**Ensure that a mapping has the `Creating` state or not.**

```ruby
describe aws_lambda_event_source_mappings do
    its('states') { should include 'Creating' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_event_source_mappings do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_event_source_mappings do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_lambda_event_source_mappings do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:ListEventSourceMappingsResponse" %}}
