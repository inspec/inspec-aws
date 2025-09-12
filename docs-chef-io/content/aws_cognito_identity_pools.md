+++
title = "aws_cognito_identity_pools resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cognito_identity_pools"
identifier = "inspec/resources/aws/aws_cognito_identity_pools resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cognito_identity_pools` InSpec audit resource to test properties of multiple Cognito identity pools.

For additional information, including details on parameters and properties, see the [AWS documentation on Cognito identity pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-identitypool.html).

## Syntax

Ensure that an identity pool exists.

```ruby
describe aws_cognito_identity_pools do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`identity_pool_ids`
: The IDs of the identity pool.

`identity_pool_names`
: The names of the identity pool.

## Examples

Ensure an identity pool is available:

```ruby
describe aws_cognito_identity_pools do
  its('identity_pool_ids') { should include 'IDENTITY_POOL_ID' }
end
```

Ensure that the state is `ENABLED` or `DISABLED`:

```ruby
describe aws_cognito_identity_pools do
    its('identity_pool_names') { should include 'IDENTITY_POOL_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cognito_identity_pools do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cognito_identity_pools do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the identity pool is available.

```ruby
describe aws_cognito_identity_pools do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CognitoIdentity:Client:ListIdentityPoolsResponse" %}}
