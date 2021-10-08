---
title: About the aws_lambda_event_invoke_config Resource
platform: aws
---

# aws_lambda_event_invoke_config

Use the `aws_lambda_event_invoke_config` InSpec audit resource to test properties of a specific AWS Lambda EventInvokeConfig.

The AWS::Lambda::EventInvokeConfig resource configures options for asynchronous invocation on a version or an alias.

## Syntax

Ensure that the config exists.

    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
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
| function_arn | The Amazon Resource Name (ARN) of the function. | function_arn |
| maximum_retry_attempts | The maximum number of times to retry when the function returns an error. | maximum_retry_attempts |
| maximum_event_age_in_seconds | The maximum age of a request that Lambda sends to a function for processing. | maximum_event_age_in_seconds |
| on_success_destinations | The destination configuration for successful invocations. The Amazon Resource Name (ARN) of the destination resource. | destination_config (on_success (destination)) |
| on_faliure_destinations | The destination configuration for failed invocations. The Amazon Resource Name (ARN) of the destination resource. | destination_config (on_failure (destination)) |

## Examples

### Ensure an arn is available.
    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
      its('function_arn') { should eq 'FUNCTION_ARN' }
    end

### Ensure a maximum retry attempts is available.
    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
        its('maximum_retry_attempts') { should eq 1 }
    end

### Ensure on success destination is available.
    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
        its('on_success_destinations') { should include 'DESTINATION' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_lambda_event_invoke_config(function_name: 'FUNCTION_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:FunctionEventInvokeConfig` action with `Effect` set to `Allow`.