+++
title = "aws_sqs_queues resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_sqs_queues"
identifier = "inspec/resources/aws/aws_sqs_queues resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sqs_queues` InSpec audit resource to test properties of some or  all AWS Simple Queue Service queues.

For additional information, including details on parameters and properties, see the [AWS documentation on SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html).

## Syntax

```ruby
describe aws_sqs_queues() do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`arns`
: The ARNs of the SQS Queues.

`is_fifo_queues`
: A boolean value indicate if queues are a FIFO queues.

`visibility_timeouts`
: An integer indicating the visibility timeout of the message in seconds.

`maximum_message_sizes`
: An integer indicating the maximum message size in bytes.

`message_retention_periods`
: An integer indicating the maximum retention period for a message in seconds.

`delay_seconds`
: An integer indicating the delay in seconds for the queues.

`receive_message_wait_timeout_seconds`
: An integer indicating the number of seconds an attempt to recieve a message will wait before returning.

`content_based_deduplications`
: A boolean value indicate if content based dedcuplication is enabled or not.

## Examples

**Ensure that a queue exists and has a visibility timeout of 300 seconds.**

```ruby
describe aws_sqs_queues.where(queue_url: 'https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
  it { should exist }
  its('visibility_timeout') { should be 300 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_sqs_queues() do
  it { should exist }
end
```

```ruby
describe aws_sqs_queues() do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SQS:Client:GetQueueAttributesResult" %}}
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-using-identity-based-policies.html).
