+++
title = "aws_cloudwatchlogs_destination Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_cloudwatchlogs_destination"
identifier = "inspec/resources/aws/aws_cloudwatchlogs_destination Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatchlogs_destination` InSpec audit resource to test properties of a single specific AWS Logs destination.

The `AWS::Logs::Destination` resource type specifies a CloudWatch Logs destination. A destination encapsulates a physical resource (such as an Amazon Kinesis data stream) and enables you to subscribe that resource to a stream of log events.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS::Logs::Destination.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the destination name exists.

```ruby
describe aws_cloudwatchlogs_destination(destination_name_prefix: "DESTINATION_NAME") do
  it { should exist }
end
```

## Parameters

`destination_name_prefix` _(required)_

: The name of the destination.

## Properties

`destination_name`
: The name of the destination.

`target_arn`
: The Amazon Resource Name (ARN) of the physical target where the log events are delivered (for example, a Kinesis stream).

`role_arn`
: The ARN of an IAM role that permits CloudWatch Logs to send data to the specified AWS resource.

`access_policy`
: An IAM policy document governing the Amazon Web Services accounts, which can create subscription filters against this destination.

`arn`
: The ARN of this destination.

`creation_time`
: The creation time of the destination, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

## Examples

**Ensure destination name is available.**

```ruby
describe aws_cloudwatchlogs_destination(destination_name_prefix: "DESTINATION_NAME") do
  its('destination_name') { should eq 'DESTINATION_NAME' }
end
```

**Ensure that the IAM role ARN is available.**

```ruby
describe aws_cloudwatchlogs_destination(destination_name_prefix: "DESTINATION_NAME") do
    its('role_arn') { should eq 'ROLE_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloudwatchlogs_destination(destination_name_prefix: "DESTINATION_NAME") do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_cloudwatchlogs_destination(destination_name_prefix: "DESTINATION_NAME") do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_cloudwatchlogs_destination(destination_name_prefix: "DESTINATION_NAME") do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeDestinationsResponse" %}}
