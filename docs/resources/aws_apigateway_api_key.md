---
title: About the aws_apigateway_api_key Resource
platform: aws
---

# aws_apigateway_api_key

Use the `aws_apigateway_api_key` InSpec audit resource to test properties of a single specific AWS APIGateway ApiKey.

The AWS::ApiGateway::ApiKey resource creates a unique key that you can distribute to clients who are executing API Gateway Method resources that require an API key.

## Syntax

Ensure that the api key exists.

    describe aws_apigateway_api_key(api_key: 'APIID') do
      it { should exist }
    end

## Parameters

`api_key` _(required)_

| Property | Description |
| --- | --- |
| api_key | The identifier of the ApiKey resource. |

For additional information, see the [AWS documentation on AWS APIGateway ApiKey.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-apikey.html).

## Properties

| Property | Description | Fields | 
| --- | --- | --- |
| id | The identifier of the API Key. | id |
| value | The value of the API Key. | value |
| name | The name of the API Key. | name |
| customer_id | An AWS Marketplace customer identifier , when integrating with the AWS SaaS Marketplace. | customer_id |
| description | The description of the API Key. | description |
| enabled | Specifies whether the API Key can be used by callers. | enabled |
| created_date | The timestamp when the API Key was created. | created_date |
| last_updated_date | The timestamp when the API Key was last updated. | last_updated_date |
| stage_keys | A list of Stage resources that are associated with the ApiKey resource. | stage_keys |
| tags | The collection of tags. Each tag element is associated with a given resource. | tags |

## Examples

### Ensure an id is available.
    describe aws_apigateway_api_key(api_key: 'APIID') do
      its('id') { should eq 'ID' }
    end

### Ensure that the name is available.
    describe aws_apigateway_api_key(api_key: 'APIID') do
        its('name') { should eq 'APIKeyName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_api_key(api_key: 'APIID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_api_key(api_key: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_api_key(api_key: 'APIID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:ApiKey` action with `Effect` set to `Allow`.