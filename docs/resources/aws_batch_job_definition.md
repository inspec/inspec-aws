---
title: About the aws_athena_work_group Resource
platform: aws
---

# aws\_athena\_work\_group

Use the `aws_athena_work_group` InSpec audit resource to test properties of a single specific Athena Work Group.

The AWS::Athena::WorkGroup resource specifies an Amazon Athena workgroup, which contains a name, description, creation time, state, and other configuration, listed under WorkGroupConfiguration. Each workgroup enables you to isolate queries for you or your group from other queries in the same account.

## Syntax

Ensure that a work_group name exists.

    describe aws_athena_work_group(work_group: 'test1') do
      it { should exist }
    end

## Parameters

`work_group` _(required)_

For additional information, see the [AWS documentation on Athena Work Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).

## Properties

| Property | Description|
| --- | --- |
| name | The workgroup name. |
| state | The state of the workgroup: ENABLED or DISABLED. |
| description | The workgroup description. |
| creation_time | The workgroup creation time. |
| tags | An array of key-value pairs to apply to this resource. |
| configuration (result_configuration) | The workgroup result configuration of the configuration. |
| configuration (enforce_work_group_configuration) | The enforce workgroup configuration of the configuration. |
| configuration (publish_cloud_watch_metrics_enabled) | The publish cloudwatch metrics enabled of the configuration. |
| configuration (bytes_scanned_cutoff_per_query) | The bytes scanned cutoff per query of the configuration. |
| configuration (requester_pays_enabled) | The requester pays enabled of the configuration. |
| configuration (engine_version (selected_engine_version)) | The selected engine version of engine version of the configuration. |
| configuration (engine_version (effective_engine_version)) | The effective engine version of engine version of the configuration. |

## Examples

### Ensure a work_group name is available.
    describe aws_athena_work_group(work_group: 'test1') do
      its('name') { should eq 'test1' }
    end

### Ensure that the state is `ENABLED` or `DISABLED`.
    describe aws_athena_work_group(work_group: 'test1') do
        its('state') { should eq 'ENABLED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_athena_work_group(work_group: 'test1') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_athena_work_group(work_group: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_athena_work_group(work_group: 'test1') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `athena:client:get_work_group` action with `Effect` set to `Allow`.