---
title: About the aws_api_gateway_model Resource
platform: aws
---

# aws_api_gateway_model

Use the `aws_api_gateway_model` InSpec audit resource to test properties of the singular resource of AWS APIGateway Model.

The AWS::ApiGateway::Model resource defines the structure of a request or response payload for an API method.

## Syntax

Ensure that the model exists.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The RestApi identifier under which the Model exists.

`model_name` _(required)_

The name of the model as an identifier.

For additional information, see the [AWS documentation on AWS APIGateway Model](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-model.html).

## Properties

| Property | Description | 
| :---: | :--- |
| id | The identifier for the model resource. |
| name | The name of the model. Must be an alphanumeric string. |
| description | The description of the model. |
| schema | The schema for the model. For application/json models, this should be JSON schema draft 4 model. |
| content_type | The content-type for the model. |

## Examples

### Ensure an id is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('id') { should eq 'MODEL_ID' }
    end

### Ensure a name is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('name') { should eq 'MODEL_NAME' }
    end

### Ensure a description is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('description') { should eq 'MODEL_DESCRIPTION' }
    end

### Ensure a content type is available.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      its('content_type') { should eq 'CONTENT_TYPE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_model(rest_api_id: 'REST_API_ID', model_name: 'MODEL_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ApiGateway:Client:Model` action with `Effect` set to `Allow`.