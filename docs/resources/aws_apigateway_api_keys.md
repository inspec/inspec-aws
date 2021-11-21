---
title: About the aws_apigateway_api_keys Resource
platform: aws
---

# aws_apigateway_api_keys

Use the `aws_apigateway_api_keys` InSpec audit resource to test properties of multiple AWS API Gateway API keys.

The `AWS::ApiGateway::ApiKey` resource creates a unique key that you can distribute to clients who are executing API Gateway Method resources that require an API key.

## Syntax

Ensure that the API key exists.

    describe aws_apigateway_api_keys do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS API Gateway API Key.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-apikey.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| ids | The identifier of the API Key. | id |
| values | The value of the API Key. | value |
| names | The name of the API Key. | name |
| customer_ids | An AWS Marketplace customer identifier , when integrating with the AWS SaaS Marketplace. | customer_id |
| descriptions | The description of the API Key. | description |
| enabled | Specifies whether the API Key can be used by callers. | enabled |
| created_dates | The timestamp when the API Key was created. | created_date |
| last_updated_dates | The timestamp when the API Key was last updated. | last_updated_date |
| stage_keys | A list of Stage resources that are associated with the ApiKey resource. | stage_keys |
| tags | The collection of tags. | tags |

## Examples

### Ensure a ID is available.

    describe aws_apigateway_api_keys do
      its('ids') { should include 'API_ID' }
    end

### Ensure that the name is available.

    describe aws_apigateway_api_keys do
        its('names') { should include 'API_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_api_keys do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_api_keys do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:ApiKeys` action with `Effect` set to `Allow`.