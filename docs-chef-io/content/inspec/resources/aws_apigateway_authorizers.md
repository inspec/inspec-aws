+++
title = "aws_apigateway_authorizers Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_apigateway_authorizers"
identifier = "inspec/resources/aws/aws_apigateway_authorizers Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_apigateway_authorizers` InSpec audit resource to test properties of multiple AWS API Gateway authorizers.

The `AWS::ApiGateway::Authorizer` resource creates an authorization layer that API Gateway activates for methods that have authorization enabled. API Gateway activates the authorizer when a client calls those methods.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS APIGateway Authorizer.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-authorizer.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the authorizer exists.

```ruby
describe aws_apigateway_authorizers(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The ID of the REST API.

## Properties

`ids`
: The identifier for the authorizer resource.

: **Field**: `id`

`names`
: The name of the authorizer.

: **Field**: `name`

`types`
: The authorizer type.

: **Field**: `type`

`provider_arns`
: A list of the Amazon Cognito user pool ARNs for the COGNITO_USER_POOLS authorizer.

: **Field**: `provider_arns`

`auth_types`
: Optional customer-defined field, used in OpenAPI imports and exports without functional impact.

: **Field**: `auth_type`

`authorizer_uris`
: Specifies the authorizer's Uniform Resource Identifier (URI).

: **Field**: `authorizer_uri`

`authorizer_credentials`
: Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer.

: **Field**: `authorizer_credentials`

`identity_sources`
: The identity source for which authorization is requested.

: **Field**: `identity_source`

`identity_validation_expressions`
: A validation expression for the incoming identity token.

: **Field**: `identity_validation_expression`

`authorizer_result_ttl_in_seconds`
: The TTL in seconds of cached authorizer results.

: **Field**: `authorizer_result_ttl_in_seconds`

## Examples

**Test that an ID is available.**

```ruby
describe aws_apigateway_authorizers(rest_api_id: 'REST_API_ID') do
  its('ids') { should include 'AUTHORIZER_ID' }
end
```

**Test that a name is available.**

```ruby
describe aws_apigateway_authorizers(rest_api_id: 'REST_API_ID') do
  its('names') { should include 'AUTHORIZER_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_apigateway_authorizers(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_apigateway_authorizers(rest_api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:Authorizers" %}}
