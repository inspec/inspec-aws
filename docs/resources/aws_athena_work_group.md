---
title: About the aws_athena_work_group Resource
platform: aws
---

# aws_athena_work_group

Use the `aws_athena_work_group` InSpec audit resource to test properties of a single specific Amazon Athena workgroup.

The `AWS::Athena::WorkGroup` resource specifies an Amazon Athena workgroup, which contains a name, description, creation time, state, and other configuration, listed under WorkGroupConfiguration.

## Syntax

Ensure that a work group exists.

    describe aws_athena_work_group(work_group: 'WORK_GROUP') do
      it { should exist }
    end

## Parameters

`work_group` _(required)_

The workgroup name

For additional information, see the [AWS documentation on the `AWS::Athena::WorkGroup` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Properties

| Property | Description |
| :---: | :--- |
| name          | The workgroup name. |
| state         | The state of the workgroup. Valid values are: `ENABLED` or `DISABLED`. |
| description   | The workgroup description. |
| creation_time | The workgroup creation time. Format: YYYY-MM-DD HH:MM:SS ZZZZ |
| tags          | An array of key-value pairs to apply to this resource. |
| configuration (result_configuration) | The location and encryption of query results of the workgroup. |
| configuration (enforce_work_group_configuration) | Whether workgroup settings override client-side settings. |
| configuration (publish_cloud_watch_metrics_enabled) | Whether Amazon CloudWatch metrics are enabled in the workgroup. |
| configuration (bytes_scanned_cutoff_per_query) | The limit in bytes that a query is allowed to scan in the workgroup. |
| configuration (requester_pays_enabled) | Whether the workgroup can reference Requester Pays buckets. |
| configuration (engine_version (selected_engine_version)) | The user-selected engine version. |
| configuration (engine_version (effective_engine_version)) | The engine version on which a query runs. |

## Examples

### Ensure a workgroup name is available.

    describe aws_athena_work_group(work_group: 'WORK_GROUP') do
      its('name') { should eq 'WORK_GROUP_NAME' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.

    describe aws_athena_work_group(work_group: 'WORK_GROUP') do
        its('state') { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_athena_work_group(work_group: 'WORK_GROUP') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_athena_work_group(work_group: 'WORK_GROUP') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_athena_work_group(work_group: 'WORK_GROUP') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Athena:Client:GetWorkGroupOutput` action with `Effect` set to `Allow`.
