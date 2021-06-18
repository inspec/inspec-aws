---
title: About the aws_api_gateway_deployment Resource
platform: aws
---

# aws\_api\_gateway\_deployment

Use the `aws_api_gateway_deployment` InSpec audit resource to test properties of a single specific AWS ApiGateway Deployment.

The AWS::ApiGateway::Deployment resource deploys an API Gateway RestApi resource to a stage so that clients can call the API over the internet. The stage acts as an environment.

## Syntax

Ensure that the deployment exists.

    describe aws_api_gateway_deployment(rest_api_id: 'value', deployment_id: 'value') do
      it { should exist }
    end

## Parameters

`rest_api_id deployment_id` _(required)_

For additional information, see the [AWS ApiGateway Deployment documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-deployment.html).

## Properties

| Property | Description|
| --- | --- |
| id | The identifier for the deployment resource. |
| description | The description for the deployment resource. |
| created_date | The date and time that the deployment resource was created. |
| api_summary | A summary of the RestApi at the date and time that the deployment resource was created. |
| api_summary (authorization_type) | The method's authorization type. Valid values are NONE for open access, AWS_IAM for using AWS IAM permissions, CUSTOM for using a custom authorizer, or COGNITO_USER_POOLS for using a Cognito user pool. |
| api_summary (api_key_required) | Specifies whether the method requires a valid ApiKey . |

## Examples

### Ensure that the deployment id exists.

    describe aws_api_gateway_deployment(rest_api_id: 'value', deployment_id: 'value') do
      its('id') { should eq 'value' }
    end

### Check whether the api key is required for a particular deployment

    describe aws_api_gateway_deployment(rest_api_id: 'value', deployment_id: 'value') do
        its('api_summary.api_key_required') { should eq false }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_deployment(rest_api_id: 'value', deployment_id: 'value') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_deployment(rest_api_id: 'dummy', deployment_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_api_gateway_deployment(rest_api_id: 'value', deployment_id: 'value') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `apigateway:get-deployment` action with `Effect` set to `Allow`.
