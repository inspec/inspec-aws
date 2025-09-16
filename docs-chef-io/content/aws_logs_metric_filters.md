+++
title = "aws_logs_metric_filters resource"

draft = false


[menu.aws]
title = "aws_logs_metric_filters"
identifier = "inspec/resources/aws/aws_logs_metric_filters resource"
parent = "inspec/resources/aws"
+++

Use the `aws_logs_metric_filters` InSpec audit resource to test properties of multiple AWS CloudWatch logs metric filters.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Logs MetricFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-metricfilter.html).

## Syntax

Ensure that a filter name exists.

```ruby
describe aws_logs_metric_filters do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`filter_names`
: The name of the metric filter.

`filter_patterns`
: A symbolic description of how CloudWatch Logs should interpret the data in each log event. For example, a log event can contain timestamps, IP addresses, strings, and so on. You use the filter pattern to specify what to look for in the log event message.

`metric_transformations`
: The metric transformations.

`creation_times`
: The creation time of the metric filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

`log_group_names`
: The name of the log group.

## Examples

Ensure a filter name is available:

```ruby
describe aws_logs_metric_filters do
  its('filter_names') { should include 'FILTER_NAME' }
end
```

Ensure a log group name is available:

```ruby
describe aws_logs_metric_filters do
    its('log_group_names') { should include 'LOG_GROUP_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_logs_metric_filters do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_logs_metric_filters do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the filter name is available.

```ruby
describe aws_logs_metric_filters do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeMetricFiltersResponse" %}}
