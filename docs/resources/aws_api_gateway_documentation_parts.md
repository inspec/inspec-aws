---
title: About the aws_api_gateway_documentation_parts Resource
platform: aws
---

# aws_api_gateway_documentation_parts

Use the `aws_api_gateway_documentation_parts` InSpec audit resource to test properties of multiple documentation parts for an AWS API Gateway.

The `AWS::ApiGateway::DocumentationParts` resource creates a documentation part for an API.

## Syntax

Ensure that the documentation part exists.

    describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The string identifier of the associated REST API.

For additional information, see the [AWS documentation on the `AWS::ApiGateway::DocumentationPart` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationpart.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| ids          | The identifier for the documentation part resource.                               | id |
| types        | The type of API entity to which the documentation content applies.                | type |
| paths        | The URL path of the target.                                                       | path |
| methods      | The HTTP verb of a method.                                                        | method |
| status_codes | The HTTP status code of a response.                                               | status_code |
| names        | The name of the targeted API entity.                                              | name |
| properties   | A content map of API-specific key-value pairs describing the targeted API entity. | properties |

## Examples

### Ensure that the documentation part ID exists.

    describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
      its('ids') { should include 'DOCUMENTATION_PART_ID' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_api_gateway_documentation_parts(rest_api_id: 'REST_API_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client::DocumentationParts` action with `Effect` set to `Allow`.
