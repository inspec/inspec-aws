---
title: About the aws_stepfunctions_activity Resource
platform: aws
---

# aws_stepfunctions_activity

Use the `aws_stepfunctions_activity` InSpec audit resource to test properties of the singular resource of AWS StepFunctions Activity.

## Syntax

Ensure that the activity exists.

    describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
      it { should exist }
    end

## Parameters

`activity_arn` _(required)_

The Amazon Resource Name (ARN) that identifies the activity.

For additional information, see the [AWS documentation on AWS StepFunctions Activity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html).

## Properties

| Property | Description | 
| :---: | :--- |
| activity_arn | The Amazon Resource Name (ARN) that identifies the activity. | 
| name | The name of the activity. | 
| creation_date | The date the activity is created. | 

## Examples

### Ensure a activity arn is available.

    describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
      its('activity_arn') { should eq 'ACTIVITY_ARN' }
    end

### Ensure a activity name is available.

    describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
      its('name') { should eq 'ACTIVITY_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `States:Client:DescribeActivityOutput` action with `Effect` set to `Allow`.