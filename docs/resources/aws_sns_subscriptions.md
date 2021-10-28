---
title: About the aws_sns_subscriptions Resource
platform: aws
---

# aws_sns_subscriptions

Use the `aws_sns_subscriptions` InSpec audit resource to test properties of an AWS Simple Notification Service (SNS) subscription VPN route.

The `AWS::SNS::Subscription` resource subscribes an endpoint to an Amazon SNS topic. For a subscription to be created, the owner of the endpoint must confirm the subscription.

## Syntax

Ensure that the subscription exists.

    describe aws_sns_subscriptions do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS SNS subscriptions.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sns-subscription.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| subscription_arns | The subscription's ARN. | subscription_arn |
| owners | The subscription's owner. | owner |
| protocols | The subscription's protocol. | protocol |
| endpoints | The subscription's endpoint (format depends on the protocol). | endpoint |
| topic_arns | The ARN of the subscription's topic. | topic_arn |

## Examples

### Ensure a subscription ARN is available.

    describe aws_sns_subscriptions do
      its('subscription_arns') { should include 'SUBSCRIPTION_ARN' }
    end

### Ensure a topic ARN is available.

    describe aws_sns_subscriptions do
        its('topic_arns') { should include 'TOPIC_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_sns_subscriptions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_sns_subscriptions do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_sns_subscriptions do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SNS:Client:ListSubscriptionsResponse` action with `Effect` set to `Allow`.
