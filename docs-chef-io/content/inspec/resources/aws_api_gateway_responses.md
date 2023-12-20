+++
title = "aws_api_gateway_responses Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_api_gateway_responses"
identifier = "inspec/resources/aws/aws_api_gateway_responses Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_api_gateway_responses` Chef InSpec audit resource to test properties of multiple AWS API Gateway gateway responses.

The `AWS::ApiGateway::GatewayResponse` resource creates a gateway response for your API.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::APIGateway::GatewayResponse` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-gatewayresponse.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a response exists.

```ruby
describe aws_api_gateway_responses(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

## Parameters

`rest_api_id` _(required)_

: The string identifier of the associated REST API.

## Properties

`response_type`
: The response type of the associated GatewayResponse.

: **Field**: `response_type`

`status_code`
: The HTTP status code for this GatewayResponse.

: **Field**: `status_code`

`response_parameters`
: Response parameters (paths, query strings and headers) of the GatewayResponse as a string-to-string map of key-value pairs.

: **Field**: `response_parameters`

`response_templates`
: Response templates of the GatewayResponse as a string-to-string map of key-value pairs.

: **Field**: `response_templates`

`default_response`
: A Boolean flag to indicate whether this GatewayResponse is the default gateway response (true ) or not (false ).

: **Field**: `default_response`

## Examples

**Ensure a response type is `DEFAULT_4XX`.**

```ruby
describe aws_api_gateway_responses(rest_api_id: 'REST_API_ID') do
  its('response_types') { should include 'DEFAULT_4XX' }
end
```

**Ensure a status code is `200`.**

```ruby
describe aws_api_gateway_responses(rest_api_id: 'REST_API_ID') do
  its('status_codes') { should include '200' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_api_gateway_responses(rest_api_id: 'REST_API_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_api_gateway_responses(rest_api_id: 'REST_API_ID') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="APIGateway:Client:GatewayResponses" %}}
