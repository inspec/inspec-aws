---
title: About the aws_athena_work_groups Resource
platform: aws
---

# aws\_athena\_work\_groups

Use the `aws_athena_work_groups` InSpec audit resource to test properties of multiple Amazon Athena workgroups.

## Syntax

    describe aws_athena_work_groups do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS Athena workgroup documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description|
| --- | --- |
| names           | The workgroup name. |
| states          | The state of the workgroup. Valid values are: `ENABLED` or `DISABLED`. |
| descriptions    | The workgroup description. |
| creation_times  | The workgroup creation time. Format: YYYY-MM-DD HH:MM:SS ZZZZ |

## Examples

### Ensure a work_group name is available.

    describe aws_athena_work_groups do
      its('names') { should include 'WORK_GROUP_NAME' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.

    describe aws_athena_work_groups do
        its('states') { should include 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_athena_work_groups do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_athena_work_groups do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_athena_work_groups do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Athena:Client:ListWorkGroupsOutput` action with `Effect` set to `Allow`.
