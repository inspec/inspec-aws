+++
title = "aws_cognito_userpool resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cognito_userpool"
identifier = "inspec/resources/aws/aws_cognito_userpool resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cognito_userpool` InSpec audit resource to test properties of a single specific Cognito user pool.

For additional information, including details on parameters and properties, see the [AWS documentation on Cognito user pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html).

## Syntax

Ensure that an user pool ID exists.

```ruby
describe aws_cognito_userpool(user_pool_id: 'USER_POOL_ID') do
  it { should exist }
end
```

## Parameters

`user_pool_id` _(required)_

: The ID of the user pool.

## Properties

`user_pool_id`
: The user pool ID.

`client_name`
: The client name of the user pool.

`client_id`
: The client ID of the user pool.

`client_secret`
: The client secret of the user pool.

`last_modified_date`
: The last modified date of the user pool.

`creation_date`
: The creation date of the user pool.

`refresh_token_validity`
: The refresh token validity of the user pool.

`access_token_validity`
: The access token validity of the user pool.

`id_token_validity`
: The ID token validity of the user pool.

`token_validity_units (access_token)`
: The access token in the token validity units of the user pool.

`token_validity_units (id_token)`
: The ID token in the token validity units of the user pool.

`token_validity_units (refresh_token)`
: The refresh token in the token validity units of the user pool.

`read_attributes`
: The read attributes of the user pool.

`write_attributes`
: The write attributes of the user pool.

`explicit_auth_flows`
: The explicit auth flows of the user pool.

`supported_identity_providers`
: The supported identity providers of the user pool.

`callback_urls`
: The callback URLs of the user pool.

`logout_urls`
: The logout urls of the user pool.

`default_redirect_uri`
: The default redirect URI of the user pool.

`allowed_o_auth_flows`
: The allowed_o_auth_flows of the user pool.

`allowed_o_auth_scopes`
: The allowed_o_auth_scopes of the user pool.

`allowed_o_auth_flows_user_pool_client`
: The allowed_o_auth_flows_user_pool_client of the user pool.

`analytics_configuration (application_id)`
: The application ID of the analytics configuration of the user pool.

`analytics_configuration (application_arn)`
: The application ARN of the analytics configuration of the user pool.

`analytics_configuration (role_arn)`
: The role ARN of the analytics configuration of the user pool.

`analytics_configuration (external_id)`
: The external ID of the analytics configuration of the user pool.

`analytics_configuration (user_data_shared)`
: The user data shared of the analytics configuration of the user pool.

`prevent_user_existence_errors`
: The prevent user existence errors of the user pool.

## Examples

**Ensure a user pool ID is available.**

```ruby
describe aws_cognito_userpool(user_pool_id: 'USER_POOL_ID') do
  its('user_pool_id') { should eq 'USER_POOL_ID' }
end
```

**Ensure a client name is available.**

```ruby
describe aws_cognito_userpool(user_pool_id: 'USER_POOL_ID') do
    its('client_name') { should eq 'CLIENT_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cognito_userpool(user_pool_id: 'USER_POOL_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cognito_userpool(user_pool_id: 'USER_POOL_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the client name is available.

```ruby
describe aws_cognito_userpool(user_pool_id: 'USER_POOL_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CognitoIdentityProvider:Client:DescribeUserPoolResponse" %}}
