---
title: About the aws_sns_topic Resource
---

# aws\_sns\_topic

Use the `aws_sns_topic` InSpec audit resource to test properties of a single AWS Simple Notification Service Topic.  SNS topics are channels for related events. AWS resources place events in the SNS topic, while other AWS resources _subscribe_ to receive notifications when new events have appeared.

<br>

## Syntax

    # Ensure that a topic exists and has at least one subscription
    describe aws_sns_topic('arn:aws:sns:*::my-topic-name') do
      it { should exist }
      its('confirmed_subscription_count') { should_not be_zero }
    end

    # You may also use has syntax to pass the ARN
    describe aws_sns_topic(arn: 'arn:aws:sns:*::my-topic-name') do
      it { should exist }
    end

## Resource Parameters

### ARN

This resource expects a single parameter that uniquely identifies the SNS Topic, an ARN. Amazon Resource Names for SNS topics have the format `arn:aws:sns:region:account-id:topicname`.  AWS requires a fully-specified ARN for looking up an SNS topic.  The account ID and region are required.  Wildcards are not permitted.

See also the [AWS documentation on ARNs](http://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).

<br>

## Properties

### confirmed\_subscription\_count

An integer indicating the number of currently active subscriptions.

    # Make sure someone is listening
    describe aws_sns_topic('arn:aws:sns:*::my-topic-name') do
      its('confirmed_subscription_count') { should_not be_zero}
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Indicates that the ARN provided was found.  Use `should_not` to test for SNS topics that should not exist.

    # Expect good news
    describe aws_sns_topic('arn:aws:sns:*::good-news') do
      it { should exist }
    end

    # No bad news allowed
    describe aws_sns_topic('arn:aws:sns:*::bad-news') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `sns:GetTopicAttributes` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SNS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsns.html).
