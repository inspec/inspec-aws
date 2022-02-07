---
title: About the aws_cloudwatch_dashboards Resource
platform: aws
---

# aws_cloudwatch_dashboards

Use the `aws_cloudwatch_dashboards` InSpec audit resource to test properties of the plural AWS CloudWatch dashboard.

## Syntax

Ensure that the dashboard exists.

    describe aws_cloudwatch_dashboards do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS CloudWatch dashboard.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-dashboard.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| dashboard_names | The name of the dashboard. | dashboard_name |
| dashboard_arns | The Amazon Resource Name (ARN) of the dashboard. | dashboard_arn |
| last_modified | The time stamp of when the dashboard was last modified, either by an API call or through the console. | last_modified |
| sizes | The size of the dashboard, in bytes. | size |

## Examples

### Ensure a dashboard ARN is available.

    describe aws_cloudwatch_dashboards do
      its('dashboard_arns') { should include 'ARN' }
    end

### Ensure a dashboard name is available.

    describe aws_cloudwatch_dashboards do
        its('dashboard_names') { should include 'DASHBOARD_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_dashboards do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_dashboards do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:ListDashboardsOutput` action with `Effect` set to `Allow`.