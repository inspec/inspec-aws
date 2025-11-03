+++
title = "aws_api_gateway_v2_apis resource"

draft = false


[menu.aws]
title = "aws_api_gateway_v2_apis"
identifier = "inspec/resources/aws/aws_api_gateway_v2_apis resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_v2_apis` InSpec audit resource to test properties of multiple AWS API Gateway V2 APIs.

For additional information, including parameters and properties, see the [AWS documentation on AWS APIGatewayV2 API](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigatewayv2-api.html).

## Syntax

Ensure the API exists.

```ruby
describe aws_api_gateway_v2_apis do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`api_endpoints`
: The URI of the API, of the form `{api-id}.execute-api.{region}.amazonaws.com`. The stage name is typically appended to this URI to form a complete path to a deployed API stage.

: **Field**: `api_endpoint`

`api_gateway_managed`
: Specifies whether an API is managed by API Gateway. You cannot update or delete a managed API by using API Gateway. A managed API can be deleted only through the tooling or service that created it.

: **Field**: `api_gateway_managed`

`api_ids`
: The API ID.

: **Field**: `api_id`

`api_key_selection_expressions`
: An API key selection expression. Supported only for WebSocket APIs.

: **Field**: `api_key_selection_expression`

`cors_configurations`
: A CORS configuration. Supported only for HTTP APIs.

: **Field**: `cors_configuration`

`created_dates`
: The timestamp when the API is created.

: **Field**: `created_date`

`descriptions`
: The description of the API.

: **Field**: `description`

`disable_schema_validations`
: Avoid validating models when creating a deployment. Supported only for WebSocket APIs.

: **Field**: `disable_schema_validation`

`disable_execute_api_endpoints`
: Specifies whether clients can invoke your API using the default execute-api endpoint. By default, clients can invoke your API with the default `https://{api_id}.execute-api.{region}.amazonaws.com` endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint.

: **Field**: `disable_execute_api_endpoint`

`import_infos`
: The validation information during API import. Supported only for HTTP APIs.

: **Field**: `import_info`

`names`
: The name of the API.

: **Field**: `name`

`protocol_types`
: The API protocol. Valid values are WEBSOCKET or HTTP.

: **Field**: `protocol_type`

`route_selection_expressions`
: The route selection expression for the API. For HTTP APIs, the `routeSelectionExpression` must be `${request.method} ${request.path}`. If not provided, this will be the default for HTTP APIs. This property is required for WebSocket APIs.

: **Field**: `route_selection_expression`

`tags`
: A collection of tags associated with the API.

: **Field**: `tags`

`versions`
: A version identifier for the API.

: **Field**: `version`

`warnings`
: The warning messages are reported when `failonwarnings` is turned on during API import. The `failonwarnings` specifies to roll back the API creation when a warning is encountered. By default, API creation continues if a warning is encountered.

: **Field**: `warnings`

## Examples

### Test to ensure an API ID is available

```ruby
describe aws_api_gateway_v2_apis do
  its('api_ids') { should include 'REST_API_ID' }
end
```

### Test to ensure an API name is available

```ruby
describe aws_api_gateway_v2_apis do
  its('names') { should include 'REST_API_NAME' }
end
```

### Test to ensure a protocol type is `HTTP`

```ruby
describe aws_api_gateway_v2_apis do
  its('protocol_types') { should include 'HTTP' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_v2_apis do
  it { should exist }
end
```

Use `should_not` to test that the entity does not exist.

```ruby
describe aws_api_gateway_v2_apis do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGatewayv2:Client:GetApisResponse" %}}
