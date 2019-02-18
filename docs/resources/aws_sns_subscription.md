---
title: About the aws_sns_subscription Resource
---

# aws\_sns\_subscription

Use the `aws_sns_subscription` InSpec audit resource to test detailed properties of a AWS SNS Subscription.

<br>

## Syntax

An `aws_sns_subscription` resource block uses resource parameters to search for a SNS Subscription, and then tests that subscriptions properties.  If no Subscriptions match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.

    describe aws_sns_subscription('arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_sns_subscription`, its limited functionality precludes examples.

<br>

## Resource Parameters

This InSpec resource accepts the following parameters, which are used to search for the Security Group.

### subscription\_arn

The ARN (Amazon Resource Name) of the AWS SNS Subscription.

    # Using Hash syntax
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6') do
      it { should exist }
    end

    # Or omit hash syntax, rely on it being the default parameter
    describe aws_sns_subscription('arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6') do
      it { should exist }
    end

<br>

## Matchers

### exists

The control will pass if the specified Aws Subscription was found.  Use should_not if you want to verify that the specified Subscription does not exist.

    # Test that a specific subscription exists.
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6')
      it { should exist }
    end

    # Test that a Subscription does not exist.
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::NOGOOD:b214aff5-a2c7-438f-a753-8494493f2ff6')
      it { should_not exist }
    end

### be\_confirmation\_authenticated

Provides whether or not the subscription confirmation request was authenticated.

    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::NOGOOD:b214aff5-a2c7-438f-a753-8494493f2ff6')
      it { should be_confirmation_authenticated }
    end

### have\_raw\_message\_delivery

Provides whether or not the original message is passed as is, not formatted as a json or yaml.

    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::NOGOOD:b214aff5-a2c7-438f-a753-8494493f2ff6')
      it { should have_raw_message_delivery }
    end

## Properties

### endpoint

Provides the destination that the SNS Topic will send notifications to.

    # Inspect the endpoint
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      # If protocol is 'sms', this should be a phone number:
      its('endpoint') { should cmp '+16105551234' }
      # If protocol is 'email' or 'email-json', endpoint should be an email address
      its('endpoint') { should cmp 'myemail@example.com' }
      # If protocal is 'http', endpoint should be a URL beginning with 'https://'
      its('endpoint') { should cmp 'https://www.exampleurl.com' }
      # If the protocol is 'lambda', its endpoint should be the ARN of a AWS Lambda function
      its('endpoint') { should cmp 'rn:aws:lambda:us-east-1:account-id:function:myfunction' }
    end

### owner

Provides the AWS Owners ID.

    # Inspect the owners ID
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      its('owner') { should cmp '12345678' }
    end

### protocol

Provides the Subscriptions protocol used. For example http, https, email, email-json, sqs, etc.  For more information about protocols please visit https://docs.aws.amazon.com/sns/latest/api/API_Subscribe.html

    # Inspect the endpoint
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      its('protocol') { should cmp 'sqs' }
    end

### topic\_arn

Provides the SNS Topic arn that the Subscription is associated with.

    # Inspect the topic arn
    describe aws_sns_subscription(subscription_arn: 'arn:aws:sns:us-east-1::test-topic-01:b214aff5-a2c7-438f-a753-8494493f2ff6' ) do
      its('topic_arn') { should cmp 'arn:aws:sns:us-east-1::test-topic-01' }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `sns:GetSubscriptionAttributes` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SNS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsns.html).
