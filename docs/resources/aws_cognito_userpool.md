---
title: About the aws_cognito_userpool Resource
platform: aws
---

# aws\_cognito\_userpool

Use the `aws_cognito_userpool` InSpec audit resource to test properties of a single specific Cognito User Pool.

The AWS::Cognito::UserPool resource creates an Amazon Cognito user pool.

## Syntax

Ensure that an user pool id exists.

    describe aws_cognito_userpool(user_pool_id: 'test') do
      it { should exist }
    end

## Parameters

`user_pool_id` _(required)_

For additional information, see the [AWS documentation on Cognito User Pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html).

## Properties

| Property | Description|
| --- | --- |
| user_pool_id | The user pool id of the User Pools. |
| client_name | The client name of the User Pools. |
| client_id | The client id of the User Pools. |
| client_secret | The client secret of the User Pools. |
| last_modified_date | The last modified date of the User Pools. |
| creation_date | The creation date of the User Pools. |
| refresh_token_validity | The refresh token validity of the User Pools. |
| access_token_validity | The access token validity of the User Pools. |
| id_token_validity | The id token validity of the User Pools. |
| token_validity_units (access_token) | The access token in the token validity units of the User Pools. |
| token_validity_units (id_token) | The id token in the token validity units of the User Pools. |
| token_validity_units (refresh_token) | The refresh token in the token validity units of the User Pools. |
| read_attributes | The read attributes of the User Pools. |
| write_attributes | The write attributes of the User Pools. |
| explicit_auth_flows | The explicit auth flows of the User Pools. |
| supported_identity_providers | The supported identity providers of the User Pools. |
| callback_urls | The callback urls of the User Pools. |
| logout_urls | The logout urls of the User Pools. |
| default_redirect_uri | The default redirect uri of the User Pools. |
| allowed_o_auth_flows | The allowed_o_auth_flows of the User Pools. |
| allowed_o_auth_scopes | The allowed_o_auth_scopes of the User Pools. |
| allowed_o_auth_flows_user_pool_client | The allowed_o_auth_flows_user_pool_client of the User Pools. |
| analytics_configuration (application_id) | The application id of the analytics configuration of the User Pools. |
| analytics_configuration (application_arn) | The application arn of the analytics configuration of the User Pools. |
| analytics_configuration (role_arn) | The role arn of the analytics configuration of the User Pools. |
| analytics_configuration (external_id) | The external id of the analytics configuration of the User Pools. |
| analytics_configuration (user_data_shared) | The user data shared of the analytics configuration of the User Pools. |
| prevent_user_existence_errors | The prevent user existence errors of the User Pools. |


## Examples

### Ensure a user pool id is available.
    describe aws_cognito_userpool(user_pool_id: 'test') do
      its('user_pool_id') { should eq 'test' }
    end

### Ensure a client name is available.
    describe aws_cognito_userpool(user_pool_id: 'test') do
        its('client_name') { should eq 'test' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cognito_userpool(user_pool_id: 'test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_cognito_userpool(user_pool_id: 'test') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the client name is available.

    describe aws_cognito_userpool(user_pool_id: 'test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cognitoidentityprovider:client:describe_user_pool_client` action with `Effect` set to `Allow`.