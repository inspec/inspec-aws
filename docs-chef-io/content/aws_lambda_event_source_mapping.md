+++
title = "aws_lambda_event_source_mapping resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_lambda_event_source_mapping"
identifier = "inspec/resources/aws/aws_lambda_event_source_mapping resource"
parent = "inspec/resources/aws"
+++

Use the `aws_lambda_event_source_mapping` InSpec audit resource to test properties of a single mapping between an AWS event source and an AWS Lambda function.

The `AWS::Lambda::EventSourceMapping` resource creates a mapping between an event source and an AWS Lambda function. Lambda reads items from the event source and triggers the function.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Lambda EventSourceMapping](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventsourcemapping.html).

## Syntax

Ensure that a UUID exists.

```ruby
describe aws_lambda_event_source_mapping(uuid: 'EVENT_SOURCE_MAPPING_UUID') do
  it { should exist }
end
```

## Parameters

`uuid` _(required)_

: The identifier of the event source mapping.

## Properties

`uuid`
: The identifier of the event source mapping.

`starting_position`
: The position in a stream from which to start reading. Required for Amazon Kinesis, Amazon DynamoDB, and Amazon MSK Streams sources. `AT_TIMESTAMP` is only supported for Amazon Kinesis streams.

`starting_position_timestamp`
: With `StartingPosition` set to `AT_TIMESTAMP`, the time from which to start reading.

`batch_size`
: The maximum number of items to retrieve in a single batch.

`maximum_batching_window_in_seconds`
: (Streams and SQS standard queues) The maximum amount of time to gather records before invoking the function, in seconds. The default value is zero.

`parallelization_factor`
: (Streams only) The number of batches to process from each shard concurrently. The default value is 1.

`event_source_arn`
: The Amazon Resource Name (ARN) of the event source.

`function_arn`
: The ARN of the Lambda function.

`last_modified`
: The date that the event source mapping was last updated, or its state changed.

`last_processing_result`
: The result of the last AWS Lambda invocation of your Lambda function.

`state`
: The state of the event source mapping. It can be one of the following: `Creating`, `Enabling`, `Enabled`, `Disabling`, `Disabled`, `Updating`, or `Deleting`.

`state_transition_reason`
: Indicates whether the last change to the event source mapping was made by a user, or by the Lambda service.

`destination_config (on_success (destination))`
: (Streams) An Amazon SQS queue or Amazon SNS topic destination for discarded records. The Amazon Resource Name (ARN) of the destination resource.

`destination_config (on_failure (destination))`
: The destination configuration for failed invocations. The Amazon Resource Name (ARN) of the destination resource.

`topics`
: The name of the Kafka topic.

`queues`
: (Amazon MQ) The name of the Amazon MQ broker destination queue to consume.

`source_access_configurations (type)`
: An array of the authentication protocol, or the VPC components to secure your event source. The type of authentication protocol or the VPC components for your event source. Valid values: `BASIC_AUTH`, `SASL_SCRAM_256_AUTH`, `SASL_SCRAM_512_AUTH`, `VIRTUAL_HOST`, `VPC_SECURITY_GROUP`, `VPC_SUBNET`.

`source_access_configurations (uri)`
: An array of the authentication protocol, or the VPC components to secure your event source. The value for your chosen configuration in Type. For example: `"URI": "arn:aws:secretsmanager:us-east-1:01234567890:secret:MyBrokerSecretName"`.

`maximum_record_age_in_seconds`
: (Streams only) Discard records older than the specified age. The default value is infinite (-1). When set to infinite (-1), failed records are retried until the record expires.

`bisect_batch_on_function_error`
: (Streams only) If the function returns an error, split the batch in two and retry. The default value is false.

`maximum_retry_attempts`
: (Streams only) Discard records after the specified number of retries. The default value is infinite (-1). When set to infinite (-1), failed records are retried until the record expires.

## Examples

Ensure an UUID is available:

```ruby
describe aws_lambda_event_source_mapping(uuid: 'EVENT_SOURCE_MAPPING_UUID') do
  its('uuid') { should eq 'EVENT_SOURCE_MAPPING_UUID' }
end
```

Ensure that the state is `Creating` or not:

```ruby
describe aws_lambda_event_source_mapping(uuid: 'EVENT_SOURCE_MAPPING_UUID') do
    its('state') { should eq 'Creating' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_lambda_event_source_mapping(uuid: 'EVENT_SOURCE_MAPPING_UUID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_lambda_event_source_mapping(uuid: 'EVENT_SOURCE_MAPPING_UUID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the uuid is available.

```ruby
describe aws_lambda_event_source_mapping(uuid: 'EVENT_SOURCE_MAPPING_UUID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Lambda:Client:EventSourceMappingConfiguration" %}}
