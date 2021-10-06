---
title: About the aws_cloud_formation_stack_sets Resource
platform: aws
---

# aws_cloud_formation_stack_sets

Use the `aws_cloud_formation_stack_sets` InSpec audit resource to test properties of multiple AWS Cloud Formation stack sets.

## Syntax

Ensure that the stack set exists.

    describe aws_cloud_formation_stack_sets do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS CloudFormation Stack Set.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stackset.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| stack_set_names | The name of the stack set. | stack_set_name |
| stack_set_ids | The ID of the stack set. | stack_set_ids |
| descriptions | A description of the stack set that you specify when the stack set is created or updated. | description |
| status | The status of the stack set. | status |
| auto_deployments | Describes whether StackSets automatically deploys to Organizations accounts that are added to a target organizational unit (OU). | auto_deployment |
| permission_models | Describes how the IAM roles required for stack set operations are created. | permission_model |
| drift_statuses | Status of the stack set's actual configuration compared to its expected template and parameter configuration. | drift_status |
| last_drift_check_timestamps | Most recent time when CloudFormation performed a drift detection operation on the stack set. | last_drift_check_timestamp |

## Examples

### Verify that a stack set ID is available.

    describe aws_cloud_formation_stack_sets do
      its('stack_set_ids') { should include 'STACK_SET_ID' }
    end

### Verify the descriptions of the stack set.

    describe aws_cloud_formation_stack_sets do
        its('descriptions') { should include 'DESCRIPTION_STRING'}
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_cloud_formation_stack_sets do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_cloud_formation_stack_sets do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFormation:Client:ListStackSetsOutput` action with `Effect` set to `Allow`.
