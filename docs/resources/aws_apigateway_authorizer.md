---
title: About the aws_apigateway_authorizer Resource
platform: aws
---

# aws_apigateway_authorizer

Use the `aws_apigateway_authorizer` InSpec audit resource to test properties of a single specific AWS APIGateway Authorizer.

The AWS::ApiGateway::Authorizer resource creates an authorization layer that API Gateway activates for methods that have authorization enabled. API Gateway activates the authorizer when a client calls those methods.

## Syntax

Ensure that the authorizer exists.

    describe aws_apigateway_authorizer(rest_api_id: 'RestAPIID', authorizer_id: 'AuthorizerID') do
      it { should exist }
    end

## Parameters

`rest_api_id  authorizer_id` _(required)_

| Property | Description |
| --- | --- |
| rest_api_id | The string identifier of the associated RestApi. |
| authorizer_id | The identifier of the Authorizer resource. |

For additional information, see the [AWS documentation on AWS APIGateway Authorizer.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-authorizer.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| id | The identifier for the authorizer resource. | id |
| name | The name of the authorizer. | name |
| type | The authorizer type. | type |
| provider_arns | A list of the Amazon Cognito user pool ARNs for the COGNITO_USER_POOLS authorizer. | provider_arns |
| auth_type | Optional customer-defined field, used in OpenAPI imports and exports without functional impact. | auth_type |
| authorizer_uri | Specifies the authorizer's Uniform Resource Identifier (URI). | authorizer_uri |
| authorizer_credentials | Specifies the required credentials as an IAM role for API Gateway to invoke the authorizer. | authorizer_credentials |
| identity_source | The identity source for which authorization is requested. | identity_source |
| identity_validation_expression | A validation expression for the incoming identity token. | identity_validation_expression |
| authorizer_result_ttl_in_seconds | The TTL in seconds of cached authorizer results. | authorizer_result_ttl_in_seconds |

## Examples

### Ensure a id is available.
    describe aws_apigateway_authorizer(rest_api_id: 'RestAPIID', authorizer_id: 'AuthorizerID') do
      its('id') { should eq 'AuthorizerID' }
    end

### Ensure a name is available.
    describe aws_apigateway_authorizer(rest_api_id: 'RestAPIID', authorizer_id: 'AuthorizerID') do
      its('name') { should eq 'AuthorizerName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_authorizer(rest_api_id: 'RestAPIID', authorizer_id: 'AuthorizerID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_authorizer(rest_api_id: 'dummy', authorizer_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_authorizer(rest_api_id: 'RestAPIID', authorizer_id: 'AuthorizerID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:Authorizer` action with `Effect` set to `Allow`.