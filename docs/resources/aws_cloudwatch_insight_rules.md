---
title: About the aws_cloudwatch_insight_rules Resource
platform: aws
---

# aws_cloudwatch_insight_rules

Use the `aws_cloudwatch_insight_rules` InSpec audit resource to test properties of the plural AWS CloudWatch Insight Rules.

## Syntax

Ensure that the identity exists.

    describe aws_cloudwatch_insight_rules do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudWatch Insight Rules.](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights-CreateRule.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| names | The name of the rule. | name |
| states | Indicates whether the rule is enabled or disabled.| schema |
| schemas | For rules that you create, this is always {"Name": "CloudWatchLogRule", "Version": 1} . For built-in rules, this is {"Name": "ServiceLogRule", "Version": 1}. | dashboard_name |
| definitions | he definition of the rule, as a JSON object.  | definition |



## Examples

### Ensure an dashboard_arn is available.
    describe aws_cloudwatch_insight_rules do
      its('dashboard_arn') { should eq 'ARN' }
    end

### Ensure a dashboard_body is available.
    describe aws_cloudwatch_insight_rules do
        its('dashboard_body') { should eq 'BODY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudwatch_insight_rules do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloudwatch_insight_rules do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatch:Client:DescribeInsightRulesOutputaction with `Effect` set to `Allow`.