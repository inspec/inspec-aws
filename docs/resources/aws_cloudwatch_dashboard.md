---
title: About the aws_cloudwatch_dashboard Resource
platform: aws
---

# aws_cloudwatch_dashboard

Use the `aws_cloudwatch_dashboard` InSpec audit resource to test properties of the plural AWS CloudWatch dashboard.

## Syntax

Ensure that the dashboard exists.

    describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
      it { should exist }
    end

## Parameters

`dashboard_name` _(required)_

The name of a dashboard.

For additional information, see the [AWS documentation on AWS CloudWatch Dashboard.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudwatch-dashboard.html).

## Properties

| Property | Description |
| --- | --- |
| dashboard_arn | The Amazon Resource Name (ARN) of the dashboard. |
| dashboard_body | The detailed information about the dashboard, including what widgets are included and their location on the dashboard.|
| dashboard_name | The name of the dashboard. |
## Examples

### Ensure a dashboard ARN is available.

    describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
      its('dashboard_arn') { should eq 'ARN' }
    end

### Ensure a dashboard body is available.

    describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
        its('dashboard_body') { should eq 'BODY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_dashboard(dashboard_name: 'DASHBOARD_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:GetDashboardOutput` action with `Effect` set to `Allow`.
