---
title: About the aws_api_gateway_methods Resource
platform: aws
---

# aws_api_gateway_methods

Use the `aws_api_gateway_methods` InSpec audit resource to test properties of multiple API Gateway methods.

The `AWS::ApiGateway::Method` resource creates API Gateway methods that define the parameters and body that clients must send in their requests.

## Syntax

Ensure that a API Gateway method exists.

    describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The ID of the RestApi resource in which API Gateway creates the method.

`resource_id` _(required)_

The ID of an API Gateway resource. For root resource methods, specify the RestApi root resource ID, such as `{ "Fn::GetAtt": ["MyRestApi", "RootResourceId"] }`.

`http_method` _(required)_

The HTTP method that clients use to call this method.

For additional information, see the [AWS documentation on the `AWS::ApiGateway::Method` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-method.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| http_methods | The HTTP method that clients use to call this method. | http_method |
| authorization_types | The method's authorization type. Valid values are `NONE` for open access, `AWS_IAM` for using AWS IAM permissions, `CUSTOM` for using a custom authorizer, or `COGNITO_USER_POOLS` for using a Cognito user pool. | authorization_type |
| authorizer_ids | The identifier of an Authorizer to use on this method. The authorizationType must be `CUSTOM`. | authorizer_id |
| api_key_required | A boolean flag specifying whether a valid ApiKey is required to invoke this method. | api_key_required |
| request_validator_ids | The identifier of a `RequestValidator` for request validation. | request_validator_id |
| operation_names | A human-friendly operation identifier for the method. | operation_name |
| request_parameters | A key-value map defining required or optional method request parameters that can be accepted by API Gateway. <br>A key is a method request parameter name matching the pattern of `method.request.{location}.{name}`, where the `location` is querystring, path, or header, and `name` is a valid and unique parameter name. <br>The value associated with the key is a Boolean flag indicating whether the parameter is required (`true`) or optional (`false`). <br>The method request parameter names defined here are available in `Integration` to be mapped to integration request parameters or templates. | request_parameters |
| request_models | A key-value map specifying data schemas, represented by `Model` resources, (as the mapped value) of the request payloads of given content types (as the mapping key). | request_models |
| method_responses | Gets a method response associated with a given HTTP status code. | method_responses |
| method_integrations | Gets the method's integration responsible for passing the client-submitted request to the back end and performing necessary transformations to make the request compliant with the back end. | method_integration |
| authorization_scopes | A list of authorization scopes configured on the method. | authorization_scopes |

## Examples

### Ensure an HTTP method is a GET request.

    describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
      its('http_method') { should include 'GET' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_api_gateway_methods(rest_api_id: 'REST_API_ID', resource_id: 'RESOURCE_ID', http_method: 'HTTP_METHOD') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:Methods` action with `Effect` set to `Allow`.
