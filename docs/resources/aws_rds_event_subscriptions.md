---
title: About the aws_rds_event_subscriptions Resource
platform: aws
---

# aws_rds_event_subscriptions

Use the `aws_rds_event_subscriptions` InSpec audit resource to test properties of the singular resource of AWS RDS event subscription .

## Syntax

Ensure that the event subscription exists.

    describe aws_rds_event_subscriptions do
      it { should exist }
    end

## Parameters

`subscription_name` _(required)_

The identifier for the event subscription.

For additional information, see the [AWS documentation on AWS RDS Event Subscription](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-eventsubscription.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| customer_aws_ids | The Amazon Web Services customer account associated with the RDS event notification subscription. | customer_aws_id |
| cust_subscription_ids | The RDS event notification subscription Id. | cust_subscription_id |
| sns_topic_arns | The topic ARN of the RDS event notification subscription.| sns_topic_arn |    
| statuses |The status of the RDS event notification subscription. | status |
| subscription_creation_times | The time the RDS event notification subscription was created. | subscription_creation_time |
| source_types | The source type for the RDS event notification subscription.| source_type |
| source_ids_lists | A list of source IDs for the RDS event notification subscription.| source_ids_list |
| event_categories_lists | A list of event categories for the RDS event notification subscription. | event_categories_list |
| enabled | A Boolean value indicating if the subscription is enabled. True indicates the subscription is enabled. | enabled |
| event_subscription_arns | The Amazon Resource Name (ARN) for the event subscription.Exceptions | event_subscription_arn |

## Examples

### Ensure a event subscription name is available.
    describe aws_rds_event_subscriptions do
      its('cust_subscription_ids') { should eq 'SUBSCRIPTION_ID' }
    end

### Ensure a event subscription sns topic arn is available.
    describe aws_rds_event_subscriptions do
      its('sns_topic_arns') { should eq 'SECURITY_GROUP_DESC' }
    end

### Ensure a customer AWD ID is `available`.
    describe aws_rds_event_subscriptions do
      its('customer_aws_ids') { should eq 'available' }
    end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_rds_event_subscriptions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_rds_event_subscriptions do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_rds_event_subscriptions do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `RDS:Client:DescribeDBSecurityGroup` action with `Effect` set to `Allow`.