---
title: About the aws_api_gateway_response Resource
platform: aws
---

# aws_api_gateway_response

Use the `aws_api_gateway_response` InSpec audit resource to test properties of the singular resource of AWS APIGateway GatewayResponse.

The AWS::ApiGateway::GatewayResponse resource creates a gateway response for your API.

## Syntax

Ensure that the response exists.

    describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The string identifier of the associated RestApi.

`response_type` _(required)_

The response type of the associated GatewayResponse.

For additional information, see the [AWS documentation on AWS APIGateway GatewayResponse](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-gatewayresponse.html).

## Properties

| Property | Description | 
| :---: | :--- |
| response_type | The response type of the associated GatewayResponse. |
| status_code | The HTTP status code for this GatewayResponse. |
| response_parameters | Response parameters (paths, query strings and headers) of the GatewayResponse as a string-to-string map of key-value pairs. |
| response_templates | Response templates of the GatewayResponse as a string-to-string map of key-value pairs. |
| default_response | A Boolean flag to indicate whether this GatewayResponse is the default gateway response (true ) or not (false ). |

## Examples

### Ensure a response type is 'DEFAULT_4XX'.

    describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'DEFAULT_4XX') do
      its('response_type') { should eq 'DEFAULT_4XX' }
    end

### Ensure a status code is `200`.

    describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
      its('status_code') { should eq '200' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_response(rest_api_id: 'REST_API_ID', response_type: 'RESPONSE_TYPE') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:GatewayResponse` action with `Effect` set to `Allow`.