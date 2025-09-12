+++
title = "aws_api_gateway_methods resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_api_gateway_methods"
identifier = "inspec/resources/aws/aws_api_gateway_methods resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_methods` InSpec audit resource to test properties of multiple API Gateway methods.

The AWS::ApiGateway::Method resource creates API Gateway methods that define the parameters and body that clients must send in their requests.

For additional information, including details on parameters and properties, see the [AWS APIGateway Method documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-method.html).

## Syntax

Ensure that a API Gateway method exists.

```ruby
describe aws_api_gateway_method(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The ID of the RestApi resource in which API Gateway creates the method.

`resource_id` _(required)_

: The ID of an API Gateway resource. For root resource methods, specify the RestApi root resource ID, such as `{ "Fn::GetAtt": ["MyRestApi", "RootResourceId"] }`.

`http_method` _(required)_

: The HTTP method that clients use to call this method.

## Properties

`http_methods`
: The HTTP method that clients use to call this method.

`authorization_types`
: The method's authorization type. Valid values are `NONE` for open access, `AWS_IAM` for using AWS IAM permissions, `CUSTOM` for using a custom authorizer, or `COGNITO_USER_POOLS` for using a Cognito user pool.

`authorizer_ids`
: The identifier of an Authorizer to use on this method. The authorizationType must be `CUSTOM`.

`api_key_required`
: A boolean flag specifying whether a valid ApiKey is required to invoke this method.

`request_validator_ids`
: The identifier of a `RequestValidator` for request validation.

`operation_names`
: A human-friendly operation identifier for the method.

`request_parameters`
: A key-value map defining required or optional method request parameters that can be accepted by API Gateway. <br>A key is a method request parameter name matching the pattern of `method.request.{location}.{name}`, where the `location` is querystring, path, or header, and `name` is a valid and unique parameter name. <br>The value associated with the key is a Boolean flag indicating whether the parameter is required (`true`) or optional (`false`). <br>The method request parameter names defined here are available in `Integration` to be mapped to integration request parameters or templates.

`request_models`
: A key-value map specifying data schemas, represented by `Model` resources, (as the mapped value) of the request payloads of given content types (as the mapping key).

`method_responses`
: Gets a method response associated with a given HTTP status code.

`method_integrations`
: Gets the method's integration responsible for passing the client-submitted request to the back end and performing necessary transformations to make the request compliant with the back end.

`authorization_scopes`
: A list of authorization scopes configured on the method.

## Examples

**Ensure an HTTP method is a GET request.**

```ruby
describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
  its('http_method') { should include 'GET' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the method name is available.

```ruby
describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:Methods" %}}
