---
title: About the aws_api_gateway_methods Resource
platform: aws
---

# aws\_api\_gateway\_methods

Use the `aws_api_gateway_methods` InSpec audit resource to test properties of a single plural APIGateway Method.

The AWS::ApiGateway::Method resource creates API Gateway methods that define the parameters and body that clients must send in their requests.

## Syntax

Ensure that a API Gateway method exists.

    describe aws_api_gateway_method(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      it { should exist }
    end

## Parameters

`rest_api_id resource_id http_method` _(required)_

For additional information, see the [AWS APIGateway Method documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-method.html).

## Properties

| Property | Description|
| --- | --- |
| http_methods | The method's HTTP verb. |
| authorization_types | The method's authorization type. Valid values are NONE for open access, AWS_IAM for using AWS IAM permissions, CUSTOM for using a custom authorizer, or COGNITO_USER_POOLS for using a Cognito user pool. |
| authorizer_ids | The identifier of an Authorizer to use on this method. The authorizationType must be CUSTOM. |
| api_key_required | A boolean flag specifying whether a valid ApiKey is required to invoke this method. |
| request_validator_ids | The identifier of a RequestValidator for request validation. |
| operation_names | A human-friendly operation identifier for the method. For example, you can assign the operationName of ListPets for the GET /pets method in the PetStore example. |
| request_parameters | A key-value map defining required or optional method request parameters that can be accepted by API Gateway. A key is a method request parameter name matching the pattern of method.request.{location}.{name} , where location is querystring , path , or header and name is a valid and unique parameter name. The value associated with the key is a Boolean flag indicating whether the parameter is required (true ) or optional (false ). The method request parameter names defined here are available in Integration to be mapped to integration request parameters or templates. |
| request_models | A key-value map specifying data schemas, represented by Model resources, (as the mapped value) of the request payloads of given content types (as the mapping key). |
| method_responses | Gets a method response associated with a given HTTP status code. |
| method_integrations | Gets the method's integration responsible for passing the client-submitted request to the back end and performing necessary transformations to make the request compliant with the back end. |
| authorization_scopes | A list of authorization scopes configured on the method. |

## Examples

### Ensure a http method is a GET request.

    describe aws_api_gateway_methods(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      its('http_method') { should include 'GET' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_methods(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_methods(rest_api_id: 'dummy', resource_id: 'dummy', http_method: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the method name is available.

    describe aws_api_gateway_methods(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `apigateway:client:get_methods` action with `Effect` set to `Allow`.
