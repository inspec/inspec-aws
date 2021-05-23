---
title: About the aws_cognito_userpools Resource
platform: aws
---

# aws\_cognito\_userpools

Use the `aws_cognito_userpools` InSpec audit resource to test properties of the plural specific Cognito User Pool.

The AWS::Cognito::UserPool resource creates an Amazon Cognito user pool.

## Syntax

Ensure that a user pool exists.
    describe aws_cognito_userpools do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Cognito User Pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The ids of the User Pools. |
| names | The names of the User Pools. |
| lambda_configs | The lambda_configs of the User Pools. |
| statuses | The statuses of the User Pools. |
| last_modified_dates | The last_modified_dates of the User Pools. |
| creation_dates | The creation_dates of the User Pools. |

## Examples

### Ensure an id is available.
    describe aws_cognito_userpools do
      its('ids') { should include 'test' }
    end

### Ensure a name is available.
    describe aws_cognito_userpools do
      its('names') { should include 'test' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.
    describe aws_cognito_userpools do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    describe aws_cognito_userpools do
      it { should_not exist }
    end

### be_available

Use `should` to check if the user pool is available.
    describe aws_cognito_userpools do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cognitoidentityprovider:client:list_user_pools` action with `Effect` set to `Allow`.