+++
title = "aws_api_gateway_v2_authorizers resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_v2_authorizers"
identifier = "inspec/resources/aws/aws_api_gateway_v2_authorizers resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_authorizers` InSpec audit resource to test the properties of multiple AWS API Gateway V2 authorizers.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Authorizer](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-authorizer.html).

## Syntax

Ensure the authorizers exist.

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

## Properties

`authorizer_credentials_arns`
: Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer.

: **Field**: `authorizer_credentials_arn`

`authorizer_ids`
: The authorizer identifier.

: **Field**: `authorizer_id`

`authorizer_result_ttl_in_seconds`
: The time to live (TTL) for cached authorizer results in seconds. If it equals 0, authorization caching is disabled. If it is greater than 0, API Gateway caches authorizer responses. The maximum value is **3600**, or **1 hour**. Supported only for HTTP API Lambda authorizers.

: **Field**: `authorizer_result_ttl_in_seconds`

`authorizer_types`
: The authorizer type. Specify `REQUEST` for a Lambda function using incoming request parameters. Specify `JWT` to use JSON Web Tokens (supported only for HTTP APIs).

: **Field**: `authorizer_type`

`authorizer_uris`
: The authorizer's Uniform Resource Identifier (URI).

: **Field**: `authorizer_uri`

`identity_sources`
: The identity source for which authorization is requested.

: **Field**: `identity_source`

`identity_validation_expressions`
: The validation expression does not apply to the REQUEST authorizer.

: **Field**: `identity_validation_expression`

`jwt_configurations`
: Represents the configuration of a JWT authorizer. Required for the `JWT` authorizer type. Supported only for HTTP APIs.

: **Field**: `jwt_configuration`

`names`
: The name of the authorizer.

: **Field**: `name`

`authorizer_payload_format_versions`
: Specifies the payload format sent to an HTTP API Lambda authorizer. Required for HTTP API Lambda authorizers. Supported values are **1.0** and **2.0**.

: **Field**: `authorizer_payload_format_version`

`enable_simple_responses`
: Specifies whether a Lambda authorizer returns a response in a simple format.

: **Field**: `enable_simple_responses`

## Examples

### Check the number of authorizers in an API

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  its('count') { should eq 4 }
end
```

### Test to ensure an authorizer ID is available

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  its('authorizer_ids') { should include 'AUTHORIZER_ID' }
end
```

### Verify the authorizer result

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  its('authorizer_result_ttl_in_seconds') { should include 15 }
end
```

### Verify the authorizer type

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  its('authorizer_types') { should include 'JWT' }
end
```

### Verify the authorizer's name

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  its('names') { should include 'AUTHORIZER_NAME' }
end
```

### Verify the simple responses enabling status

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  its('enable_simple_responses') { should include true }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_authorizers(api_id: 'API_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetAuthorizersResponse" %}}
