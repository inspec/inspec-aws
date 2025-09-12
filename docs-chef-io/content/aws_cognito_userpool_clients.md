+++
title = "aws_cognito_userpool_clients resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cognito_userpool_clients"
identifier = "inspec/resources/aws/aws_cognito_userpool_clients resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cognito_userpool_clients` InSpec audit resource to test properties of multiple Cognito user pool clients.

For additional information, including details on parameters and properties, see the [AWS documentation on Cognito user pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpoolclient.html).

## Syntax

Ensure that a user pool client exists.

```ruby
describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
  it { should exist }
end
```

## Parameters

`user_pool_id` _(required)_

## Properties

`client_ids`
: The client IDs of the user pools.

`user_pool_ids`
: The user pool IDs of the user pools.

`client_names`
: The client names of the user pools.

## Examples

**Ensure that the specific client ID is available.**

```ruby
describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
  its('client_ids') { should include 'CLIENT_ID' }
end
```

**Ensure that the specific client name is available.**

```ruby
describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
    its('client_names') { should include 'CLIENT_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the user pool clients are available.

```ruby
describe aws_cognito_userpool_clients(user_pool_id: 'USER_POOL_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CognitoIdentityProvider:Client:ListUserPoolClientsResponse" %}}
