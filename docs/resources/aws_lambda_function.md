---
title: About the aws_lambda_function Resource
platform: aws
---

# aws\_lambda\_function

Use the `aws_lambda_function` InSpec audit resource to test properties of a single specific AWS Lambda Function.

The AWS::Lambda::Function resource creates a Lambda function.

## Syntax

Ensure that function exists.

    describe aws_lambda_function(function_name: 'function name') do
      it { should exist }
    end

## Parameters

`function_name` _(required)_

For additional information, see the [AWS documentation on AWS Lambda Function](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html).

## Properties

| Property | Description|
| --- | --- |
| function_name | The name of the function. |
| function_arn | The function's Amazon Resource Name (ARN). |
| runtime | The runtime environment for the Lambda function. |
| role | The function's execution role. |
| handler | The function that Lambda calls to begin executing your function. |
| code_size | The size of the function's deployment package, in bytes. |
| description | The function's description. |
| timeout | The amount of time in seconds that Lambda allows a function to run before stopping it. |
| memory_size | The amount of memory available to the function at runtime. |
| last_modified | The date and time that the function was last updated, in ISO-8601 format (YYYY-MM-DDThh:mm:ss.sTZD). |
| code_sha_256 | The SHA256 hash of the function's deployment package. |
| version | The version of the Lambda function. |
| vpc_config (subnet_ids) | The function's networking configuration. A list of VPC subnet IDs. |
| vpc_config (security_group_ids) | The function's networking configuration. A list of VPC security groups IDs. |
| vpc_config (vpc_id) | The function's networking configuration. The ID of the VPC. |
| dead_letter_config (target_arn) | The function's dead letter queue. The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic. |
| environment (variables) | The function's environment variables. Environment variable key-value pairs. |
| environment (error (error_code)) | The function's environment variables. Error messages for environment variables that couldn't be applied. The error code. |
| environment (error (message)) | The function's environment variables. Error messages for environment variables that couldn't be applied. The error message. |
| kms_key_arn | The KMS key that's used to encrypt the function's environment variables. This key is only returned if you've configured a customer managed CMK. |
| tracing_config (mode) | The function's AWS X-Ray tracing configuration. The tracing mode. |
| master_arn | For Lambda@Edge functions, the ARN of the master function. |
| revision_id | The latest updated revision of the function or alias. |
| layers (arn) | The function's layers. The Amazon Resource Name (ARN) of the function layer. |
| layers (code_size) | The function's layers. The size of the layer archive in bytes. |
| state | The current state of the function. When the state is Inactive , you can reactivate the function by invoking it. |
| state_reason | The reason for the function's current state. |
| state_reason_code | The reason code for the function's current state. When the code is Creating , you can't invoke or modify the function. |
| last_update_status | The status of the last update that was performed on the function. This is first set to Successful after function creation completes. |
| last_update_status_reason | The reason for the last update that was performed on the function. |
| last_update_status_reason_code | The reason code for the last update that was performed on the function. |
| file_system_configs (arn) | Connection settings for an Amazon EFS file system. The Amazon Resource Name (ARN) of the Amazon EFS access point that provides access to the file system. |
| file_system_configs (local_mount_path) | Connection settings for an Amazon EFS file system. The path where the function can access the file system, starting with /mnt/ . |

## Examples

### Ensure a function is available.
    describe aws_lambda_function(function_name: 'function name') do
      its('function_name') { should eq 'function name' }
    end

### Ensure that the runtime is `python3.7`.
    describe aws_lambda_function(function_name: 'function name') do
        its('runtime') { should eq 'python3.7' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_lambda_function(function_name: 'function name') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_lambda_function(function_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the function is available.

    describe aws_lambda_function(function_name: 'function name') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `lambda:client:get_function` action with `Effect` set to `Allow`.