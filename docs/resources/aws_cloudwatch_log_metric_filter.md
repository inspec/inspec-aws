---
title: About the aws_cloudwatch_log_metric_filter Resource
platform: aws
---

# aws_cloudwatch_log_metric_filter

Use the `aws_cloudwatch_log_metric_filter` InSpec audit resource to search for and test properties of individual AWS Cloudwatch Log Metric Filters.

## Syntax

    describe aws_cloudwatch_log_metric_filter(filter_name: 'my-filter', log_group_name: 'my-log-group') do
      it { should exist }
    end

    describe aws_cloudwatch_log_metric_filter(log_group_name:  'my-log-group', pattern: 'my-filter') do
      it { should exist }
    end

## Parameters

**Note**: _While all parameters are optional, at least one must be provided. In practice, the more parameters you provide the narrower a result you will return._

`filter_name` _(optional)_
The name of the Log Metric Filter. Expected in a hash as `filter_name: 'value'`.

`log_group_name` _(optional)_
The log group of the filter. Expected in a hash as `log_group_name: 'value'`.

`pattern` _(optional)_
A pattern by which to narrow down the result-set, if you expect multiple results. Expected in a hash as `pattern: 'value'`.

See also the [AWS documentation on CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html).

## Properties

| Property | Description |
| :---: | :--- |
| filter_name      | The name of the metric filter. |
| log_group_name   | The name of the log group. |
| metric_name      | The name of the metric. |
| metric_namespace | The namespace of the metric. |
| pattern          | A symbolic description of how CloudWatch Logs should interpret the data in each log event. For example, a log event may contain timestamps, IP addresses, strings, and so on. You use the filter pattern to specify what to look for in the log event message.  |

## Examples

##### Ensure a Filter exists

    describe aws_cloudwatch_log_metric_filter(filter_name: 'FILTER_NAME', log_group_name: 'LOG_GROUP_NAME') do
      it { should exist }
    end

##### Ensure a Filter exists for a specific pattern

    describe aws_cloudwatch_log_metric_filter(pattern: '"ERROR" - "Exiting"') do
      it { should exist }
    end

##### Check the name of a Filter

    describe aws_cloudwatch_log_metric_filter(log_group_name: 'LOG_GROUP_NAME', pattern: 'KERBLEWIE') do
      its('filter_name') { should eq 'kaboom_lmf' }
    end


##### Check the Log Group name of a Filter

    describe aws_cloudwatch_log_metric_filter(filter_name: 'FILTER_NAME') do
      its('log_group_name') { should eq 'app-log-group' }
    end

##### Check a filter has the correct pattern

    describe aws_cloudwatch_log_metric_filter(filter_name: 'FILTER_NAME', log_group_name: 'LOG_GROUP_NAME') do
      its('pattern') { should cmp 'ERROR' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should` to test that the entity exists.

    describe aws_cloudwatch_log_metric_filter(log_group_name: 'LOG_GROUP_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_log_metric_filter(log_group_name: 'LOG_GROUP_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeMetricFiltersResponse` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html).
