---
title: About the aws_synthetics_canaries Resource
platform: aws
---

# aws_synthetics_canaries

Use the `aws_synthetics_canaries` InSpec audit resource to test properties of the plural resource of AWS Synthetics Canary.

## Syntax

Ensure that the canary exists.

    describe aws_synthetics_canaries do
      it { should exist }
    end

## Parameters

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on AWS Synthetics Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| ids | The unique ID of this canary. | id |
| names | The name of the canary. | name |
| codes | This structure contains information about the canary's Lambda handler and where its code is stored by CloudWatch Synthetics. | code |
| execution_role_arns | The ARN of the IAM role used to run the canary. This role must include lambda.amazonaws.com as a principal in the trust policy. | execution_role_arn |
| schedules | A structure that contains information about how often the canary is to run, and when these runs are to stop. | schedule |
| run_configs | A structure that contains information about a canary run. | run_config |
| success_retention_period_in_days | The number of days to retain data about successful runs of this canary. | success_retention_period_in_days |
| failure_retention_period_in_days | The number of days to retain data about failed runs of this canary. | failure_retention_period_in_days |
| statuses | A structure that contains information about the canary's status. | status |
| timelines | A structure that contains information about when the canary was created, modified, and most recently run. | timeline |
| artifact_s3_locations | The location in Amazon S3 where Synthetics stores artifacts from the runs of this canary. Artifacts include the log file, screenshots, and HAR files. | artifact_s3_location |
| engine_arns | The ARN of the Lambda function that is used as your canary's engine. | engine_arn |
| runtime_versions | Specifies the runtime version to use for the canary. | runtime_version |
| vpc_configs | If this canary is to test an endpoint in a VPC, this structure contains information about the subnets and security groups of the VPC endpoint. | vpc_config |
| visual_references | If this canary performs visual monitoring by comparing screenshots, this structure contains the ID of the canary run to use as the baseline for screenshots, and the coordinates of any parts of the screen to ignore during the visual monitoring comparison. | visual_reference |
| tags | The list of key-value pairs that are associated with the canary. | tags |
| artifact_configs | A structure that contains the configuration for canary artifacts, including the encryption-at-rest settings for artifacts that the canary uploads to Amazon S3. | artifact_config |

## Examples

### Ensure a canary id is available.
    describe aws_synthetics_canaries do
      its('ids') { should include 'CANARY_ID' }
    end

### Ensure a canary name is available.
    describe aws_synthetics_canaries do
      its('names') { should include 'CANARY_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_synthetics_canaries do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_synthetics_canaries do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Synthetics:Client:DescribeCanariesResponse` action with `Effect` set to `Allow`.