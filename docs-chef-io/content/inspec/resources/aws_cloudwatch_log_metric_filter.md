+++
title = "aws_cloudwatch_log_metric_filter Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatch_log_metric_filter"
identifier = "inspec/resources/aws/aws_cloudwatch_log_metric_filter Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_log_metric_filter` InSpec audit resource to search for and test properties of individual AWS Cloudwatch Log Metric Filters.

For additional information, including details on parameters and properties, see the [AWS documentation on CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

```ruby
describe aws_cloudwatch_log_metric_filter(filter_name: 'my-filter', log_group_name: 'my-log-group') do
  it { should exist }
end
```

```ruby
describe aws_cloudwatch_log_metric_filter(log_group_name:  'my-log-group', pattern: 'my-filter') do
  it { should exist }
end
```

## Parameters

**Note**: _While all parameters are optional, at least one must be provided. In practice, the more parameters you provide the narrower a result you will return._

`filter_name` _(optional)_

: The name of the Log Metric Filter. Expected in a hash as `filter_name: 'value'`.

`log_group_name` _(optional)_

: The log group of the filter. Expected in a hash as `log_group_name: 'value'`.

`pattern` _(optional)_

: A pattern by which to narrow down the result-set, if you expect multiple results. Expected in a hash as `pattern: 'value'`.

## Properties

`filter_name`
: The name of the metric filter.

`log_group_name`
: The name of the log group.

`metric_name`
: The name of the metric.

`metric_namespace`
: The namespace of the metric.

`pattern`
: A symbolic description of how CloudWatch Logs should interpret the data in each log event. For example, a log event may contain timestamps, IP addresses, strings, and so on. You use the filter pattern to specify what to look for in the log event message.

## Examples

**Ensure a Filter exists.**

```ruby
describe aws_cloudwatch_log_metric_filter(filter_name: 'my-filter', log_group_name: 'my-log-group') do
  it { should exist }
end
```

**Ensure a Filter exists for a specific pattern.**

```ruby
describe aws_cloudwatch_log_metric_filter(pattern: '"ERROR" - "Exiting"') do
  it { should exist }
end
```

**Check the name of a Filter.**

```ruby
describe aws_cloudwatch_log_metric_filter(log_group_name: 'app-log-group', pattern: 'KERBLEWIE') do
  its('filter_name') { should eq 'kaboom_lmf' }
end
```


**Check the Log Group name of a Filter.**

```ruby
describe aws_cloudwatch_log_metric_filter(filter_name: 'error-watcher') do
  its('log_group_name') { should eq 'app-log-group' }
end
```

**Check a filter has the correct pattern.**

```ruby
describe aws_cloudwatch_log_metric_filter(filter_name: 'error-watcher', log_group_name: 'app-log-group') do
  its('pattern') { should cmp 'ERROR' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_cloudwatch_log_metric_filter(log_group_name: 'my-log-group') do
  it { should exist }
end
```

```ruby
describe aws_cloudwatch_log_metric_filter(log_group_name: 'i-dont-exist') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeMetricFiltersResponse" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon CloudWatch](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatch.html).
