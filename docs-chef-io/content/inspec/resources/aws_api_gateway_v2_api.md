+++
title = "aws_api_gateway_v2_api resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_v2_api"
identifier = "inspec/resources/aws/aws_api_gateway_v2_api resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_api` InSpec audit resource to test the properties of a single specific AWS API Gateway V2 API.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 API](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-api.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Ensure that the API exists.

```ruby
describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`api_id` _(required)_
: The API ID.

## Properties

`api_endpoint`
: The URI of the API, of the form `{api-id}.execute-api.{region}.amazonaws.com`. The stage name is typically appended to this URI to form a complete path to a deployed API stage.

`api_gateway_managed`
: Specifies whether an API is managed by API Gateway. You cannot update or delete a managed API by using API Gateway. A managed API can be deleted only through the tooling or service that created it.

`api_id`
: The API ID.

`api_key_selection_expression`
: An API key selection expression. Supported only for WebSocket APIs.

`cors_configuration`
: A CORS configuration. Supported only for HTTP APIs.

`cors_configuration.allow_credentials`
: Specifies whether credentials are included in the CORS request. Supported only for HTTP APIs.

`cors_configuration.allow_headers`
: Specifies whether credentials are included in the CORS request. Supported only for HTTP APIs.

`cors_configuration.allow_methods`
: Represents a collection of allowed HTTP methods. Supported only for HTTP APIs.

`cors_configuration.allow_origins`
: Represents a collection of allowed origins. Supported only for HTTP APIs.

`cors_configuration.expose_headers`
: Represents a collection of exposed headers. Supported only for HTTP APIs.

`cors_configuration.max_age`
: The number of seconds that the browser should cache preflight request results. Supported only for HTTP APIs.

`created_date`
: The timestamp when the API is created.

`description`
: The description of the API.

`disable_schema_validation`
: Avoid validating models when creating a deployment. Supported only for WebSocket APIs.

`disable_execute_api_endpoint`
: Specifies whether clients can invoke your API using the default execute-api endpoint. By default, clients can invoke your API with the default `https://{api_id}.execute-api.{region}.amazonaws.com` endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint.

`import_info`
: The validation information during API import. Supported only for HTTP APIs.

`name`
: The name of the API.

`protocol_type`
: The API protocol. Valid values are WEBSOCKET or HTTP.

`route_selection_expression`
: The route selection expression for the API. For HTTP APIs, the `routeSelectionExpression` must be `${request.method} ${request.path}`. If not provided, this defaults for HTTP APIs. This property is required for WebSocket APIs.

`tags`
: A collection of tags associated with the API.

`version`
: A version identifier for the API.

`warnings`
: The warning messages are reported when `failonwarnings` is turned on during API import. The `failonwarnings` specifies to roll back the API creation when a warning is encountered. By default, API creation continues if a warning is encountered.

## Examples

### Test to ensure an API ID is available

```ruby
describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
  its('api_id') { should eq 'REST_API_ID' }
end
```

### Test to ensure an API name is available

```ruby
describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
  its('name') { should eq 'REST_API_NAME' }
end
```

### Test to ensure a protocol type is `HTTP`

```ruby
describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
  its('protocol_type') { should eq 'HTTP' }
end
```

## Matchers

{{% inspec_matchers_link %}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_api(api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="APIGatewayv2:Client:GetApiResponse" %}}
