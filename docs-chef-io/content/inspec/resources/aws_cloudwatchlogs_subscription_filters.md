+++
title = "aws_cloudwatchlogs_subscription_filters Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatchlogs_subscription_filters"
identifier = "inspec/resources/aws/aws_cloudwatchlogs_subscription_filters Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatchlogs_subscription_filters` InSpec audit resource to test properties of the plural resource of AWS Logs Subscription Filters.

The AWS::Logs::SubscriptionFilter specifies a subscription filter and associates it with the specified log group.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Logs SubscriptionFilter.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-subscriptionfilter.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the subscription filter exists.

```ruby
describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
  it { should exist }
end
```

## Parameters

`log_group_name` _(required)_

: The name of the log group.

## Properties

`filter_names`
: The name of the subscription filters.

: **Field**: `filter_name`

`log_group_names`
: The name of the log group.

: **Field**: `log_group_name`

`filter_patterns`
: A symbolic description of how CloudWatch Logs should interpret the data in each log event.

: **Field**: `filter_pattern`

`destination_arns`
: The Amazon Resource Name (ARN) of the destination.

: **Field**: `destination_arn`

`role_arns`
: The ARN of the IAM role.

: **Field**: `role_arn`

`distributions`
: The method used to distribute log data to the destination, which can be either random or grouped by log stream.

: **Field**: `distribution`

`creation_times`
: The creation time of the subscription filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

: **Field**: `creation_time`

## Examples

**Ensure a filter name is available.**

```ruby
describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
  its('filter_names') { should include 'FilterName' }
end
```

**Ensure a filter log group name is available.**

```ruby
describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
    its('log_group_names') { should include 'LOG_GROUP_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeSubscriptionFiltersResponse" %}}
