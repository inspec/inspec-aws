---
title: About the aws_cloud_formation_stack_set Resource
platform: aws
---

# aws_cloud_formation_stack_set

Use the `aws_cloud_formation_stack_set` InSpec audit resource to test properties of the singular Cloud Formation Stack Set.

## Syntax

Ensure that the custom resource exists.

    describe aws_cloud_formation_stack_set(stack_set_name: "StackSetName" ) do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFormation Stack Set.](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_StackSet.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| stack_set_name | The name of the stack set. | stack_set_name |
| stack_set_id | The ID of the stack set. | stack_set_ids |
| descriptions | A description of the stack set that you specify when the stack set is created or updated. | description |
| status | The status of the stack set. | status |
| permission_model | Describes how the IAM roles required for stack set operations are created. | permission_model |
| drift_status | Status of the stack set's actual configuration compared to its expected template and parameter configuration. | drift_status |
| last_drift_check_timestamp | Most recent time when CloudFormation performed a drift detection operation on the stack set. | last_drift_check_timestamp |

## Examples

### Ensure a id is available.
    describe aws_cloud_formation_stack_set(stack_set_name: "StackSetName" ) do
      its('stack_set_id') { should eq 'ID' }
    end

### Verify the description of the Stack Set.
    describe aws_cloud_formation_stack_set(stack_set_name: "StackSetName" ) do
        its('description') { should eq 'Description'}
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `descirbe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloud_formation_stack_set(stack_set_name: "StackSetName" ) do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloud_formation_stack_set(stack_set_name: "StackSetName" ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFront:Client:DescribeStackSetOutput` action with `Effect` set to `Allow`.