+++
title = "aws_apigateway_authorizer Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_apigateway_authorizer"
identifier = "inspec/resources/aws/aws_apigateway_authorizer Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_authorizer` InSpec audit resource to test properties of a single specific AWS API Gateway authorizer.

The `AWS::ApiGateway::Authorizer` resource creates an authorization layer that API Gateway activates for methods that have authorization enabled. API Gateway activates the authorizer when a client calls those methods.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway Authorizer.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-authorizer.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the authorizer exists.

```ruby
describe aws_apigateway_authorizer(rest_api_id: 'REST_API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated REST API.

`authorizer_id` _(required)_

: The identifier of the authorizer resource.

## Properties

`id`
: The identifier for the authorizer resource.

`name`
: The name of the authorizer.

`type`
: The authorizer type.

`provider_arns`
: A list of the Amazon Cognito user pool ARNs for the COGNITO_USER_POOLS authorizer.

`auth_type`
: Optional customer-defined field, used in OpenAPI imports and exports without functional impact.

`authorizer_uri`
: Specifies the authorizer's Uniform Resource Identifier (URI).

`authorizer_credentials`
: Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer.

`identity_source`
: The identity source for which authorization is requested.

`identity_validation_expression`
: A validation expression for the incoming identity token.

`authorizer_result_ttl_in_seconds`
: The TTL in seconds of cached authorizer results.

## Examples

**Test that an ID is available.**

```ruby
describe aws_apigateway_authorizer(rest_api_id: 'REST_API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('id') { should eq 'AUTHORIZER_ID' }
end
```

**Test that a name is available.**

```ruby
describe aws_apigateway_authorizer(rest_api_id: 'REST_API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('name') { should eq 'AUTHORIZER_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_authorizer(rest_api_id: 'REST_API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_authorizer(rest_api_id: 'REST_API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_apigateway_authorizer(rest_api_id: 'REST_API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:Authorizer" %}}
