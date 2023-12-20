+++
title = "aws_api_gateway_v2_authorizer resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_v2_authorizer"
identifier = "inspec/resources/aws/aws_api_gateway_v2_authorizer resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_authorizer` InSpec audit resource to test the properties of a single specific AWS API Gateway V2 authorizer.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Authorizer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-authorizer.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the authorizer exists.

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

`authorizer_id` _(required)_
: The authorizer identifier.

## Properties

`authorizer_credentials_arn`
: Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer.

`authorizer_id`
: The authorizer identifier.

`authorizer_result_ttl_in_seconds`
: The time to live (TTL) for cached authorizer results in seconds. If it equals 0, authorization caching is disabled. If it is greater than 0, API Gateway caches authorizer responses. The maximum value is **3600**, or **1 hour**. Supported only for HTTP API Lambda authorizers.

`authorizer_type`
: The authorizer type. Specify `REQUEST` for a Lambda function using incoming request parameters. Specify `JWT` to use JSON Web Tokens (supported only for HTTP APIs).

`authorizer_uri`
: The authorizer's Uniform Resource Identifier (URI).

`identity_source`
: The identity source for which authorization is requested.

`identity_validation_expression`
: The validation expression does not apply to the `REQUEST` authorizer.

`jwt_configuration`
: Represents the configuration of a JWT authorizer. Required for the `JWT` authorizer type. Supported only for HTTP APIs.

`jwt_configuration.audience`
: A list of the intended recipients of the `JWT`. A valid JWT must provide an `aud` that matches at least one entry in this list. Supported only for HTTP APIs.

`jwt_configuration.issuer`
: The base domain of the identity provider that issues JSON Web Tokens.

`name`
: The name of the authorizer.

`authorizer_payload_format_version`
: Specifies the payload format sent to an HTTP API Lambda authorizer. Required for HTTP API Lambda authorizers. Supported values are **1.0** and **2.0**.

`enable_simple_responses`
: Specifies whether a Lambda authorizer returns a response in a simple format.

## Examples

### Test to ensure an authorizer ID is available

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('authorizer_id') { should eq 'AUTHORIZER_ID' }
end
```

### Verify the authorizer result

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('authorizer_result_ttl_in_seconds') { should eq 15 }
end
```

### Verify the authorizer type

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('authorizer_type') { should eq 'JWT' }
end
```

### Verify the authorizer's name

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('name') { should eq 'AUTHORIZER_NAME' }
end
```

### Verify the simple responses enabling status

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  its('enable_simple_responses') { should eq true }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_authorizer(api_id: 'API_ID', authorizer_id: 'AUTHORIZER_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetAuthorizerResponse" %}}
