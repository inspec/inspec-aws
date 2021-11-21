---
title: About the aws_cloudwatchlogs_subscription_filters Resource
platform: aws
---

# aws_cloudwatchlogs_subscription_filters

Use the `aws_cloudwatchlogs_subscription_filters` InSpec audit resource to test properties of the plural resource of AWS Logs Subscription Filters.

The AWS::Logs::SubscriptionFilter specifies a subscription filter and associates it with the specified log group.

## Syntax

Ensure that the subscription filter exists.

    describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
      it { should exist }
    end

## Parameters

`log_group_name` _(required)_

The name of the log group.

For additional information, see the [AWS documentation on AWS Logs SubscriptionFilter.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-subscriptionfilter.html).

## Properties

| Property         | Description                           | Field           |
| :--------------: | :-----------------------------------: | :-------------: |
| filter_names     | The name of the subscription filters. | filter_name     |
| log_group_names  | The name of the log group.            | log_group_name  |
| filter_patterns  | A symbolic description of how CloudWatch Logs should interpret the data in each log event. | filter_pattern |
| destination_arns | The Amazon Resource Name (ARN) of the destination.     | destination_arn |
| role_arns        | The ARN of the IAM role.              | role_arn        |
| distributions    | The method used to distribute log data to the destination, which can be either random or grouped by log stream. | distribution |
| creation_times   | The creation time of the subscription filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. | creation_time |

## Examples

### Ensure a filter name is available

    describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
      its('filter_names') { should include 'FilterName' }
    end

### Ensure a filter log group name is available

    describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
        its('log_group_names') { should include 'LOG_GROUP_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudwatchlogs_subscription_filters(log_group_name: "LOG_GROUP_NAME") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeSubscriptionFiltersResponse` action with `Effect` set to `Allow`.
