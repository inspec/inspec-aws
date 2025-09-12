+++
title = "aws_cloudwatch_log_group resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloudwatch_log_group"
identifier = "inspec/resources/aws/aws_cloudwatch_log_group resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatch_log_group` InSpec audit resource to test properties of a single AWS CloudWatch Log Group.

For additional information, including details on parameters and properties, see the [AWS documentation on CloudWatch Logs](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeLogGroups.html).

## Syntax

Ensure that an `aws_cloudwatch_log_group` exists

```ruby
describe aws_cloudwatch_log_group('my_log_group') do
  it { should exist }
end
```

```ruby
describe aws_cloudwatch_log_group(log_group_name: 'my_log_group') do
  it { should exist }
end
```

## Parameters

`log_group_name` _(required)_

: This resource accepts a single parameter, the log group name which uniquely identifies the CloudWatch Log Group.
  This can be passed either as a string or as a `log_group_name: 'value'` key-value entry in a hash.

`limit` _(optional)_

: This resource accepts a single parameter, an integer representing the number of results allowed to return. If not passed, in, this defaults to `1`, which will only return the first match to the `log_group_name`.
  This can be passed as a `limit: 'value'` key-value entry in a hash.

## Properties

`retention_in_days`
: The number of days to retain the log events in the specified log group.

`kms_key_id`
: The Amazon Resource Name (ARN) of the CMK to use when encrypting log data.

`tags`
: The tags for the log group.

## Examples

**Test tags on the CloudWatch Log Group.**

```ruby
describe aws_cloudwatch_log_group('my_log_group') do
  its('tags') { should include(:Environment => 'env-name',
                               :Name => 'my_log_group')}
end
```

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudWatchLogs:Client:DescribeLogGroupsResponse` and `CloudWatchLogs:Client:ListTagsLogGroupResponse` actions with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon CloudWatch Logs](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatchlogs.html).
