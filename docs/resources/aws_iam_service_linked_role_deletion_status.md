---
title: About the aws_iam_service_linked_role_deletion_status Resource
platform: aws
---

# aws\_iam\_service\_linked\_role\_deletion\_status

Use the `aws_iam_service_linked_role_deletion_status` InSpec audit resource to test the deletion status of a single AWS IAM service-linked role.

## Syntax

Ensure that a service-linked role deletion task exists.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
      it { should exist }
    end

## Parameters

`deletion_task_id` _(required)_

The deletion task identifier.

See the [AWS documentation on Service linked role deletion status](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servicelinkedrole.html) for additional information.

## Properties

| Property | Description|
| --- | --- |
| status | The status of the deletion. Valid Values: `SUCCEEDED`, `IN_PROGRESS`, `FAILED`, `NOT_STARTED` |

## Examples

### Ensure a service-linked role is deleted.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
      its('status') { should eq 'SUCCEEDED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a complete list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the Service Linked Role deletion task is available.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:GetServiceLinkedRoleDeletionStatusResponse` action with `Effect` set to `Allow`.
