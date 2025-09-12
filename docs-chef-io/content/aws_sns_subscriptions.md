+++
title = "aws_sns_subscriptions resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_sns_subscriptions"
identifier = "inspec/resources/aws/aws_sns_subscriptions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sns_subscriptions` InSpec audit resource to test properties of an AWS Simple Notification Service (SNS) subscription VPN route.

The `AWS::SNS::Subscription` resource subscribes an endpoint to an Amazon SNS topic. For a subscription to be created, the owner of the endpoint must confirm the subscription.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SNS subscriptions.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sns-subscription.html).

## Syntax

Ensure that the subscription exists.

```ruby
describe aws_sns_subscriptions do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`subscription_arns`
: The subscription's ARN.

: **Field**: `subscription_arn`

`owners`
: The subscription's owner.

: **Field**: `owner`

`protocols`
: The subscription's protocol.

: **Field**: `protocol`

`endpoints`
: The subscription's endpoint (format depends on the protocol).

: **Field**: `endpoint`

`topic_arns`
: The ARN of the subscription's topic.

: **Field**: `topic_arn`

## Examples

**Ensure a subscription ARN is available.**

```ruby
describe aws_sns_subscriptions do
  its('subscription_arns') { should include 'SUBSCRIPTION_ARN' }
end
```

**Ensure a topic ARN is available.**

```ruby
describe aws_sns_subscriptions do
    its('topic_arns') { should include 'TOPIC_ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_sns_subscriptions do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_sns_subscriptions do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_sns_subscriptions do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SNS:Client:ListSubscriptionsResponse" %}}
