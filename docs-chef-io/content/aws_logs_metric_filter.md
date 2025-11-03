+++
title = "aws_logs_metric_filter resource"

draft = false


[menu.aws]
title = "aws_logs_metric_filter"
identifier = "inspec/resources/aws/aws_logs_metric_filter resource"
parent = "inspec/resources/aws"
+++

Use the `aws_logs_metric_filter` InSpec audit resource to test properties of a single specific AWS CloudWatch logs metric filter.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Logs MetricFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-metricfilter.html).

## Syntax

Ensure that a work_group name exists.

```ruby
describe aws_logs_metric_filter(filter_name: 'FILTER_NAME') do
  it { should exist }
end
```

## Parameters

`filter_name` _(required)_

: The name of the metric filter.

## Properties

`filter_name`
: The name of the metric filter.

`filter_pattern`
: A symbolic description of how CloudWatch Logs should interpret the data in each log event. For example, a log event can contain timestamps, IP addresses, strings, and so on. You use the filter pattern to specify what to look for in the log event message.

`metric_transformations (metric_name)`
: The metric transformations. The name of the CloudWatch metric.

`metric_transformations (metric_namespace)`
: The metric transformations. A custom namespace to contain your metric in CloudWatch. Use namespaces to group together metrics that are similar.

`metric_transformations (metric_value)`
: The metric transformations. The value to publish to the CloudWatch metric when a filter pattern matches a log event.

`metric_transformations (default_value)`
: The metric transformations. The value to emit when a filter pattern does not match a log event. This value can be null.

`creation_time`
: The creation time of the metric filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

`log_group_name`
: The name of the log group.

## Examples

Ensure a filter name is available:

```ruby
describe aws_logs_metric_filter(filter_name: 'FILTER_NAME') do
  its('filter_name') { should eq 'FilterName' }
end
```

Ensure a log group name is available:

```ruby
describe aws_logs_metric_filter(filter_name: 'FILTER_NAME') do
    its('log_group_name') { should eq 'LogGroupName' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_logs_metric_filter(filter_name: 'FILTER_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_logs_metric_filter(filter_name: 'dummy') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the filter name is available.

```ruby
describe aws_logs_metric_filter(filter_name: 'FILTER_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeMetricFiltersResponse" %}}
