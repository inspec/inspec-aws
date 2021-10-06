---
title: About the aws_apigateway_api_key Resource
platform: aws
---

# aws_apigateway_api_key

Use the `aws_apigateway_api_key` InSpec audit resource to test properties of a single specific AWS APIGateway ApiKey.

The AWS::ApiGateway::ApiKey resource creates a unique key that you can distribute to clients who are executing API Gateway Method resources that require an API key.

## Syntax

Ensure that the api key exists.

    describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
      it { should exist }
    end

## Parameters

`api_key` _(required)_

The identifier of the API key resource.

For additional information, see the [AWS documentation on AWS APIGateway ApiKey.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-apikey.html).

## Properties

| Property | Description |
| --- | --- |
| id | The identifier of the API Key. |
| value | The value of the API Key. |
| name | The name of the API Key. |
| customer_id | An AWS Marketplace customer identifier , when integrating with the AWS SaaS Marketplace. |
| description | The description of the API Key. |
| enabled | Specifies whether the API Key can be used by callers. |
| created_date | The timestamp when the API Key was created. |
| last_updated_date | The timestamp when the API Key was last updated. |
| stage_keys | A list of Stage resources that are associated with the API key resource. |
| tags | The collection of tags. Each tag element is associated with a given resource. |

## Examples

### Ensure an ID is available.

    describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
      its('id') { should eq 'ID' }
    end

### Ensure that the name is available.

    describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
        its('name') { should eq 'API_KEY_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_api_key(api_key: 'API_KEY_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:ApiKey` action with `Effect` set to `Allow`.
