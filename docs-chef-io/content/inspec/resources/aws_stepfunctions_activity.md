+++
title = "aws_stepfunctions_activity Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_stepfunctions_activity"
identifier = "inspec/resources/aws/aws_stepfunctions_activity Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_stepfunctions_activity` Chef InSpec audit resource to test properties of a single AWS Step Functions activity.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::StepFunctions::Activity` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the activity exists.

```ruby
describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
  it { should exist }
end
```

## Parameters

`activity_arn` _(required)_

: The Amazon Resource Name (ARN) that identifies the activity.

## Properties

`activity_arn`
: The Amazon Resource Name (ARN) that identifies the activity.

`name`
: The name of the activity.

`creation_date`
: The date the activity is created.

## Examples

**Ensure a activity ARN is available.**

```ruby
describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
  its('activity_arn') { should eq 'ACTIVITY_ARN' }
end
```

**Ensure an activity name is available.**

```ruby
describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
  its('name') { should eq 'ACTIVITY_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_stepfunctions_activity(activity_arn: 'ACTIVITY_ARN') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="States:Client:DescribeActivityOutput" %}}
