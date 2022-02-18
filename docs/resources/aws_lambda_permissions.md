---
title: About the aws_lambda_permissions Resource
platform: aws
---

# aws_lambda_permissions

Use the `aws_lambda_permissions` InSpec audit resource to test properties of multiple AWS Lambda permissions.

The `AWS::Lambda::Permission` resource grants an AWS service or another account permission to use a function. You can apply the policy at the function level, or specify a qualifier to restrict access to a single version or alias. If you use a qualifier, the invoker must use the full Amazon Resource Name (ARN) of that version or alias to invoke the function.

## Syntax

Ensure that permission has the desired statement id.

    describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME') do
      its('sids') { should include 'STATEMENT_ID' }
    end

## Parameters

`function_name` _(required)_

For additional information, see the [AWS documentation on AWS Lambda permission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-permission.html).

## Properties

| Property | Description|
| --- | --- |
| sids | The statement ID of the function. |
| effects | The effect of the function. |
| principals | The AWS services or accounts that invokes the function. |
| actions | The action of the function. |
| resources | The resource ARNs of the function.. |

## Examples

### Ensure a statement ID is available.

    describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME') do
      its('sids') { should include 'STATEMENT_ID' }
    end

### Ensure an effect is available.

    describe aws_lambda_permission(function_name: 'LAMBDA_FUNCTION_NAME') do
        its('effects') { should include 'Allow' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Lambda:Client:GetPolicyResponse` action with `Effect` set to `Allow`.
