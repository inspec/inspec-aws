+++
title = "aws_cognito_userpools resource"

draft = false


[menu.aws]
title = "aws_cognito_userpools"
identifier = "inspec/resources/aws/aws_cognito_userpools resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cognito_userpools` InSpec audit resource to test properties of multiple Cognito user pools.

For additional information, including details on parameters and properties, see the [AWS documentation on Cognito user pool](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html).

## Syntax

Ensure that a user pool exists.

```ruby
describe aws_cognito_userpools do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The IDs of the user pools.

`names`
: The names of the user pools.

`lambda_configs`
: The lambda trigger configuration of the user pools.

`statuses`
: The statuses of the user pools.

`last_modified_dates`
: The last_modified_dates of the user pools.

`creation_dates`
: The creation_dates of the user pools.

## Examples

Ensure an ID is available:

```ruby
describe aws_cognito_userpools do
  its('ids') { should include 'USER_POOL_ID' }
end
```

Ensure a name is available:

```ruby
describe aws_cognito_userpools do
  its('names') { should include 'USER_POOL_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cognito_userpools do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cognito_userpools do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the user pool is available.

```ruby
describe aws_cognito_userpools do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CognitoIdentityProvider:Client:ListUserPoolsResponse" %}}
