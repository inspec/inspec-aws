---
title: About the aws_cloudtrail_trails Resource
platform: aws
---

# aws\_cloudtrail\_trails

Use the `aws_cloudtrail_trails` InSpec audit resource to test properties of some or all AWS CloudTrail Trails.

AWS CloudTrail is a service that enables governance, compliance, operational auditing, and risk auditing of your AWS account. With CloudTrail, you can log, continuously monitor, and retain account activity related to actions across your AWS infrastructure. CloudTrail provides event history of your AWS account activity, including actions taken through the AWS Management Console, AWS SDKs, command line tools, and other AWS services. This event history simplifies security analysis, resource change tracking, and troubleshooting.

Each AWS CloudTrail Trails is uniquely identified by its trail name or trail arn.

<br>

## Syntax

An `aws_cloudtrail_trails` resource block collects a group of CloudTrail Trails and then tests that group.

    # Verify the number of CloudTrail Trails in the AWS account
    describe aws_cloudtrail_trails do
      its('entries.count') { should cmp 10 }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_cloudtrail_trails`, its limited functionality precludes examples.

<br>

## Properties
* `entries`, `names`, `trail_arns`

<br>

## Property Examples

### entries

Provides access to the raw results of the query. This can be useful for checking counts and other advanced operations.

    # Allow at most 100 CloudTrail Trails on the account
    describe aws_cloudtrail_trails do
      its('entries.count') { should be <= 100}
    end

### names

Provides a list of trail names for all CloudTrail Trails in the AWS account.

    describe aws_cloudtrail_trails do
      its('names') { should include('trail-1') }
    end

### trail\_arns

Provides a list of trail arns for all CloudTrail Trails in the AWS account.

    describe aws_cloudtrail_trails do
      its('trail_arns') { should include('arn:aws:cloudtrail:us-east-1::trail/trail-1') }
    end

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # Verify that at least one CloudTrail Trail exists.
    describe aws_cloudtrail_trails
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudtrail:DescribeTrails` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for AWS CloudTrail](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_awscloudtrail.html).
