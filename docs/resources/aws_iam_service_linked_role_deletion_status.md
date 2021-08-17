---
title: About the aws_iam_service_linked_role_deletion_status Resource
platform: aws
---

# aws\_iam\_service\_linked\_role\_deletion\_status

Use the `aws_iam_service_linked_role_deletion_status` InSpec audit resource to test deletion status of a single Service Linked Role.

## Syntax

Ensure that a Service Linked Role deletion task exists.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'deletion_task_id') do
      it { should exist }
    end

## Parameters

`deletion_task_id` _(required)_

For additional information, see the [AWS documentation on Service linked role deletion status](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servicelinkedrole.html).

## Properties

| Property | Description|
| --- | --- |
| status | The name identifying the instance profile. |



## Examples

### Ensure a Service Linked Role is deleted.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'deletion_task_id') do
      its('status') { should eq 'SUCCEEDED' }
    end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'deletion_task_id') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'deletion_task_id') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the Service Linked Role deletion task is available.

    describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'deletion_task_id') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam_client.get_service_linked_role_deletion_status` action with `Effect` set to `Allow`.