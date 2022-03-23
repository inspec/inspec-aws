+++
title = "aws_cloudwatch_dashboard Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatch_dashboard"
identifier = "inspec/resources/aws/aws_cloudwatch_dashboard Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_dashboard` InSpec audit resource to test properties of the plural AWS CloudWatch dashboard.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudWatch Dashboard.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-dashboard.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the dashboard exists.

```ruby
describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
  it { should exist }
end
```

## Parameters

`dashboard_name` _(required)_

: The name of a dashboard.

## Properties

`dashboard_arn`
: The Amazon Resource Name (ARN) of the dashboard.

`dashboard_body`
: The detailed information about the dashboard, including what widgets are included and their location on the dashboard.

`dashboard_name`
: The name of the dashboard.

## Examples

**Ensure a dashboard ARN is available.**

```ruby
describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
  its('dashboard_arn') { should eq 'ARN' }
end
```

**Ensure a dashboard body is available.**

```ruby
describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
    its('dashboard_body') { should eq 'BODY' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="CloudWatch:Client:GetDashboardOutput" %}}
