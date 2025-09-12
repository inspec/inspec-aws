+++
title = "aws_sqs_queue resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_sqs_queue"
identifier = "inspec/resources/aws/aws_sqs_queue resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sqs_queue` InSpec audit resource to test properties of a single AWS Simple Queue Service queue.

For additional information, including details on parameters and properties, see the [AWS documentation on SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html).

## Syntax

```ruby
describe aws_sqs_queue(queue_url: 'https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
  it { should exist }
end
```

## Parameters

`queue_url` _(required)_

: This resource accepts a single parameter, the SQS Queue URL.
  This can be passed either as a string or as a `queue_url: 'value'` key-value entry in a hash.

## Properties

`arn`
: The ARN of the SQS Queue.

`is_fifo_queue`
: A boolean value indicate if this queue is a FIFO queue.

`visibility_timeout`
: An integer indicating the visibility timeout of the message in seconds.

`maximum_message_size`
: An integer indicating the maximum message size in bytes.

`message_retention_period`
: An integer indicating the maximum retention period for a message in seconds.

`delay_seconds`
: An integer indicating the delay in seconds for the queue.

`receive_message_wait_timeout_seconds`
: An integer indicating the number of seconds an attempt to recieve a message will wait before returning.

`content_based_deduplication`
: A boolean value indicate if content based deduplication is enabled or not.

`redrive_policy`
: A string indicating the redrive policy.

`kms_master_id`
: Provides the ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK.

`kms_data_key_reuse_period_seconds`
: Returns the length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again.

`sqs_managed_enabled`
: Returns information about whether the queue is using SSE-SQS encryption using SQS-owned encryption keys.

`policy`
: Returns the policy of the queue.

## Examples

**Ensure that a queue exists and has a visibility timeout of 300 seconds.**

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
  it { should exist }
  its('visibility_timeout') { should be 300 }
end
```

**Ensure maximum message size is set.**

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
**256 KB      .**

end
```

**Test the delay time .**

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
    its('delay_seconds') { should be 0 }
end
```

**Ensure messages are retained for 4 days.**

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
**4 days.**

end
```

**Check if queue is fifo.**

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
    its('is_fifo_queue') { should be false }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueueWhichDoesntExist') do
  it { should_not exist }
end
```

### policy_statement_principal_all_permissions_enabled

The control will pass if at least one Principal has all permissions enabled.

Use `should` to test when a Principal with all permissions should exist.

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
  it { should be_policy_statement_principal_all_permissions_enabled }
end
```

Use `should_not` to test that a Principal with all permissions should not exist.

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueueWhichDoesntExist') do
  it { should_not be_policy_statement_principal_all_permissions_enabled }
end
```

### policy_statement_action_all_permissions_enabled

The control will pass if at least one action has all permissions enabled.

Use `should` to test that at least one action has all permissions enabled should exist.

```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
  it { should be_policy_statement_action_all_permissions_enabled }
end
```ruby
describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueueWhichDoesntExist') do
  it { should_not be_policy_statement_action_all_permissions_enabled }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SQS:Client:GetQueueAttributesResult" %}}
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-using-identity-based-policies.html).
