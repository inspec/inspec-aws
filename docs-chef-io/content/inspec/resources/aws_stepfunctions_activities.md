+++
title = "aws_stepfunctions_activities Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_stepfunctions_activities"
identifier = "inspec/resources/aws/aws_stepfunctions_activities Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_stepfunctions_activity` Chef InSpec audit resource to test properties of multiple AWS Step Functions activities.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::StepFunctions::Activity` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that an activity exists.

```ruby
describe aws_stepfunctions_activities do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`activity_arns`
: The Amazon Resource Name (ARN) that identifies the activity.

: **Field**: `activity_arn`

`names`
: The name of the activity.

: **Field**: `name`

`creation_dates`
: The date the activity is created.

: **Field**: `creation_date`

## Examples

**Ensure an activity ARN is available.**

```ruby
describe aws_stepfunctions_activities do
  its('activity_arns') { should include 'ACTIVITY_ARN' }
end
```

**Ensure an activity name is available.**

```ruby
describe aws_stepfunctions_activities do
  its('names') { should include 'ACTIVITY_NAME' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_stepfunctions_activities do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_stepfunctions_activities do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="States:Client:ListActivitiesOutput" %}}
