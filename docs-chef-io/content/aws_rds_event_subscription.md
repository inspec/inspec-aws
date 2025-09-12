+++
title = "aws_rds_event_subscription resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_event_subscription"
identifier = "inspec/resources/aws/aws_rds_event_subscription resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_event_subscription` InSpec audit resource to test properties of a single AWS RDS event subscription.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::RDS::EventSubscription` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-eventsubscription.html).

## Syntax

Ensure that the event subscription exists.

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  it { should exist }
end
```

## Parameters

`subscription_name` _(required)_

: The identifier for the event subscription.

## Properties

`customer_aws_id`
: The Amazon Web Services customer account associated with the RDS event notification subscription.

`cust_subscription_id`
: The RDS event notification subscription ID.

`sns_topic_arn`
: The topic ARN of the RDS event notification subscription.

`status`
: The status of the RDS event notification subscription.

`subscription_creation_time`
: The time the RDS event notification subscription was created.

`source_type`
: The source type for the RDS event notification subscription.

`source_ids_list`
: A list of source IDs for the RDS event notification subscription.

`event_categories_list`
: A list of event categories for the RDS event notification subscription.

`enabled`
: A Boolean value indicating if the subscription is enabled. True indicates the subscription is enabled.

`event_subscription_arn`
: The Amazon Resource Name (ARN) for the event subscription.

## Examples

Ensure an event subscription name is available:

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  its('cust_subscription_id') { should eq 'CUST_SUBSCRIPTION_ID' }
end
```

Ensure an event subscription SNS topic ARN is available:

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  its('sns_topic_arn') { should eq 'SNS_TOPIC_ARN' }
end
```

Ensure a customer AWS ID is available:

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  its('customer_aws_id') { should eq 'CUSTOMER_AWS_ID' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_event_subscription(subscription_name: 'EVENT_SUBSCRIPTION_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeEventSubscriptionsMessage" %}}
