---
title: About the aws_cloudformation_templates Resource
platform: aws
---

# aws_cloudformation_templates

Use the `aws_cloudformation_templates` InSpec audit resource to test the plural resource of the AWS CloudFormation Template.

The above resource returns information about a new or existing template.

## Syntax

Ensure that the template exists by passing the required parameter `stack_name`.

    describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
      it { should exist }
    end

Ensure that the template exists by passing the required parameter `stack_set_name`.

    describe aws_cloudformation_templates(stack_set_name: 'STACK_SET_NAME') do
      it { should exist }
    end

Ensure that the template exists by passing the required parameter `template_url`.

    describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
      it { should exist }
    end

Ensure that the template exists by passing the required parameter `template_body`.

    describe aws_cloudformation_templates(template_body: 'TEMPLATE_BODY') do
      it { should exist }
    end

## Parameters

`One of the below parameters are required. You can use any one of them.`

`stack_name` _(required)_

The name or the stack ID that is associated with the stack, which are not always interchangeable.

`stack_set_name` _(required)_

The name or unique ID of the stack set from which the stack was created.

`template_url` _(required)_

Location of file containing the template body. The URL must point to a template (max size: 460,800 bytes) that is located in an Amazon S3 bucket.

`template_body` _(required)_

Structure containing the template body with a minimum length of 1 byte and a maximum length of 51,200 bytes.

For additional information, see the [AWS documentation on AWS CloudFormation Templates](https://aws.amazon.com/cloudformation/resources/templates/).

## Properties

| Property                                      | Description                                                                                                                                   | Fields Name                    |
| :-------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------: |
| parameters                    | The name that is associated with the parameter.                                                                                                               | parameters                     |
| descriptions                  | The value that is defined in the Description property of the template.                                                                                        | description                    |
| capabilities                  | The capabilities found within the template.                                                                                                                   | capabilities                   |
| capabilities_reasons          | The list of resources that generated the values in the Capabilities response element.                                                                         | capabilities_reason            |
| resource_types                | A list of all the template resource types that are defined in the template, such as AWS::EC2::Instance , AWS::Dynamo::Table , and Custom::MyCustomInstance.   | resource_types                 |
| version                       | The AWS template format version, which identifies the capabilities of the template.                                                                           | version                        |
| metadata                      | The value that is defined for the Metadata property of the template.                                                                                          | metadata                       |
| declared_transforms           | A list of the transforms that are declared in the template.                                                                                                   | declared_transforms            |
| resource_identifier_summaries | The resource identifier summaries.                                                                                                                            | resource_identifier_summaries  |

## Examples

### Ensure that the descriptions exists by passing the required parameter `stack_name`.

     describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
      its('descriptions') {should include 'TEST_DESCRIPTION' }
    end

### Ensure that the descriptions exists by passing the required parameter `template_url`.

    describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
      its('descriptions') {should include 'TEST_DESCRIPTION' }
    end

### Ensure that the resource_types exists by passing the required parameter `stack_name`.

     describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
      its('resource_types') {should include 'AWS::EC2::Instance' }
    end

### Ensure that the resource_types exists by passing the required parameter `template_url`.

    describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
      its('resource_types') {should include 'AWS::EC2::Instance' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists by passing the required parameter `stack_name`.

    describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
      it { should exist }
    end

Use `should` to test that the entity exists by passing the required parameter `template_url`.

    describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
      it { should exist }
    end

Use `should_not` to test that the entity exists by passing the required parameter `stack_name`.

    describe aws_cloudformation_templates(stack_name: 'STACK_NAME') do
      it { should_not exist }
    end

Use `should_not` to test that the entity exists by passing the required parameter `template_url`.

    describe aws_cloudformation_templates(template_url: 'TEMPLATE_URL') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFormation:Client:GetTemplateSummaryOutput` action with `Effect` set to `Allow`.