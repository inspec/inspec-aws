---
title: About the aws_lambda_permission Resource
platform: aws
---

# aws\_lambda\_permission

Use the `aws_lambda_permission` InSpec audit resource to test properties of a single specific AWS Lambda Permission.

The AWS::Lambda::Permission resource grants an AWS service or another account permission to use a function. You can apply the policy at the function level, or specify a qualifier to restrict access to a single version or alias. If you use a qualifier, the invoker must use the full Amazon Resource Name (ARN) of that version or alias to invoke the function.

## Syntax

Ensure that permission has the desired statement id.

    describe aws_lambda_permission(function_name: 'LambdaFunctionName', Sid: 'StatementID') do
      its('sid') { should eq 'StatementID' }
    end

## Parameters

`function_name  Sid` _(required)_

For additional information, see the [AWS documentation on AWS Lambda Permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html).

## Properties

| Property | Description|
| --- | --- |
| sid | The statement id of the function. |
| effect | The effect of the function. |
| principal | The principal of the function. |
| action | The action of the function. |
| resource | The resource of the function. |

## Examples

### Ensure a sid is available.
    describe aws_lambda_permission(function_name: 'LambdaFunctionName', Sid: 'StatementID') do
      its('sid') { should eq 'StatementID' }
    end

### Ensure a effect is available.
    describe aws_lambda_permission(function_name: 'LambdaFunctionName', Sid: 'StatementID') do
        its('effect') { should eq 'Allow' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `lambda:client:get_policy` action with `Effect` set to `Allow`.