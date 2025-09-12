+++
title = "aws_sns_topic resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_sns_topic"
identifier = "inspec/resources/aws/aws_sns_topic resource"
parent = "inspec/resources/aws"
+++

Use the `aws_sns_topic` InSpec audit resource to test properties of a single AWS Simple Notification Service Topic. SNS topics are channels for related events. AWS resources place events in the Simple Notification Service (SNS) topic, while other AWS resources subscribe to receive notifications when new events occur.

For additional information, including details on parameters and properties, see the [AWS documentation on SNS](https://docs.aws.amazon.com/sns/latest/dg/sns-getting-started.html).

## Syntax

```ruby
describe aws_sns_topic('arn:aws:sns:*::my-topic-name') do
  it { should exist }
end
```

    # You may also use has syntax to pass the ARN

```ruby
describe aws_sns_topic(arn: 'arn:aws:sns:*::my-topic-name') do
  it { should exist }
end
```

## Parameters

`arn` _(required)_

: This resource accepts a single parameter, the ARN of the SNS Topic.
  This can be passed either as a string or as a `arn: 'value'` key-value entry in a hash.

## Properties

`kms_master_key_id`
: Provides the ID of an AWS-managed customer master key (CMK) for Amazon SNS topic or a custom CMK.

`confirmed_subscription_count`
: An integer indicating the number of currently active subscriptions.

## Examples

Make sure something is subscribed to the topic:

```ruby
describe aws_sns_topic('arn:aws:sns:*::my-topic-name') do
  its('confirmed_subscription_count') { should_not be_zero}
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_sns_topic('arn:aws:sns:*::good-news') do
  it { should exist }
end
```

```ruby
describe aws_sns_topic('arn:aws:sns:*::bad-news') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SNS:Client:GetTopicAttributesResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon SNS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonsns.html).
