---
title: About the aws_sqs_queue Resource
---

# aws\_sqs\_queue

Use the `aws_sqs_queue` InSpec audit resource to test properties of a single AWS Simple Queue Service queue. 

<br>

## Syntax

    # Ensure that a queue exists and has a visibility timeout of 300 seconds
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
      it { should exist }
      its('visibility_timeout') { should be 300 }
    end

    # You may also use hash syntax to pass the URL
    describe aws_sqs_queue(url: 'https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
      it { should exist }
    end

## Resource Parameters

### URL

This resource expects a single parameter, the SQS queue URL that uniquely identifies the SQS queue.

See also the [AWS documentation on SQS Queue identifiers](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-general-identifiers.html).

<br>

## Properties

### visibility\_timeout

An integer indicating the visibility timeout of the message in seconds
    
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
      its('visibility_timeout') { should be 300}
    end

### maximum\_message\_size

An integer indicating the maximum message size in bytes
    
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
        its('maximum_message_size') { should be 262144 } # 256 KB      
    end

### delay\_seconds

An integer indicating the delay in seconds for the queue
    
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
        its('delay_seconds') { should be 0 }
    end

### message\_retention\_period

An integer indicating the maximum retention period for a message in seconds
    
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
        its('message_retention_period') { should be 345600 } # 4 days
    end

### receive\_message\_wait\_timeout\_seconds

An integer indicating the number of seconds an attempt to recieve a message will wait before returning

    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
        its('receive_message_wait_timeout_seconds') { should be 2 }  
    end

### is\_fifo\_queue

A boolean value indicate if this queue is a FIFO queue

    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
        its('is_fifo_queue') { should be false }
    end

### content\_based\_deduplication

A boolean value indicate if content based dedcuplication is enabled or not

    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue.fifo') do
        its('is_fifo_queue') { should be true }
        its('content_based_deduplication') { should be true }
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Indicates that the URL provided was found.  Use `should_not` to test for SQS topics that should not exist.

    # Expect good news
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueue') do
      it { should exist }
    end

    # No bad news allowed
    describe aws_sqs_queue('https://sqs.ap-southeast-2.amazonaws.com/1212121/MyQueueWhichDoesntExist') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `sqs:GetQueueAttributes` action with Effect set to Allow.
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SQS](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-using-identity-based-policies.html).