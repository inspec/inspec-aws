+++
title = "aws_api_gateway_request_validator Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_request_validator"
identifier = "inspec/resources/aws/aws_api_gateway_request_validator Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_request_validator` InSpec audit resource to test the properties of a single API Gateway request validator.

The AWS::ApiGateway::RequestValidator resource sets up basic validation rules for incoming integration requests to your API.

For additional information, including details on parameters and properties, see the [AWS APIGateway RequestValidator documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-requestvalidator.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that an API Gateway request validator exists.

```ruby
describe aws_api_gateway_request_validator(rest_api_id: 'API_ID', request_validator_id: 'API_REQUEST_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated RestApi entity.

`request_validator_id` _(required)_

: The identifier of the RequestValidator to be retrieved.

## Properties

`id`
: The identifier of this RequestValidator.

`name`
: The name of this RequestValidator.

`validate_request_body`
: A Boolean flag to indicate whether to validate a request body according to the configured model schema for the method (`true`) or not (`false`).

`validate_request_parameters`
: A Boolean flag to indicate whether to validate request parameters (`true`) or not (`false`).

## Examples

### Test to ensure a request validator ID is present

```ruby
describe aws_api_gateway_request_validator(rest_api_id: 'API_ID', request_validator_id: 'API_REQUEST_ID') do
  its('id') { should eq 'REQUEST_ID' }
end
```

### Test to ensure that the request body is 'true'

```ruby
describe aws_api_gateway_request_validator(rest_api_id: 'API_ID', request_validator_id: 'API_REQUEST_ID') do
    its('validate_request_body') { should eq true }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_request_validator(rest_api_id: 'API_ID', request_validator_id: 'API_REQUEST_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_request_validator(rest_api_id: 'API_ID', request_validator_id: 'API_REQUEST_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:RequestValidator" %}}
