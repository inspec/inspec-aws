+++
title = "aws_api_gateway_response Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_response"
identifier = "inspec/resources/aws/aws_api_gateway_response Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_response` Chef InSpec audit resource to test properties of a single AWS API Gateway gateway response.

The `AWS::ApiGateway::GatewayResponse` resource creates a gateway response for your API.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::APIGateway::GatewayResponse` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-gatewayresponse.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the response exists.

```ruby
describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated REST API.

`response_type` _(required)_

: The response type of the associated gateway response.

## Properties

`response_type`
: The response type of the associated GatewayResponse.

`status_code`
: The HTTP status code for this GatewayResponse.

`response_parameters`
: Response parameters (paths, query strings and headers) of the GatewayResponse as a string-to-string map of key-value pairs.

`response_templates`
: Response templates of the GatewayResponse as a string-to-string map of key-value pairs.

`default_response`
: A Boolean flag to indicate whether this GatewayResponse is the default gateway response (true ) or not (false ).

## Examples

**Ensure a response type is 'DEFAULT_4XX'.**

```ruby
describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'DEFAULT_4XX') do
  its('response_type') { should eq 'DEFAULT_4XX' }
end
```

**Ensure a status code is `200`.**

```ruby
describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
  its('status_code') { should eq '200' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:GatewayResponse" %}}
