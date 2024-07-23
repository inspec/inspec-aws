+++
title = "aws_rds_event_subscriptions Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_event_subscriptions"
identifier = "inspec/resources/aws/aws_rds_event_subscriptions Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_event_subscriptions` InSpec audit resource to test properties of multiple AWS RDS event subscriptions.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::RDS::EventSubscription` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-eventsubscription.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the event subscription exists.

```ruby
describe aws_rds_event_subscriptions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`customer_aws_ids`
: The Amazon Web Services customer account associated with the RDS event notification subscription.

: **Field**: `customer_aws_id`

`cust_subscription_ids`
: The RDS event notification subscription Id.

: **Field**: `cust_subscription_id`

`sns_topic_arns`
: The topic ARN of the RDS event notification subscription.

: **Field**: `sns_topic_arn`

`statuses`
: The status of the RDS event notification subscription.

: **Field**: `status`

`subscription_creation_times`
: The time the RDS event notification subscription was created.

: **Field**: `subscription_creation_time`

`source_types`
: The source type for the RDS event notification subscription.

: **Field**: `source_type`

`source_ids_lists`
: A list of source IDs for the RDS event notification subscription.

: **Field**: `source_ids_list`

`event_categories_lists`
: A list of event categories for the RDS event notification subscription.

: **Field**: `event_categories_list`

`enabled`
: A Boolean value indicating if the subscription is enabled. True indicates the subscription is enabled.

: **Field**: `enabled`

`event_subscription_arns`
: The Amazon Resource Name (ARN) for the event subscription.Exceptions.

: **Field**: `event_subscription_arn`

## Examples

**Ensure an event subscription name is available.**

```ruby
describe aws_rds_event_subscriptions do
  its('cust_subscription_ids') { should include 'CUST_SUBSCRIPTION_ID' }
end
```

**Ensure an event subscription SNS Topic ARN is available.**

```ruby
describe aws_rds_event_subscriptions do
  its('sns_topic_arns') { should include 'SNS_TOPIC_ARN' }
end
```

**Ensure a customer AWS ID is available.**

```ruby
describe aws_rds_event_subscriptions do
  its('customer_aws_ids') { should include 'CUSTOMER_AWS_ID' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_rds_event_subscriptions do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_rds_event_subscriptions do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_rds_event_subscriptions do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBSecurityGroup" %}}
