---
title: About the aws_api_gateway_restapi Resource
platform: aws
---

# aws\_api\_gateway\_restapi

Use the `aws_api_gateway_restapi` InSpec audit resource to test properties of a single specific AWS ApiGateway RestApi.

The AWS::ApiGateway::RestApi resource creates a REST API.

## Syntax

Ensure the rest api exists.

    describe aws_api_gateway_restapi(rest_api_id: "value") do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

For additional information, see the [AWS ApiGateway RestApi documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-restapi.html).

## Properties

| Property | Description|
| --- | --- |
| id | The API's identifier. This identifier is unique across all of your APIs in API Gateway. |
| name | The API's name. |
| description | The API's description. |
| created_date | The timestamp when the API was created. |
| version | A version identifier for the API. |
| warnings | The warning messages reported when failonwarnings is turned on during API import. |
| binary_media_types | The list of binary media types supported by the RestApi . By default, the RestApi supports only UTF-8-encoded text payloads. |
| minimum_compression_size | A nullable integer that is used to enable compression (with non-negative between 0 and 10485760 (10M) bytes, inclusive) or disable compression (with a null value) on an API. When compression is enabled, compression or decompression is not applied on the payload if the payload size is smaller than this value. Setting it to zero allows compression for any payload size. |
| api_key_source | The source of the API key for metering requests according to a usage plan. Valid values are HEADER and AUTHORIZER. |
| endpoint_configuration (types) | A list of endpoint types of an API ( RestApi ) or its custom domain name ( DomainName ). For an edge-optimized API and its custom domain name, the endpoint type is "EDGE" . For a regional API and its custom domain name, the endpoint type is REGIONAL . For a private API, the endpoint type is PRIVATE. |
| endpoint_configuration (vpc_endpoint_ids) | A list of VpcEndpointIds of an API ( RestApi ) against which to create Route53 ALIASes. It is only supported for PRIVATE endpoint type. |
| policy | A stringified JSON policy document that applies to this RestApi regardless of the caller and Method configuration. |
| tags | The collection of tags. Each tag element is associated with a given resource. |
| disable_execute_api_endpoint | Specifies whether clients can invoke your API by using the default execute-api endpoint. By default, clients can invoke your API with the default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To require that clients use a custom domain name to invoke your API, disable the default endpoint. |

## Examples

### Ensure the rest api exists.

    describe aws_api_gateway_restapi(rest_api_id: "value") do
      its('name') { should eq 'api_name' }
    end

### Ensure that the api_key_source has the HEADER.

    describe aws_api_gateway_restapi(rest_api_id: "value") do
        its('api_key_source') { should eq 'HEADER' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_restapi(rest_api_id: "value") do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_restapi(rest_api_id: "dummy") do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_api_gateway_restapi(rest_api_id: "value") do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `apigateway:client:get_rest_api` action with `Effect` set to `Allow`.
