---
title: About the aws_cognito_userpool_clients Resource
platform: aws
---

# aws\_cognito\_userpool\_clients

Use the `aws_cognito_userpool_clients` InSpec audit resource to test properties of multiple Cognito user pool clients.

## Syntax

Ensure that a user pool client exists.

    describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
      it { should exist }
    end

## Parameters

`user_pool_id` _(required)_

For additional information, see the [AWS documentation on Cognito user pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpoolclient.html).

## Properties

| Property | Description|
| --- | --- |
| client_ids | The client IDs of the user pools. |
| user_pool_ids | The user pool IDs of the user pools. |
| client_names | The client names of the user pools. |

## Examples

### Ensure that the specific client ID is available.

    describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
      its('client_ids') { should include 'CLIENT_ID' }
    end

### Ensure that the specific client name is available.

    describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
        its('client_names') { should include 'CLIENT_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the user pool clients are available.

    describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CognitoIdentityProvider:Client:ListUserPoolClientsResponse` action with `Effect` set to `Allow`.
