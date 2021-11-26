---
title: About the aws_synthetics_canary Resource
platform: aws
---

# aws_synthetics_canary

Use the `aws_synthetics_canary` InSpec audit resource to test properties of the singular resource of AWS Synthetics Canary.

## Syntax

Ensure that the canary exists.

    describe aws_synthetics_canary(name: 'CANARY_NAME') do
      it { should exist }
    end

## Parameters

`name` _(required)_

The name of the canary.

For additional information, see the [AWS documentation on AWS Synthetics Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html).

## Properties

| Property | Description | 
| --- | --- | 
| id | The unique ID of this canary. |
| name | The name of the canary. |
| code.source_location_arn | The ARN of the Lambda layer where Synthetics stores the canary script code. |
| code.handler | The entry point to use for the source code when running the canary. |
| execution_role_arn | The ARN of the IAM role used to run the canary. |
| schedule.expression | A rate expression or a cron expression that defines how often the canary is to run. |
| schedule.duration_in_seconds | How long, in seconds, for the canary to continue making regular runs after it was created. The runs are performed according to the schedule in the Expression value. |
| run_config.timeout_in_seconds | How long the canary is allowed to run before it must stop. |
| run_config.memory_in_mb | The maximum amount of memory available to the canary while it is running, in MB. This value must be a multiple of 64. |
| run_config.active_tracing | Displays whether this canary run used active X-Ray tracing. |
| success_retention_period_in_days | The number of days to retain data about successful runs of this canary. |
| failure_retention_period_in_days | The number of days to retain data about failed runs of this canary. |
| status.state | The current state of the canary. |
| status.state_reason | If the canary has insufficient permissions to run, this field provides more details. |
| status.state_reason_code | If the canary cannot run or has failed, this field displays the reason. |
| timeline.created | The date and time the canary was created. |
| timeline.last_modified | The date and time the canary was most recently modified. |
| timeline.last_started | The date and time that the canary's most recent run started. |
| timeline.last_stopped | The date and time that the canary's most recent run ended. |
| artifact_s3_location | The location in Amazon S3 where Synthetics stores artifacts from the runs of this canary. |
| engine_arn | The ARN of the Lambda function that is used as your canary's engine. |
| runtime_version | Specifies the runtime version to use for the canary. |
| vpc_config.vpc_id | The IDs of the VPC where this canary is to run. |
| vpc_config.subnet_ids | The IDs of the subnets where this canary is to run. |
| vpc_config.security_group_ids | The IDs of the security groups for this canary. |
| visual_reference.base_screenshots | An array of screenshots that are used as the baseline for comparisons during visual monitoring. |
| visual_reference.base_canary_run_id | The ID of the canary run that produced the screenshots that are used as the baseline for visual monitoring comparisons during future runs of this canary. |
| tags | The list of key-value pairs that are associated with the canary. |
| artifact_config.s3_encryption.encryption_mode | The encryption method to use for artifacts created by this canary. |
| artifact_config.s3_encryption.kms_key_arn | The ARN of the customer-managed KMS key to use, if you specify SSE-KMS for EncryptionMode. |

## Examples

### Ensure a canary name is available.
    describe aws_synthetics_canary(name: 'CANARY_NAME') do
      its('name') { should eq 'CANARY_NAME' }
    end

### Ensure a state is `READY`.
    describe aws_synthetics_canary(name: 'CANARY_NAME') do
      its('status.state') { should eq 'READY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_synthetics_canary(name: 'CANARY_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_synthetics_canary(name: 'CANARY_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_synthetics_canary(name: 'CANARY_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Synthetics:Client:GetCanaryResponse` action with `Effect` set to `Allow`.