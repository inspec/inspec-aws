---
title: About the aws_lambda_functions Resource
platform: aws
---

# aws\_lambda\_functions

Use the `aws_lambda_functions` InSpec audit resource to test properties of a plural AWS Lambda Functions.

The AWS::Lambda::Function resource creates a Lambda function.

## Syntax

Ensure that a function exists.

    describe aws_lambda_functions do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS Lambda Function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html).

## Properties

| Property | Description|
| --- | --- |
| function_names | The name of the function. |
| function_arns | The function's Amazon Resource Name (ARN). |
| runtimes | The runtime environment for the Lambda function. |
| roles | The function's execution role. |
| handlers | The function that Lambda calls to begin executing your function. |
| code_sizes | The size of the function's deployment package, in bytes. |
| descriptions | The function's description. |
| timeouts | The amount of time in seconds that Lambda allows a function to run before stopping it. |
| memory_sizes | The amount of memory available to the function at runtime. |
| last_modified | The date and time that the function was last updated, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD). |
| code_sha_256 | The SHA256 hash of the function's deployment package. |
| versions | The version of the Lambda function. |
| vpc_configs | The function's networking configuration. |
| dead_letter_configs | The function's dead letter queue. |
| environments  | The function's environment variables. |
| kms_key_arns | The KMS key that's used to encrypt the function's environment variables. This key is only returned if you've configured a customer managed CMK. |
| tracing_configs | The function's AWS X-Ray tracing configuration. |
| master_arns | For Lambda@Edge functions, the ARN of the master function. |
| revision_ids | The latest updated revision of the function or alias. |
| layers | The function's layers. |
| states | The current state of the function. When the state is Inactive , you can reactivate the function by invoking it. |
| state_reasons | The reason for the function's current state. |
| state_reason_codes | The reason code for the function's current state. When the code is Creating , you can't invoke or modify the function. |
| last_update_statuses | The status of the last update that was performed on the function. This is first set to Successful after function creation completes. |
| last_update_status_reasons | The reason for the last update that was performed on the function. |
| last_update_status_reason_codes | The reason code for the last update that was performed on the function. |
| file_system_configs | Connection settings for an Amazon EFS file system. |

## Examples

### Ensure a function is available.
    describe aws_lambda_functions do
      its('function_names') { should include 'function_name' }
    end

### Ensure that the runtime is `python3.7`.
    describe aws_lambda_functions do
        its('runtimes') { should include 'python3.7' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_functions do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_lambda_functions do
      it { should_not exist }
    end

### be_available

Use `should` to check if the function is available.

    describe aws_lambda_functions do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `lambda:client:list_functions` action with `Effect` set to `Allow`.