---
title: About the aws_api_gateway_documentation_version Resource
platform: aws
---

# aws_api_gateway_documentation_version

Use the `aws_api_gateway_documentation_version` InSpec audit resource to test properties of a single AWS API Gateway documentation version.

The `AWS::ApiGateway::DocumentationVersion` resource creates a documentation version for an API.

## Syntax

Ensure that the documentation version exists.

    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The string identifier of the associated RestApi.

`documentation_version` _(required)_

The identifier of the documentation version resource to get information about.

For additional information, see the [AWS ApiGateway documentation version documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationversion.html).

## Properties

| Property     | Description                                               |
|--------------|-----------------------------------------------------------|
| created_date | The date when the API documentation snapshot is created.  |
| version      | The version identifier of the API documentation snapshot. |
| description  | The description of the API documentation snapshot.        |

## Examples

### Ensure that the documentation version ID exists.

    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
      its('version') { should eq 'VERSION' }
    end

### Check whether the API path exist for a documentation version.

    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
        its('description') { should eq 'DESCRIPTION' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_api_gateway_documentation_version(rest_api_id: 'REST_API_ID', documentation_version: 'DOCUMENTATION_VERSION') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:DocumentationVersion` action with `Effect` set to `Allow`.
