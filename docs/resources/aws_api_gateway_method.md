---
title: About the aws_api_gateway_method Resource
platform: aws
---

# aws\_api\_gateway\_method

Use the `aws_api_gateway_method` InSpec audit resource to test properties of a single specific APIGateway Method.

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
| http_method | The method's HTTP verb. |
| authorization_type | The method's authorization type. Valid values are NONE for open access, AWS_IAM for using AWS IAM permissions, CUSTOM for using a custom authorizer, or COGNITO_USER_POOLS for using a Cognito user pool. |
| authorizer_id | The identifier of an Authorizer to use on this method. The authorizationType must be CUSTOM. |
| api_key_required | A boolean flag specifying whether a valid ApiKey is required to invoke this method. |
| request_validator_id | The identifier of a RequestValidator for request validation. |
| operation_name | A human-friendly operation identifier for the method. For example, you can assign the operationName of ListPets for the GET /pets method in the PetStore example. |
| request_parameters | A key-value map defining required or optional method request parameters that can be accepted by API Gateway. A key is a method request parameter name matching the pattern of method.request.{location}.{name} , where location is querystring , path , or header and name is a valid and unique parameter name. The value associated with the key is a Boolean flag indicating whether the parameter is required (true ) or optional (false ). The method request parameter names defined here are available in Integration to be mapped to integration request parameters or templates. |
| request_models | A key-value map specifying data schemas, represented by Model resources, (as the mapped value) of the request payloads of given content types (as the mapping key). |
| method_responses (status_code) | The method response's status code. |
| method_responses (response_parameters) | A key-value map specifying required or optional response parameters that API Gateway can send back to the caller.  |
| method_responses (response_models) | Specifies the Model resources used for the response's content-type. Response models are represented as a key/value map, with a content-type as the key and a Model name as the value. |
| method_integration (type) | Specifies an API method integration type. |
| method_integration (http_method) | Specifies the integration's HTTP method type. |
| method_integration (uri) | Specifies Uniform Resource Identifier (URI) of the integration endpoint. |
| method_integration (connection_type) | The type of the network connection to the integration endpoint. The valid value is INTERNET for connections through the public routable internet or VPC_LINK for private connections between API Gateway and a network load balancer in a VPC. The default value is INTERNET. |
| method_integration (connection_id) | The (`id <https://docs.aws.amazon.com/apigateway/api-reference/resource/vpc-link/#id>`__ ) of the VpcLink used for the integration when connectionType=VPC_LINK and undefined, otherwise. |
| method_integration (credentials) | Specifies the credentials required for the integration, if any. For AWS integrations, three options are available. To specify an IAM Role for API Gateway to assume, use the role's Amazon Resource Name (ARN). To require that the caller's identity be passed through from the request, specify the string arn:aws:iam::\*:user/\* . To use resource-based permissions on supported AWS services, specify null. |
| method_integration (request_parameters) | A key-value map specifying request parameters that are passed from the method request to the back end. The key is an integration request parameter name and the associated value is a method request parameter value or static value that must be enclosed within single quotes and pre-encoded as required by the back end. The method request parameter value must match the pattern of method.request.{location}.{name} , where location is querystring , path , or header and name must be a valid and unique method request parameter name. |
| method_integration (request_templates) | Represents a map of Velocity templates that are applied on the request payload based on the value of the Content-Type header sent by the client. The content type value is the key in this map, and the template (as a String) is the value. |
| method_integration (passthrough_behavior) | Specifies how the method request body of an unmapped content type will be passed through the integration request to the back end without transformation. |
| method_integration (content_handling) | Specifies how to handle request payload content type conversions. Supported values are CONVERT_TO_BINARY and CONVERT_TO_TEXT. |
| method_integration (timeout_in_millis) | Custom timeout between 50 and 29,000 milliseconds. The default value is 29,000 milliseconds or 29 seconds. |
| method_integration (cache_namespace) | Specifies a group of related cached parameters. By default, API Gateway uses the resource ID as the cacheNamespace . You can specify the same cacheNamespace across resources to return the same cached data for requests to different resources. |
| method_integration (cache_key_parameters) | A list of request parameters whose values API Gateway caches. To be valid values for cacheKeyParameters , these parameters must also be specified for Method requestParameters. |
| method_integration (integration_responses (status_code)) | Specifies the status code that is used to map the integration response to an existing MethodResponse. |
| method_integration (integration_responses (selection_pattern)) | Specifies the regular expression (regex) pattern used to choose an integration response based on the response from the back end. For example, if the success response returns nothing and the error response returns some string, you could use the .+ regex to match error response. However, make sure that the error response does not contain any newline (\n ) character in such cases. If the back end is an AWS Lambda function, the AWS Lambda function error header is matched. For all other HTTP and AWS back ends, the HTTP status code is matched. |
| method_integration (integration_responses (response_parameters)) | A key-value map specifying response parameters that are passed to the method response from the back end. The key is a method response header parameter name and the mapped value is an integration response header value, a static value enclosed within a pair of single quotes, or a JSON expression from the integration response body. The mapping key must match the pattern of method.response.header.{name} , where name is a valid and unique header name. The mapped non-static value must match the pattern of integration.response.header.{name} or integration.response.body.{JSON-expression} , where name is a valid and unique response header name and JSON-expression is a valid JSON expression without the $ prefix. |
| method_integration (integration_responses (response_templates)) | Specifies the templates used to transform the integration response body. Response templates are represented as a key/value map, with a content-type as the key and a template as the value. |
| method_integration (integration_responses (content_handling)) | Specifies how to handle response payload content type conversions. Supported values are CONVERT_TO_BINARY and CONVERT_TO_TEXT. |
| method_integration (tls_config (insecure_skip_verification)) | Specifies whether or not API Gateway skips verification that the certificate for an integration endpoint is issued by a supported certificate authority . |
| authorization_scopes | A list of authorization scopes configured on the method. |

## Examples

### Ensure a http_method is a GET request.

    describe aws_api_gateway_method(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      its('http_method') { should eq 'GET' }
    end

### Ensure that the connection type is 'INTERNET'.

    describe aws_api_gateway_method(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
        its('method_integration.connection_type') { should eq 'INTERNET' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_method(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_method(rest_api_id: 'dummy', resource_id: 'dummy', http_method: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_api_gateway_method(rest_api_id: 'test', resource_id: 'test', http_method: 'test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `apigateway:client:get_method` action with `Effect` set to `Allow`.
