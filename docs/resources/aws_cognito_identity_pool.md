---
title: About the aws_cognito_identity_pool Resource
platform: aws
---

# aws\_cognito\_identity\_pool

Use the `aws_cognito_identity_pool` InSpec audit resource to test properties of a single Cognito identity pool.

## Syntax

Ensure that an identity pool exists.
    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTITY_POOL_ID') do
      it { should exist }
    end

## Parameters

`identity\_pool\_id` _(required)_

For additional information, see the [AWS documentation on Cognito identity pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-identitypool.html).

## Properties

| Property | Description|
| --- | --- |
| identity_pool_id | An identity pool ID in the format REGION:GUID. |
| identity_pool_name | The name of your Amazon Cognito identity pool. |
| allow_unauthenticated_identities | Specifies whether the identity pool supports unauthenticated logins. |
| supported_login_providers | Key-value pairs that map provider names to provider app IDs. |
| developer_provider_name | The "domain" Amazon Cognito uses when referencing your users. This name acts as a placeholder that allows your backend and the Amazon Cognito service to communicate about the developer provider. For the DeveloperProviderName, you can use letters and periods (.), underscores (_), and dashes (-). |
| open_id_connect_provider_arns | The Amazon Resource Names (ARNs) of the OpenID connect providers. |
| cognito_identity_providers (provider_name) | The Amazon Cognito user pools and their client IDs. The provider name of the cognito identity providers. |
| cognito_identity_providers (client_id) | The Amazon Cognito user pools and their client IDs. The client ID of the cognito identity providers. |
| cognito_identity_providers (server_side_token_check) | The Amazon Cognito user pools and their client IDs. The server side token check of the cognito identity providers. |
| saml_provider_arns | The Amazon Resource Names (ARNs) of the Security Assertion Markup Language (SAML) providers. |
| identity_pool_tags | The tags of your Amazon Cognito identity pool. |

## Examples

### Ensure an identity pool ID is available.

    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTITY_POOL_ID') do
      its('identity_pool_id') { should eq 'IDENTITY_POOL_ID' }
    end

### Ensure that the identity pool name is available.

    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTITY_POOL_ID') do
        its('identity_pool_name') { should eq 'IDENTITY_POOL_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTITY_POOL_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTITY_POOL_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the identity pool id is available.

    describe aws_cognito_identity_pool(identity_pool_id: 'IDENTITY_POOL_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CognitoIdentity:Client:IdentityPool` action with `Effect` set to `Allow`.
