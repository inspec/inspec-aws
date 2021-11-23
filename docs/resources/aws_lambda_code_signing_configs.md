---
title: About the aws_lambda_code_signing_configs Resource
platform: aws
---

# aws_lambda_code_signing_configs

Use the `aws_lambda_code_signing_configs` InSpec audit resource to test properties of multiple AWS Lambda code signing configurations.

The `AWS::Lambda::CodeSigningConfig` resource specifies the details about a code signing configuration.

## Syntax

Ensure that the code signing config exists.

    describe aws_lambda_code_signing_configs do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS SSM CodeSigningConfig](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-codesigningconfig.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| code_signing_config_ids | Unique identifier for the Code signing configuration. | code_signing_config_id |
| code_signing_config_arns | The Amazon Resource Name (ARN) of the Code signing configuration. | code_signing_config_arn |
| descriptions | Code signing configuration description. | description |
| allowed_publishers | The Amazon Resource Name (ARN) for each of the signing profiles. A signing profile defines a trusted user who can sign a code package. | allowed_publishers |
| code_signing_policies | Code signing configuration policy for deployment validation failure. | code_signing_policies |
| last_modified | The date and time that the Code signing configuration was last modified, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD). | last_modified |

## Examples

### Ensure a code signing config id is available.

    describe aws_lambda_code_signing_configs do
      its('code_signing_config_ids') { should include 'CODE_SIGNING_CONFIG_ID' }
    end

### Ensure a code signing config arn is available.

    describe aws_lambda_code_signing_configs do
      its('code_signing_config_arns') { should include 'CODE_SIGNING_CONFIG_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_code_signing_configs do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_code_signing_configs do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_lambda_code_signing_configs do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:ListCodeSigningConfigsResponse` action with `Effect` set to `Allow`.
