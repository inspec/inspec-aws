---
title: About the aws_rds_event_subscription Resource
platform: aws
---

# aws_rds_event_subscription

Use the `aws_rds_event_subscription` InSpec audit resource to test properties of the singular resource of AWS RDS event subscription.

## Syntax

Ensure that the event subscription exists.

    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      it { should exist }
    end

## Parameters

`subscription_name` _(required)_

The identifier for the event subscription.

For additional information, see the [AWS documentation on AWS RDS Event Subscription](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-eventsubscription.html).

## Properties

| Property | Description |
| --- | --- |
| customer_aws_id | The Amazon Web Services customer account associated with the RDS event notification subscription. |
| cust_subscription_id | The RDS event notification subscription Id. |
| sns_topic_arn | The topic ARN of the RDS event notification subscription.|
| status |The status of the RDS event notification subscription. |
| subscription_creation_time | The time the RDS event notification subscription was created. |
| source_type | The source type for the RDS event notification subscription.|
| source_ids_list | A list of source IDs for the RDS event notification subscription.|
| event_categories_list | A list of event categories for the RDS event notification subscription. |
| enabled | A Boolean value indicating if the subscription is enabled. True indicates the subscription is enabled. |
| event_subscription_arn | The Amazon Resource Name (ARN) for the event subscription.Exceptions |


## Examples

### Ensure a event subscription name is available.
    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      its('cust_subscription_id') { should eq 'CUST_SUBSCRIPTION_ID' }
    end

### Ensure a event subscription sns topic arn is available.
    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      its('sns_topic_arn') { should eq 'SNS_TOPIC_ARN' }
    end

### Ensure a customer AWS ID is available.
    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      its('customer_aws_id') { should eq 'CUSTOMER_AWS_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeEventSubscriptionsMessage` action with `Effect` set to `Allow`.