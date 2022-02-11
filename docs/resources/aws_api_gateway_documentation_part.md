---
title: About the aws_api_gateway_documentation_part Resource
platform: aws
---

# aws_api_gateway_documentation_part

Use the `aws_api_gateway_documentation_part` InSpec audit resource to test properties of a single documentation part for an AWS API Gateway.

The `AWS::ApiGateway::DocumentationPart` resource creates a documentation part for an API.

## Syntax

Ensure that the documentation part exists.

    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
      it { should exist }
    end

## Parameters

`rest_api_id` _(required)_

The string identifier of the associated REST API.

`documentation_part_id` _(required)_

The identifier of the documentation part resource to get information about.

For additional information, see the [AWS ApiGateway Documentation Part](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-documentationpart.html).

## Properties

| Property             | Description                                                                       |
|----------------------|-----------------------------------------------------------------------------------|
| id                   | The identifier for the documentation part resource.                               |
| location.type        | The type of API entity to which the documentation content applies.                |
| location.path        | The URL path of the target.                                                       |
| location.method      | The HTTP verb of a method.                                                        |
| location.status_code | The HTTP status code of a response.                                               |
| location.name        | The name of the targeted API entity.                                              |
| properties           | A content map of API-specific key-value pairs describing the targeted API entity. |

## Examples

### Ensure that the documentation part ID exists.

    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
      its('id') { should eq 'DOCUMENTATION_PART_ID' }
    end

### Check whether the API path exists for a documentation part.

    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
        its('location.path') { should eq 'REQUEST_BODY' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_api_gateway_documentation_part(rest_api_id: 'REST_API_ID', documentation_part_id: 'DOCUMENTATION_PART_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:DocumentationPart` action with `Effect` set to `Allow`.
