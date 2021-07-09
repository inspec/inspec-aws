---
title: About the aws_api_gateway_restapis Resource
platform: aws
---

# aws\_api\_gateway\_restapis

Use the `aws_api_gateway_restapis` InSpec audit resource to test properties of multiple AWS API Gateway REST APIs.

The AWS::ApiGateway::RestApi resource creates a REST API.

## Syntax

Ensure the rest api exists.

    describe aws_api_gateway_restapis do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS API Gateway REST API documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-restapi.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The API's identifier. This identifier is unique across all of your APIs in API Gateway. |
| names | The API's name. |
| descriptions | The API's description. |
| created_dates | The timestamp when the API was created. |
| versions | A version identifier for the API. |
| warnings | The warning messages reported when `failonwarnings` is turned on during API import. |
| binary_media_types | The list of binary media types supported by the REST API. By default, the REST API supports only UTF-8-encoded text payloads. |
| minimum_compression_sizes | A nullable integer that is used to enable compression (with non-negative between 0 and 10485760 (10M) bytes, inclusive) or disable compression (with a null value) on an API. When compression is enabled, compression or decompression is not applied on the payload if the payload size is smaller than this value. Setting it to zero allows compression for any payload size. |
| api_key_sources | The source of the API key for metering requests according to a usage plan. Valid values are `HEADER` and `AUTHORIZER`. |
| endpoint_configurations | The endpoint configuration of this REST API showing the endpoint types of the API. |
| policies | A stringified JSON policy document that applies to this REST API regardless of the caller and method configuration. |
| tags | The collection of tags. Each tag element is associated with a given resource. |
| disable_execute_api_endpoints | Specifies whether clients can invoke your API by using the default execute-api endpoint. |

## Examples

### Ensure a specific REST API exists.

    describe aws_api_gateway_restapis do
      its('names') { should include 'API_NAME' }
    end

### Ensure that `HEADER` is a source for a REST API key.

    describe aws_api_gateway_restapis do
        its('api_key_source') { should include 'HEADER' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_restapis do
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `apigateway:client:get_rest_apis` action with `Effect` set to `Allow`.
