---
title: About the aws_lambda_aliases Resource
platform: aws
---

# aws_lambda_aliases

Use the `aws_lambda_aliases` InSpec audit resource to test properties of multiple AWS Lambda aliases.

The `AWS::Lambda::Alias` resource creates an alias for a Lambda function version. Use aliases to provide clients with a function identifier that you can update to invoke a different version.

## Syntax

Ensure that the alias exists.

    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end

## Parameters

`function_name` _(required)_

The name of the lambda function.

For additional information, see the [AWS documentation on AWS Lambda alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-alias.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| alias_arns | Lambda function ARN that is qualified using the alias name as the suffix. | alias_arn |
| names | The alias names. | name |
| function_versions | Function version to which the alias points. | function_version |
| descriptions | The alias descriptions. | description |
| routing_configs | Specifies an additional function versions the alias points to, allowing you to dictate what percentage of traffic will invoke each version. | routing_config |
| revision_ids | Represents the latest updated revision of the function or alias. | revision_id |

## Examples

### Ensure an alias ARN is available.

    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      its('alias_arns') { should include 'ALIAS_ARN' }
    end

### Ensure an alias name is available.

    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      its('names') { should include 'FUNCTION_ALIAS_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_lambda_aliases(function_name: 'FUNCTION_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:ListAliasesResponse` action with `Effect` set to `Allow`.
