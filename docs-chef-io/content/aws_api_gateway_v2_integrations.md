+++
title = "aws_api_gateway_v2_integrations resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_v2_integrations"
identifier = "inspec/resources/aws/aws_api_gateway_v2_integrations resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_integrations` InSpec audit resource to test properties of multiple AWS API Gateway V2 integrations.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Integration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-integration.html).

## Syntax

Ensure that the integration exists.

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

## Properties

`api_gateway_manageds`
: Specifies whether API Gateway manages integration.

: **Field**: `api_gateway_managed`

`connection_ids`
: The VPC link ID for a private integration. Supported only for HTTP APIs.

: **Field**: `connection_id`

`connection_types`
: The network connection type to the integration endpoint. Specify `INTERNET` for connections through the public routable internet or `VPC_LINK` for private connections between API Gateway and resources in a VPC. The default value is `INTERNET`.

: **Field**: `connection_type`

`content_handling_strategies`
: Supported only for WebSocket APIs. Specifies how to handle response payload content type conversions. Supported values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following behaviors:

- `CONVERT_TO_BINARY`: Converts a response payload from a Base64-encoded string to the corresponding binary blob.
- `CONVERT_TO_TEXT`: Converts a response payload from a binary blob to a Base64-encoded string.

If this property is not defined, the response payload will be passed through from the integration response to the route response or method response without modification.

: **Field**: `content_handling_strategy`

`credentials_arns`
: Specifies the credentials required for the integration, if any.

: **Field**: `credentials_arn`

`descriptions`
: Represents the description of an integration.

: **Field**: `description`

`integration_ids`
: Represents the identifier of an integration.

: **Field**: `integration_id`

`integration_methods`
: Specifies the integration's HTTP method type.

: **Field**: `integration_method`

`integration_response_selection_expressions`
: The integration response selection expression for the integration. Supported only for WebSocket APIs.

: **Field**: `integration_response_selection_expression`

`integration_subtypes`
: Supported only for `HTTP API AWS_PROXY integrations`. Specifies the AWS service action to invoke.

: **Field**: `integration_subtype`

`integration_types`
: The integration type. One of the following:

- `AWS`: for integrating the route or method request with an AWS service action, including the Lambda function-invoking action. With the Lambda function-invoking action, this is referred to as the Lambda custom integration. With any other AWS service action, this is known as AWS integration. Supported only for WebSocket APIs.
- `AWS_PROXY`: for integrating the route or method request with a Lambda function or other AWS service action. This integration is also referred to as a Lambda proxy integration.
`HTTP`: for integrating the route or method request with an HTTP endpoint. This integration is also referred to as the HTTP custom integration. Supported only for WebSocket APIs.
`HTTP_PROXY`: for integrating the route or method request with an HTTP endpoint, with the client request passed through as-is. This is also referred to as HTTP proxy integration.
`MOCK`: for integrating the route or method request with API Gateway as a **loopback** endpoint without invoking any backend. Supported only for WebSocket APIs.

: **Field**: `integration_type`

`integration_uris`
: For a Lambda integration, specify the URI of a Lambda function.

For an HTTP integration, specify a fully-qualified URL.

For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. If you specify the ARN of an AWS Cloud Map service, API Gateway uses `DiscoverInstances` to identify resources. You can use query parameters to target specific resources. To learn more, see DiscoverInstances. For private integrations, all resources must be owned by the same AWS account.

: **Field**: `integration_uri`

`passthrough_behaviors`
: Specifies the pass-through behavior for incoming requests based on the `Content-Type` header in the request and the available mapping templates specified as the `requestTemplates` property on the `Integration` resource. There are three valid values: `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES`, and `NEVER`. Supported only for WebSocket APIs.

- `WHEN_NO_MATCH` passes the request body for unmapped content types to the integration backend without transformation.
- `NEVER` rejects unmapped content types with an `HTTP 415 Unsupported Media Type` response.
- `WHEN_NO_TEMPLATES` allows pass-through when the integration has no content types mapped to templates. However, if at least one content type defined, unmapped content types will be rejected with the same `HTTP 415 Unsupported Media Type` response.

: **Field**: `passthrough_behavior`

`payload_format_versions`
: Specifies the format of the payload sent to an integration. Required for HTTP APIs.

: **Field**: `payload_format_version`

`request_parameters`
: For WebSocket APIs, a key-value map specifying request parameters that are passed from the method request to the backend. The key is an integration request parameter name. The associated value is a method request parameter value or static value that must be enclosed within single quotes and pre-encoded as required by the backend. The method request parameter value must match the pattern of `method.request.{location}.{name}`, where `{location}` is **query string, path, or header**; and `{name}` must be a valid and unique method request parameter name.

: **Field**: `request_parameters`

`response_parameters`
: Supported only for HTTP APIs. You use response parameters to transform the HTTP response from a backend integration before returning the response to clients. Specify a key-value map from a selection key to response parameters. The selection key must be a valid HTTP status code within the range of 200-599. Response parameters are a key-value map. The key must match pattern `<action>:<header>.<location>` or `overwrite.statuscode`. The action can be `append`, `overwrite` or `remove`. The value can be a static value, or map to response data, stage variables, or context variables that are evaluated at runtime.

: **Field**: `response_parameters`

`request_templates`
: Represents a map of Velocity templates applied on the request payload based on the value of the Content-Type header sent by the client. The content type value is the key in this map, and the template (as a String) is the value. Supported only for WebSocket APIs.

: **Field**: `request_templates`

`template_selection_expressions`
: The template selection expression for the integration. Supported only for WebSocket APIs.

: **Field**: `template_selection_expression`

`timeout_in_millis`
: Custom timeout between **50** and **29,000** milliseconds for WebSocket APIs and between **50** and **30,000** milliseconds for HTTP APIs. The default timeout is **29 seconds** for WebSocket APIs and **30 seconds** for HTTP APIs.

: **Field**: `timeout_in_millis`

`tls_configs`
: The TLS configuration for a private integration. If you specify a TLS configuration, private integration traffic uses the HTTPS protocol. Supported only for HTTP APIs.

: **Field**: `tls_config`

## Examples

### Test to ensure an integration ID is available

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  its('integration_ids') { should include 'INTEGRATION_ID' }
end
```

### Test to verify the connection type

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  its('connection_types') { should include 'INTERNET' }
end
```

### Test to verify the integration type

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  its('integration_types') { should include 'AWS' }
end
```

### Test to Verify the pass-through behavior

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  its('passthrough_behaviors') { should include 'NEVER' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  it { should exist }
end
```

### not exists

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_integrations(api_id: 'APP_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetIntegrationsResult" %}}
