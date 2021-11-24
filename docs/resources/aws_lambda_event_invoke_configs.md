---
title: About the aws_lambda_event_invoke_configs Resource
platform: aws
---

# aws_lambda_event_invoke_configs

Use the `aws_lambda_event_invoke_configs` InSpec audit resource to test properties of the plural resource of AWS Lambda EventInvokeConfig.

The AWS::Lambda::EventInvokeConfig resource configures options for asynchronous invocation on a version or an alias.

## Syntax

Ensure that the config exists.

    describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end

## Parameters

`function_name` _(required)_

The name of the function.

For additional information, see the [AWS documentation on AWS Lambda EventInvokeConfig.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-eventinvokeconfig.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| last_modified | The date and time that the configuration was last updated. | last_modified |
| function_arns | The Amazon Resource Name (ARN) of the function. | function_arn |
| maximum_retry_attempts | The maximum number of times to retry when the function returns an error. | maximum_retry_attempts |
| destination_configs | A destination for events after they have been sent to a function for processing. | destination_configs |

## Examples

### Ensure an arn is available.
    describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
      its('function_arns') { should include 'FUNCTION_ARN' }
    end

### Ensure a maximum retry attempts is available.
    describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
        its('maximum_retry_attempts') { should include 1 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_event_invoke_configs(function_name: 'FUNCTION_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:ListFunctionEventInvokeConfigsResponse` action with `Effect` set to `Allow`.