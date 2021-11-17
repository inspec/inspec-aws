---
title: About the aws_cognito_userpools Resource
platform: aws
---

# aws\_cognito\_userpools

Use the `aws_cognito_userpools` InSpec audit resource to test properties of multiple Cognito user pools.

## Syntax

Ensure that a user pool exists.

    describe aws_cognito_userpools do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on Cognito user pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The IDs of the user pools. |
| names | The names of the user pools. |
| lambda_configs | The lambda trigger configuration of the user pools. |
| statuses | The statuses of the user pools. |
| last_modified_dates | The last_modified_dates of the user pools. |
| creation_dates | The creation_dates of the user pools. |

## Examples

### Ensure an ID is available.

    describe aws_cognito_userpools do
      its('ids') { should include 'USER_POOL_ID' }
    end

### Ensure a name is available.

    describe aws_cognito_userpools do
      its('names') { should include 'USER_POOL_NAME' }
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

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CognitoIdentityProvider:Client:ListUserPoolsResponse` action with `Effect` set to `Allow`.
