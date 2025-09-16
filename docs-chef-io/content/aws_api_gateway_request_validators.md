+++
title = "aws_api_gateway_request_validators resource"

draft = false


[menu.aws]
title = "aws_api_gateway_request_validators"
identifier = "inspec/resources/aws/aws_api_gateway_request_validators resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_request_validators` Chef InSpec audit resource to the test properties of multiple AWS API Gateway request validators.

The AWS::ApiGateway::RequestValidator resource sets up basic validation rules for incoming requests to your API.

For additional information, including details on parameters and properties, see the [AWS APIGateway RequestValidator documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-requestvalidator.html).

## Syntax

Ensure that an API Gateway request validator exists.

```ruby
describe aws_api_gateway_request_validators(rest_api_id: 'API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated RestApi.

## Properties

`id`
: The identifier of this RequestValidator.

: **Field**: `id`

`name`
: The name of this RequestValidator.

: **Field**: `name`

`validate_request_body`
: A Boolean flag to indicate whether to validate a request body according to the configured model schema.

: **Field**: `validate_request_body`

`validate_request_parameters`
: A Boolean flag to indicate whether to validate request parameters (`true`) or not (`false`).

: **Field**: `validate_request_parameters`

## Examples

### Test to ensure a request validator ID is present

```ruby
describe aws_api_gateway_request_validators(rest_api_id: 'API_ID') do
  its('ids') { should include 'REQUEST_ID' }
end
```

### Test to ensure the request body is 'true'

```ruby
describe aws_api_gateway_request_validators(rest_api_id: 'API_ID') do
    its('validate_request_bodies') { should include true }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_method(rest_api_id: 'API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_method(rest_api_id: 'API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_api_gateway_method(rest_api_id: 'API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:RequestValidators" %}}
