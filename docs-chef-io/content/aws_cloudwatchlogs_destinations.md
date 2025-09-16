+++
title = "aws_cloudwatchlogs_destinations resource"

draft = false


[menu.aws]
title = "aws_cloudwatchlogs_destinations"
identifier = "inspec/resources/aws/aws_cloudwatchlogs_destinations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudwatchlogs_destinations` InSpec audit resource to test properties of multiple AWS Logs destinations.

The `AWS::Logs::Destination` resource type specifies a CloudWatch Logs destination. A destination encapsulates a physical resource (such as an Amazon Kinesis data stream) and enables you to subscribe that resource to a stream of log events.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS::Logs::Destination.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-destination.html).

## Syntax

Ensure that the destination name exists.

```ruby
describe aws_cloudwatchlogs_destinations do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`destination_names`
: The name of the destination.

: **Field**: `destination_name`

`target_arns`
: The Amazon Resource Name (ARN) of the physical target where the log events are delivered (for example, a Kinesis stream).

: **Field**: `target_arn`

`role_arns`
: The ARN of an IAM role that permits CloudWatch Logs to send data to the specified AWS resource.

: **Field**: `role_arn`

`access_policies`
: An IAM policy document governing the Amazon Web Services accounts, which can create subscription filters against this destination.

: **Field**: `access_policy`

`arns`
: The ARN of this destination.

: **Field**: `arn`

`creation_time`
: The creation time of the destination, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC.

: **Field**: `creation_time`

## Examples

Ensure a destination name is available:

```ruby
describe aws_cloudwatchlogs_destinations do
  its('destination_names') { should include 'DESTINATION_NAME' }
end
```

Ensure a destination role ARN is available:

```ruby
describe aws_cloudwatchlogs_destinations do
    its('role_arns') { should include 'ROLE_ARN' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that an entity exists.

```ruby
describe aws_cloudwatchlogs_destinations do
  it { should exist }
end
```

Use `should_not` to test that an entity does not exist.

```ruby
describe aws_cloudwatchlogs_destinations do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudWatchLogs:Client:DescribeDestinationsResponse" %}}
