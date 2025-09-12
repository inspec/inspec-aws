+++
title = "aws_cognito_userpool_client resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cognito_userpool_client"
identifier = "inspec/resources/aws/aws_cognito_userpool_client resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cognito_userpool_client` InSpec audit resource to test properties of a single Cognito user pool client.

For additional information, including details on parameters and properties, see the [AWS documentation on Cognito user pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpoolclient.html).

## Syntax

Ensure that a user pool exists.

```ruby
describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
  it { should exist }
end
```

## Parameters

`user_pool_id` _(required)_

: The ID of the user pool.

`client_id` _(required)_

: The client ID of the user pool.

## Properties

`user_pool_id`
: The user pool ID.

`client_name`
: The app client name associated with the user pool.

`client_id`
: The app client ID associated with the user pool.

`client_secret`
: The app client secret of the user pool client.

`last_modified_date`
: The last modified date of the user pool client.

`creation_date`
: The creation date of the user pool client.

`refresh_token_validity`
: The time limit value that the refresh token is valid in token_validity_units.

`access_token_validity`
: The time limit value of the access token in token_validity_units.

`id_token_validity`
: The time limit value of the refresh token in token_validity_units.

`token_validity_units (access_token)`
: The time unit for the access_token_validity.

`token_validity_units (id_token)`
: The time unit for the id_token_validity.

`token_validity_units (refresh_token)`
: The time unit for the refresh_token_validity.

`read_attributes`
: A list of the read-only attributes of the user pool.

`write_attributes`
: A list of writeable attributes of the user pool.

`explicit_auth_flows`
: The authentication flows supported by the user pool client.

`supported_identity_providers`
: The list of provider names for the identity providers supported by the user pool client.

`callback_urls`
: The list of callback URLs for the identity providers.

`logout_urls`
: The list of logout URLs for the identity providers.

`default_redirect_uri`
: The default redirect URI. This must be in the callback_urls list.

`allowed_o_auth_flows`
: The allowed_o_auth_flows of the user pool.

`allowed_o_auth_scopes`
: The allowed_o_auth_scopes of the user pool.

`allowed_o_auth_flows_user_pool_client`
: Whether the client is allowed to follow the OAuth protocol when interacting with user pools. Valid values: `true`, `false`.

`analytics_configuration (application_id)`
: The Amazon Pinpoint analytics application ID.

`analytics_configuration (application_arn)`
: The Amazon Pinpoint ARN.

`analytics_configuration (role_arn)`
: The ARN of an IAM role that authorizes Cognito to publish events to Pinpoint.

`analytics_configuration (external_id)`
: The Amazon Pinpoint analytics external ID.

`analytics_configuration (user_data_shared)`
: Whether Cognito will include user data if it publishes to Pinpoint analytics. Valid values: `true`, `false`.

`prevent_user_existence_errors`
: Select which errors are returned by Cognito APIs. Valid values: `ENABLED`, `LEGACY`.

## Examples

**Ensure an client name is available.**

```ruby
describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
  its('client_name') { should eq 'CLIENT_NAME' }
end
```

**Ensure an client secret is available.**

```ruby
describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
    its('client_secret') { should eq 'CLIENT_SECRET' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the user pool is available.

```ruby
describe aws_cognito_userpool_client(user_pool_id: 'USER_POOL_ID', client_id: 'CLIENT_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CognitoIdentityProvider:Client:DescribeUserPoolClientResponse" %}}
