---
title: About the aws_stepfunctions_activity Resource
platform: aws
---

# aws_stepfunctions_activity

Use the `aws_stepfunctions_activity` InSpec audit resource to test properties of the singular resource of AWS StepFunctions Activity.

## Syntax

Ensure that the activity exists.

    describe aws_stepfunctions_activities do
      it { should exist }
    end

## Parameters

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on AWS StepFunctions Activity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| activity_arns | The Amazon Resource Name (ARN) that identifies the activity. | activity_arn |
| names | The name of the activity. | name |
| creation_dates | The date the activity is created. | creation_date |

## Examples

### Ensure a activity arn is available.
    describe aws_stepfunctions_activities do
      its('activity_arns') { should include 'ACTIVITY_ARN' }
    end

### Ensure a activity name is available.
    describe aws_stepfunctions_activities do
      its('names') { should include 'ACTIVITY_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_stepfunctions_activities do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_stepfunctions_activities do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `States:Client:ListActivitiesOutput` action with `Effect` set to `Allow`.