---
title: About the aws_lambda_alias Resource
platform: aws
---

# aws_lambda_alias

Use the `aws_lambda_alias` InSpec audit resource to test properties of a single AWS Lambda alias.

The `AWS::Lambda::Alias` resource creates an alias for a Lambda function version. Use aliases to provide clients with a function identifier that you can update to invoke a different version.

## Syntax

Ensure that the alias exists.

    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      it { should exist }
    end

## Parameters

`function_name` _(required)_

The name of the lambda function.

`function_alias_name` _(required)_

Name of the alias for which you want to retrieve information.

For additional information, see the [AWS documentation on AWS Lambda alias](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-alias.html).

## Properties

| Property | Description |
| --- | --- |
| alias_arn | Lambda function ARN that is qualified using the alias name as the suffix. |
| name | The alias name. |
| function_version | Function version to which the alias points. |
| description | The alias description. |
| routing_config.additional_version_weights | The name of the second alias, and the percentage of traffic that is routed to it. |
| revision_id | Represents the latest updated revision of the function or alias. |

## Examples

### Ensure an alias ARN is available.

    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      its('alias_arn') { should eq 'ALIAS_ARN' }
    end

### Ensure a alias name is available.

    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      its('name') { should eq 'FUNCTION_ALIAS_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_lambda_alias(function_name: 'FUNCTION_NAME', function_alias_name: 'FUNCTION_ALIAS_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:AliasConfiguration` action with `Effect` set to `Allow`.
