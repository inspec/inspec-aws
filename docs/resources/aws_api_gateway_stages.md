---
title: About the aws_api_gateway_stages Resource
platform: aws
---

# aws\_api\_gateway\_stages

Use the `aws_api_gateway_stages` InSpec audit resource to test properties of multiple AWS API Gateway stages.

The 'AWS::ApiGateway::Stage' resource deploys an API Gateway REST API resource to a stage so that clients can call the API over the internet. The stage acts as an environment.

## Syntax

Ensure that the stage exists.

    describe aws_api_gateway_stages(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The ID of the REST API resource that you're deploying with this stage.

For additional information, see the [AWS API Gateway stage Stage documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-stage.html).

## Properties

| Property | Description|
| --- | --- |
| deployment_ids | The identifier for the deployment attached to stage resource. |
| descriptions | The description for the stage resource. |
| created_dates | The date and time that the stage resource was created. |
| stage_names | The name for the stage resource. |

## Examples

### Ensure that the stage name exists.

    describe aws_api_gateway_stages(rest_api_id: 'REST_API_ID') do
      its('stage_names') { should include 'STAGE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_stages(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_stages(rest_api_id: 'REST_API_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the stage is available.

    describe aws_api_gateway_stages(rest_api_id: 'REST_API_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client::Stages` action with `Effect` set to `Allow`.
