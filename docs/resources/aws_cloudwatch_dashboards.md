---
title: About the aws_cloudwatch_dashboards Resource
platform: aws
---

# aws_cloudwatch_dashboards

Use the `aws_cloudwatch_dashboards` InSpec audit resource to test properties of the plural AWS CloudWatch Dashboard.

## Syntax

Ensure that the identity exists.

    describe aws_cloudwatch_dashboards do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFront CloudFrontOriginAccessIdentity.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-monitoring.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| dashboard_arn | The Amazon Resource Name (ARN) of the dashboard. | dashboard_arn |
| dashboard_body | The detailed information about the dashboard, including what widgets are included and their location on the dashboard.| dashboard_body |
| dashboard_name | The name of the dashboard. | dashboard_name |
| size | The size of the dashboard, in bytes. | size |



## Examples

### Ensure an dashboard_arn is available.
    describe aws_cloudwatch_dashboards do
      its('dashboard_arns') { should eq 'ARN' }
    end

### Ensure a dashboard_body is available.
    describe aws_cloudwatch_dashboards do
        its('dashboard_body') { should eq 'BODY' }
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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:ListMetricStreamsOutput action with `Effect` set to `Allow`.