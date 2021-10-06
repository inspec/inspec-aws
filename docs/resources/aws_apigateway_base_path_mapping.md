---
title: About the aws_apigateway_base_path_mapping Resource
platform: aws
---

# aws_apigateway_base_path_mapping

Use the `aws_apigateway_base_path_mapping` Chef InSpec audit resource to test properties of a single specific AWS API Gateway base path mapping.

The `AWS::ApiGateway::BasePathMapping` resource creates a base path that clients who call your API must use in the invocation URL.

## Syntax

Test that the base path mapping exists.

    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
      it { should exist }
    end

## Parameters

`domain_name` _(required)_

The domain name of the base path mapping resource to be described.

`base_path` _(required)_

The base path name that callers of the API must provide as part of the URL after the domain name.

For additional information, see the [AWS documentation on AWS APIGateway BasePathMapping.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description |
| --- | --- |
| base_path | The base path name that callers of the API must provide as part of the URL after the domain name. |
| rest_api_id | The string identifier of the associated RestApi.|
| stage | The name of the associated stage. |

## Examples

### Test that a base path is available.

    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
      its('base_path') { should eq 'BASE_PATH')' }
    end

### Test that a stage name is available.

    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
        its('stage') { should eq 'StageName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_base_path_mapping(domain_name: 'DOMAIN_NAME', base_path: 'BASE_PATH') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:BasePathMapping` action with `Effect` set to `Allow`.
