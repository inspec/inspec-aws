+++
title = "aws_api_gateway_v2_integration_responses resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_v2_integration_responses"
identifier = "inspec/resources/aws/aws_api_gateway_v2_integration_responses resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_integration_responses` InSpec audit resource to test properties of multiple AWS API Gateway V2 integration responses.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 IntegrationResponse](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-integrationresponse.html).

## Syntax

Ensure that the integration response exists.

```ruby
describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

`route_id` _(required)_
: The route identifier.

## Properties

`content_handling_strategies`
: Supported only for WebSocket APIs. Specifies how to handle response payload content type conversions. Supported values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following behaviors:

- **CONVERT_TO_BINARY**: Converts a response payload from a Base64-encoded string to the corresponding binary blob.
- **CONVERT_TO_TEXT**: Converts a response payload from a binary blob to a Base64-encoded string.

If this property is not defined, the response payload will be passed through from the integration response to the route response or method response without modification.

: **Field**: `content_handling_strategy`

`integration_response_ids`
: The integration response ID.

: **Field**: `integration_response_id`

`integration_response_keys`
: The integration response key.

: **Field**: `integration_response_key`

`response_parameters`
: A key-value map specifying response parameters that are passed to the method response from the backend. The key is a method response header parameter name. The mapped value is an integration response header value, a static value enclosed within a pair of single quotes or a JSON expression from the integration response body. The mapping key must match the pattern of `method.response.header.{name}`, where **name** is a valid and unique header name. The mapped non-static value must match the pattern of `integration.response.header.{name}` or `integration.response.body.{JSON-expression}`, where the name is a valid and unique response header name and JSON-expression is a valid JSON expression without the `$` prefix.

: **Field**: `response_parameters`

`response_templates`
: The collection of response templates for the integration response as a string-to-string map of key-value pairs. Response templates are represented as a key or value map, with a content type as the key and a template as the value.

: **Field**: `response_templates`

`template_selection_expressions`
: The template selection expressions for the integration response. Supported only for WebSocket APIs.

: **Field**: `template_selection_expression`

## Examples

### Test to ensure an integration response ID is available

```ruby
describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('integration_response_ids') { should include 'INTEGRATION_RESPONSE_ID' }
end
```

### Test to verify the integration response key

```ruby
describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('integration_response_keys') { should include 'INTEGRATION_RESPONSE_KEY' }
end
```

### Test to verify the content handling strategy

```ruby
describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('content_handling_strategy') { should include 'CONVERT_TO_BINARY' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least a result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_integration_responses(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetIntegrationResponsesResponse" %}}
