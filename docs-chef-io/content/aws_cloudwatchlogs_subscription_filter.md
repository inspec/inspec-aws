+++
title = "aws_cloudwatchlogs_subscription_filter resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudwatchlogs_subscription_filter"
identifier = "inspec/resources/aws/aws_cloudwatchlogs_subscription_filter resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatchlogs_subscription_filter` InSpec audit resource to test properties of a single specific AWS Logs Subscription Filter.

The AWS::Logs::SubscriptionFilter specifies a subscription filter and associates it with the specified log group.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Logs SubscriptionFilter.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-subscriptionfilter.html).

## Syntax

Ensure that the subscription filter exists.

```ruby
describe aws_cloudwatchlogs_subscription_filter(log_group_name: "LOG_GROUP_NAME", filter_name_prefix: "FILTER_NAME") do
  it { should exist }
end
```

## Parameters

`log_group_name` and `filter_name_prefix` _(required)_

`log_group_name`
: The name of the log group to associate with the subscription filter. All log events that are uploaded to this log group are filtered and delivered to the specified AWS resource if the filter pattern matches the log events.

`filter_name_prefix`
: The name of the subscription filter.

## Properties

`filter_name`
: The name of the subscription filter.

`log_group_name`
: The name of the log group.

`filter_pattern`
: A symbolic description of how CloudWatch Logs should interpret the data in each log event.

`destination_arn`
: The Amazon Resource Name (ARN) of the destination.

`role_arn`
: The ARN of the IAM role.

`distribution`
: The method used to distribute log data to the destination, which can be either random or grouped by log stream.

`creation_time`
: The creation time of the subscription filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

## Examples

Ensure a filter name is available:

```ruby
describe aws_cloudwatchlogs_subscription_filter(log_group_name: "LOG_GROUP_NAME", filter_name_prefix: "FILTER_NAME") do
  its('filter_name') { should eq 'FILTER_NAME' }
end
```

Ensure a filter log group name is available:

```ruby
describe aws_cloudwatchlogs_subscription_filter(log_group_name: "LOG_GROUP_NAME", filter_name_prefix: "FILTER_NAME") do
    its('log_group_name') { should eq 'LOG_GROUP_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatchlogs_subscription_filter(log_group_name: "LOG_GROUP_NAME", filter_name_prefix: "FILTER_NAME") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudwatchlogs_subscription_filter(log_group_name: "LOG_GROUP_NAME", filter_name_prefix: "FILTER_NAME") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudwatchlogs_subscription_filter(log_group_name: "LOG_GROUP_NAME", filter_name_prefix: "FILTER_NAME") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeSubscriptionFiltersResponse" %}}
