+++
title = "aws_cloudwatch_dashboards Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatch_dashboards"
identifier = "inspec/resources/aws/aws_cloudwatch_dashboards Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_dashboards` InSpec audit resource to test properties of the plural AWS CloudWatch dashboard.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudWatch dashboard.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-dashboard.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the dashboard exists.

```ruby
describe aws_cloudwatch_dashboards do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`dashboard_names`
: The name of the dashboard.

: **Field**: `dashboard_name`

`dashboard_arns`
: The Amazon Resource Name (ARN) of the dashboard.

: **Field**: `dashboard_arn`

`last_modified`
: The time stamp of when the dashboard was last modified, either by an API call or through the console.

: **Field**: `last_modified`

`sizes`
: The size of the dashboard, in bytes.

: **Field**: `size`

## Examples

**Ensure a dashboard ARN is available.**

```ruby
describe aws_cloudwatch_dashboards do
  its('dashboard_arns') { should include 'ARN' }
end
```

**Ensure a dashboard name is available.**

```ruby
describe aws_cloudwatch_dashboards do
    its('dashboard_names') { should include 'DASHBOARD_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatch_dashboards do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudwatch_dashboards do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatch:Client:ListDashboardsOutput" %}}
