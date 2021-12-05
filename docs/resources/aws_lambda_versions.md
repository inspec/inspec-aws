---
title: About the aws_lambda_versions Resource
platform: aws
---

# aws_lambda_versions

Use the `aws_lambda_versions` InSpec audit resource to test properties of multiple AWS Lambda function versions.

The `AWS::Lambda::Version` resource creates a version from the current code and configuration of a function. Use versions to create a snapshot of your function code and configuration that doesn't change.

## Syntax

Ensure that a Lambda version exists.

    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      it { should exist }
    end

## Parameters

`layer_name` _(required)_

The name or Amazon Resource Name (ARN) of the Lambda layer.

For additional information, see the [AWS documentation on AWS Lambda Version](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-version.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| layer_version_arns | The ARN of the layer version. | layer_version_arn |
| versions | The version number. | version |
| descriptions | The description of the version. | description |
| created_dates | The date that the layer version was created, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD). | created_date |
| compatible_runtimes | The layer's compatible runtimes. | compatible_runtimes |
| license_infos | The layer's software license. | license_info |
| compatible_architectures | A list of compatible instruction set architectures . | compatible_architectures |

## Examples

### Ensure a layer version ARN is available.

    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      its('layer_version_arns') { should include 'LAYER_VERSION_ARN' }
    end

### Ensure a version is available.

    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      its('versions') { should include 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_lambda_versions(layer_name: 'LAYER_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:ListLayerVersionsResponse` action with `Effect` set to `Allow`.
