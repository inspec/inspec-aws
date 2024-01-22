+++
title = "aws_api_gateway_v2_integration resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_v2_integration"
identifier = "inspec/resources/aws/aws_api_gateway_v2_integration resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_integration` InSpec audit resource to test the properties of a specific AWS API Gateway V2 integration.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 Integration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-integration.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the integration exists.

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API identifier.

`integration_id` _(required)_
: The integration ID.

## Properties

`api_gateway_managed`
: Specifies whether API Gateway manages integration.

`connection_id`
: The VPC link ID for a private integration. Supported only for HTTP APIs.

`connection_type`
: The network connection type to the integration endpoint. Specify `INTERNET` for connections through the public routable internet or `VPC_LINK` for private connections between API Gateway and resources in a VPC. The default value is `INTERNET`.

`content_handling_strategy`
: Supported only for WebSocket APIs. Specifies how to handle response payload content type conversions. Supported values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following behaviors:

- `CONVERT_TO_BINARY`: Converts a response payload from a Base64-encoded string to the corresponding binary blob.
- `CONVERT_TO_TEXT`: Converts a response payload from a binary blob to a Base64-encoded string.

If this property is not defined, the response payload will be passed through from the integration response to the route response or method response without modification.

`credentials_arn`
: Specifies the credentials required for the integration, if any.

`description`
: The description of an integration.

`integration_id`
: The identifier of an integration.

`integration_method`
: Specifies the integration's HTTP method type.

`integration_response_selection_expression`
: The integration response selection expression for the integration. Supported only for WebSocket APIs.

`integration_subtype`
: Supported only for HTTP API `AWS_PROXY` integrations. Specifies the AWS service action to invoke.

`integration_type`
: The integration type. One of the following:

- `AWS`: for integrating the route or method request with an AWS service action, including the Lambda function-invoking action. With the Lambda function-invoking action, this is referred to as the Lambda custom integration. With any other AWS service action, this is known as AWS integration. Supported only for WebSocket APIs.
- `AWS_PROXY`: for integrating the route or method request with a Lambda function or other AWS service action. This integration is also referred to as a Lambda proxy integration.
- `HTTP`: for integrating the route or method request with an HTTP endpoint. This integration is also referred to as the HTTP custom integration. Supported only for WebSocket APIs.
- `HTTP_PROXY`: for integrating the route or method request with an HTTP endpoint, with the client request passed through as-is. This is also referred to as `HTTP proxy` integration.
- `MOCK`: for integrating the route or method request with API Gateway as a **loopback** endpoint without invoking any backend. Supported only for WebSocket APIs.

`integration_uri`
: For a Lambda integration, specify the URI of a Lambda function.

For an HTTP integration, specify a fully-qualified URL.
  
For an HTTP API private integration, specify the ARN of an Application Load Balancer listener, Network Load Balancer listener, or AWS Cloud Map service. If you specify the ARN of an AWS Cloud Map service, API Gateway uses `DiscoverInstances` to identify resources. You can use query parameters to target specific resources.

`passthrough_behavior`
: Specifies the pass-through behavior for incoming requests based on the `Content-Type` header in the request, and the available mapping templates specified as the `requestTemplates` property on the `Integration` resource. There are three valid values: `WHEN_NO_MATCH`, `WHEN_NO_TEMPLATES`, and `NEVER`. Supported only for WebSocket APIs.

- `WHEN_NO_MATCH` passes the request body for unmapped content types to the integration backend without transformation.
- `NEVER` rejects unmapped content types with an `HTTP 415 Unsupported Media Type` response.
- `WHEN_NO_TEMPLATES` allows pass-through when the integration has no content types mapped to templates. However, if at least one content type defined, unmapped content types will be rejected with the same `HTTP 415 Unsupported Media Type` response.

`payload_format_version`
: Specifies the format of the payload sent to an integration. Required for HTTP APIs. For HTTP APIs, supported values for Lambda proxy integrations are `1.0` and `2.0`. For all other integrations, `1.0` is the only supported value.

`request_parameters`
: For WebSocket APIs, a key-value map specifies request parameters passed from the method request to the backend. The key is an integration request parameter name. The associated value is a method request parameter value or static value that must be enclosed within single quotes and pre-encoded as required by the backend. The method request parameter value must match the pattern of `method.request.{location}.{name}`, where `{location}` is **query string, path, or header**; and `{name}` must be a valid and unique method request parameter name.

`response_parameters`
: Supported only for HTTP APIs. You use response parameters to transform the HTTP response from a backend integration before returning the response to clients. Specify a key-value map from a selection key to response parameters. The selection key must be a valid HTTP status code within the range of 200-599. Response parameters are a key-value map. The key must match pattern `<action>:<header>.<location>` or `overwrite.statuscode`. The action can be `append`, `overwrite` or `remove`. The value can be a static value, or map to response data, stage variables, or context variables that are evaluated at runtime.

`request_templates`
: Represents a map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. The content type value is the key in this map, and the template (as a String) is the value. Supported only for WebSocket APIs.

`template_selection_expression`
: The template selection expression for the integration. Supported only for WebSocket APIs.

`timeout_in_millis`
: Custom timeout between **50** and **29,000 milliseconds** for WebSocket APIs and between **50** and **30,000 milliseconds** for HTTP APIs. The default timeout is **29 seconds** for WebSocket APIs and **30 seconds** for HTTP APIs.

`tls_config.server_name_to_verify`
: The TLS configuration for a private integration. If you specify a TLS configuration, private integration traffic uses the HTTPS protocol. Supported only for HTTP APIs. If you specify a server name, API Gateway uses it to verify the hostname on the integration's certificate. The server name is also included in the TLS handshake to support Server Name Indication (SNI) or virtual hosting.

## Examples

### Test to ensure an integration ID is available

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('integration_id') { should eq 'INTEGRATION_ID' }
end
```

### Verify the connection type

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('connection_type') { should eq 'INTERNET' }
end
```

### Verify the integration type

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('integration_type') { should eq 'AWS' }
end
```

### Verify the pass-through behavior

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  its('passthrough_behavior') { should eq 'NEVER' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  it { should exist }
end
```

### not exist

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_integration(api_id: 'APP_ID', integration_id: 'INTEGRATION_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetIntegrationResult" %}}
