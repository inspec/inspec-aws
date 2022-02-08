---
title: About the aws_api_gateway_documentation_versions Resource
platform: aws
---

# aws_api_gateway_documentation_versions

Use the `aws_api_gateway_documentation_versions` InSpec audit resource to test properties of multiple AWS ApiGateway Documentation Parts.

The AWS::ApiGateway::DocumentationParts resource creates a documentation part for an API.

## Syntax

Ensure that the documentation version exists.

    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

For additional information, see the [AWS ApiGateway Documentation Version documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationversion.html).

## Properties

| Property      | Description                                               |
|---------------|-----------------------------------------------------------|
| created_dates | The date when the API documentation snapshot is created.  |
| versions      | The version identifier of the API documentation snapshot. |
| descriptions  | The description of the API documentation snapshot.        |

## Examples

### Ensure that the documentation part ID exists.

    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      its('versions') { should include 'VERSION' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the documentation part is available.

    describe aws_api_gateway_documentation_versions(rest_api_id: 'REST_API_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client::DocumentationVersions` action with `Effect` set to `Allow`.