+++
title = "aws_synthetics_canaries resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_synthetics_canaries"
identifier = "inspec/resources/aws/aws_synthetics_canaries resource"
parent = "inspec/resources/aws"
+++

Use the `aws_synthetics_canaries` Chef InSpec audit resource to test properties of multiple AWS Synthetics canaries.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::Synthetics::Canary` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html).

## Syntax

Ensure that the canary exists.

```ruby
describe aws_synthetics_canaries do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The unique ID of this canary.

: **Field**: `id`

`names`
: The name of the canary.

: **Field**: `name`

`codes`
: This structure contains information about the canary's Lambda handler and where its code is stored by CloudWatch Synthetics.

: **Field**: `code`

`execution_role_arns`
: The ARN of the IAM role used to run the canary. This role must include lambda.amazonaws.com as a principal in the trust policy.

: **Field**: `execution_role_arn`

`schedules`
: A structure that contains information about how often the canary is to run, and when these runs are to stop.

: **Field**: `schedule`

`run_configs`
: A structure that contains information about a canary run.

: **Field**: `run_config`

`success_retention_period_in_days`
: The number of days to retain data about successful runs of this canary.

: **Field**: `success_retention_period_in_days`

`failure_retention_period_in_days`
: The number of days to retain data about failed runs of this canary.

: **Field**: `failure_retention_period_in_days`

`statuses`
: A structure that contains information about the canary's status.

: **Field**: `status`

`timelines`
: A structure that contains information about when the canary was created, modified, and most recently run.

: **Field**: `timeline`

`artifact_s3_locations`
: The location in Amazon S3 where Synthetics stores artifacts from the runs of this canary. Artifacts include the log file, screenshots, and HAR files.

: **Field**: `artifact_s3_location`

`engine_arns`
: The ARN of the Lambda function that is used as your canary's engine.

: **Field**: `engine_arn`

`runtime_versions`
: Specifies the runtime version to use for the canary.

: **Field**: `runtime_version`

`vpc_configs`
: If this canary is to test an endpoint in a VPC, this structure contains information about the subnets and security groups of the VPC endpoint.

: **Field**: `vpc_config`

`visual_references`
: If this canary performs visual monitoring by comparing screenshots, this structure contains the ID of the canary run to use as the baseline for screenshots, and the coordinates of any parts of the screen to ignore during the visual monitoring comparison.

: **Field**: `visual_reference`

`tags`
: The list of key-value pairs that are associated with the canary.

: **Field**: `tags`

`artifact_configs`
: A structure that contains the configuration for canary artifacts, including the encryption-at-rest settings for artifacts that the canary uploads to Amazon S3.

: **Field**: `artifact_config`

## Examples

Ensure a canary ID is available:

```ruby
describe aws_synthetics_canaries do
  its('ids') { should include 'CANARY_ID' }
end
```

Ensure a canary name is available:

```ruby
describe aws_synthetics_canaries do
  its('names') { should include 'CANARY_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_synthetics_canaries do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_synthetics_canaries do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Synthetics:Client:DescribeCanariesResponse" %}}
