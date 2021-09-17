---
title: About the aws_apigateway_base_path_mapping Resource
platform: aws
---

# aws_apigateway_base_path_mapping

Use the `aws_apigateway_base_path_mapping` InSpec audit resource to test properties of a single specific AWS APIGateway BasePathMapping.

The AWS::ApiGateway::BasePathMapping resource creates a base path that clients who call your API must use in the invocation URL.

## Syntax

Ensure that the base path mapping exists.

    describe aws_apigateway_base_path_mapping(domain_name: 'DomainName', base_path: 'BasePath') do
      it { should exist }
    end

## Parameters

`domain_name base_path` _(required)_

| Property | Description |
| --- | --- |
| domain_name | The domain name of the BasePathMapping resource to be described. |
| base_path | The base path name that callers of the API must provide as part of the URL after the domain name. |

For additional information, see the [AWS documentation on AWS APIGateway BasePathMapping.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-basepathmapping.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| base_path | The base path name that callers of the API must provide as part of the URL after the domain name. | base_path |
| rest_api_id | The string identifier of the associated RestApi.| rest_api_id |
| stage | The name of the associated stage. | stage |

## Examples

### Ensure a base path is available.
    describe aws_apigateway_base_path_mapping(domain_name: 'DomainName', base_path: 'BasePath') do
      its('base_path') { should eq 'BasePath')' }
    end

### Ensure that stage name is available.
    describe aws_apigateway_base_path_mapping(domain_name: 'DomainName', base_path: 'BasePath') do
        its('stage') { should eq 'StageName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_apigateway_base_path_mapping(domain_name: 'DomainName', base_path: 'BasePath') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_apigateway_base_path_mapping(domain_name: 'dummy', base_path: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_apigateway_base_path_mapping(domain_name: 'DomainName', base_path: 'BasePath') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `APIGateway:Client:BasePathMapping` action with `Effect` set to `Allow`.