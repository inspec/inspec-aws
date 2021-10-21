---
title: About the aws_api_gateway_deployments Resource
platform: aws
---

# aws\_api\_gateway\_deployments

Use the `aws_api_gateway_deployments` InSpec audit resource to test properties of multiple AWS ApiGateway Deployments.

The AWS::ApiGateway::Deployment resource deploys an API Gateway RestAPI resource to a stage so that clients can call the API over the internet. The stage acts as an environment.

## Syntax

Ensure that the deployment exists.

    describe aws_api_gateway_deployments(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

For additional information, see the [AWS ApiGateway Deployment documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-deployment.html).

## Properties

| Property | Description|
| --- | --- |
| ids | The identifier for the deployment resource. |
| descriptions | The description for the deployment resource. |
| created_dates | The date and time that the deployment resource was created. |
| api_summaries | A summary of the RestApi at the date and time that the deployment resource was created. |

## Examples

### Ensure that the deployment ID exists.

    describe aws_api_gateway_deployments(rest_api_id: 'REST_API_ID') do
      its('ids') { should include 'DEPLOYMENT_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_deployments(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_deployments(rest_api_id: 'REST_API_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the deployment is available.

    describe aws_api_gateway_deployments(rest_api_id: 'REST_API_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client::Deployments` action with `Effect` set to `Allow`.
