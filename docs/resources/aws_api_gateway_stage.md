---
title: About the aws_api_gateway_stage Resource
platform: aws
---

# aws\_api\_gateway\_stage

Use the `aws_api_gateway_stage` InSpec audit resource to test properties of the singular resource of AWS ApiGateway Stage.

The AWS::ApiGateway::Stage resource deploys an API Gateway RestApi resource to a stage so that clients can call the API over the internet. The stage acts as an environment.

## Syntax

Ensure that the stage exists.

    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The string identifier of the associated RestApi.

`stage_name` _(required)_

The identifier of the stage resource to get information about.

For additional information, see the [AWS ApiGateway Stage documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html).

## Properties

| Property | Description|
| --- | --- |
| deployment_id | The identifier for the deployment attached to stage resource. |
| description | The description for the stage resource. |
| created_date | The date and time that the stage resource was created. |
| stage_name | The name for the stage resource. |
| client_certificate_id | The client certificate identifier for the stage resource. |

There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/apigateway/api-reference/resource/stage/)

## Examples

### Ensure that the stage name exists.

    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
      its('stage_name') { should eq 'STAGE_NAME' }
    end

### Ensure that the client certificate ID exists.

    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
        its('client_certificate_id') { should eq 'CLIENT_CETIFICATE_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_api_gateway_stage(rest_api_id: 'REST_API_ID', stage_name: 'STAGE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:Stage` action with `Effect` set to `Allow`.
