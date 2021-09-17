---
title: About the aws_cloudformation_custom_resource Resource
platform: aws
---

# aws_cloudformation_custom_resource

Use the `aws_cloudformation_custom_resource` InSpec audit resource to test properties of a single specific AWS CloudFormation CustomResource.

In a CloudFormation template, you use the AWS::CloudFormation::CustomResource or Custom::String resource type to specify custom resources.
Custom resources provide a way for you to write custom provisioning logic in CloudFormation template and have CloudFormation run it during a stack operation, such as when you create, update or delete a stack. For more information, see Custom resources.

## Syntax

Ensure that the custom resource exists.

    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
      it { should exist }
    end

## Parameters

`stack_name logical_resource_id` _(required)_

| Property | Description |
| --- | --- |
| stack_name | The name associated with the stack. |
| logical_resource_id | The logical name of the resource specified in the template. |

For additional information, see the [AWS documentation on AWS CloudFormation CustomResource.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cfn-customresource.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| stack_name | The name associated with the stack. | stack_name |
| stack_id | Unique identifier of the stack. | stack_id |
| logical_resource_id | The logical name of the resource specified in the template. | logical_resource_id |
| physical_resource_id | The name or unique identifier that corresponds to a physical instance ID of a resource supported by CloudFormation. | physical_resource_id |
| resource_type | Type of resource. | resource_type |
| last_updated_timestamp | Time the status was updated. | last_updated_timestamp |
| resource_status | Current status of the resource. | resource_status |
| resource_status_reason | Success/failure message associated with the resource. | resource_status_reason |
| description | User defined description associated with the resource. | description |
| metadata | The content of the Metadata attribute declared for the resource. | metadata |
| drift_information.stack_resource_drift_status | Status of the resource's actual configuration compared to its expected configuration. | stack_resource_drift_status |
| drift_information.last_check_timestamp | When CloudFormation last checked if the resource had drifted from its expected configuration. | last_check_timestamp |
| module_info.type_hierarchy | A concatenated list of the the module type or types containing the resource. | type_hierarchy |
| module_info.logical_id_hierarchy | A concatenated list of the logical IDs of the module or modules containing the resource. | logical_id_hierarchy |

## Examples

### Ensure a resource type is available.
    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
      its('resource_type') { should eq 'ResourceType' }
    end

### Ensure a stack name is available.
    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
        its('stack_name') { should eq 'StackName' }
    end

### Ensure a logical resource id is available.
    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
        its('logical_resource_id') { should eq 'LogicalResourceID' }
    end

### Ensure a resource status is `CREATE_COMPLETE`.
    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
      its('resource_status') { should eq 'CREATE_COMPLETE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
    
    describe aws_cloudformation_custom_resource(stack_name: 'dummy', logical_resource_id: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_cloudformation_custom_resource(stack_name: 'StackName', logical_resource_id: 'LogicalResourceId') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFormation:Client:DescribeStackResourcesOutput` action with `Effect` set to `Allow`.