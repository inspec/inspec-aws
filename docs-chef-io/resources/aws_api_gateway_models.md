---
title: About the aws_api_gateway_models Resource
platform: aws
---

# aws_api_gateway_models

Use the `aws_api_gateway_models` InSpec audit resource to test properties of the plural resource of AWS APIGateway Model.

The AWS::ApiGateway::Model resource defines the structure of a request or response payload for an API method.

## Syntax

Ensure that the model exists.

    describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The RestApi identifier under which the Model exists.

For additional information, see the [AWS documentation on AWS APIGateway Model](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-model.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| ids | The identifier for the model resource. | id |
| names | The name of the model. Must be an alphanumeric string. | name |
| descriptions | The description of the model. | description |
| schemas | The schema for the model. For application/json models, this should be JSON schema draft 4 model. | schema |
| content_types | The content-type for the model. | content_type |

## Examples

### Ensure an id is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('ids') { should include 'MODEL_ID' }
    end

### Ensure a name is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('names') { should include 'MODEL_NAME' }
    end

### Ensure a description is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('descriptions') { should include 'MODEL_DESCRIPTION' }
    end

### Ensure a content type is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('content_types') { should include 'CONTENT_TYPE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_models(rest_api_id: 'REST_API_ID') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ApiGateway:Client:Models` action with `Effect` set to `Allow`.