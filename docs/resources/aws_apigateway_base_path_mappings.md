---
title: About the aws_apigateway_base_path_mappings Resource
platform: aws
---

# aws_apigateway_base_path_mappings

Use the `aws_apigateway_base_path_mappings` InSpec audit resource to test properties of multiple AWS API Gateway base path mappings.

The `AWS::ApiGateway::BasePathMapping` resource creates a base path that clients who call your API must use in the invocation URL.

## Syntax

Ensure that the base path mappings exists.

    describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
      it { should exist }
    end

## Parameters

`domain_name` _(required)_

The domain name of the BasePathMapping resource to be described.

For additional information, see the [AWS documentation on AWS APIGateway BasePathMapping.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| base_paths | The base path name that callers of the API must provide as part of the URL after the domain name. | base_path |
| rest_api_ids | The string identifier of the associated RestApi.| rest_api_id |
| stages | The name of the associated stage. | stage |

## Examples

### Ensure a base path is available.

    describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
      its('base_paths') { should include 'BASE_PATH')' }
    end

### Ensure that stage name is available.
    describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
        its('stages') { should include 'STAGE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_base_path_mappings(domain_name: 'DOMAIN_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:BasePathMappings` action with `Effect` set to `Allow`.
