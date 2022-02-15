---
title: About the aws_ssm_resource_data_syncs Resource
platform: aws
---

# aws_ssm_resource_data_syncs

Use the `aws_ssm_resource_data_syncs` InSpec audit resource to test properties of the plural resource of an AWS Systems Manager (SSM) resource data sync.

The `AWS::SSM::ResourceDataSync` resource creates, updates, or deletes a resource data sync for AWS Systems Manager. A resource data sync helps you view data from multiple sources in a single location. Systems Manager offers two types of resource data sync: `SyncToDestination` and `SyncFromSource`.

## Syntax

Ensure that the resource data syncs exists:

    describe aws_ssm_resource_data_syncs do
      it { should exist }
    end

## Parameters

This resource does not expect any required parameters.

For additional information, see the [AWS documentation on AWS SSM ResourceDataSync](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-resourcedatasync.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| sync_names | The name of the resource data sync. | sync_name |
| sync_types | The type of resource data sync. | sync_type |
| sync_sources | Information about the source where the data was synchronized. | sync_source |
| s3_destinations | Configuration information for the target S3 bucket. | s3_destination |
| last_sync_times | The last time the configuration attempted to sync (UTC). | last_sync_time |
| last_successful_sync_times | The last time the sync operations returned a status of SUCCESSFUL (UTC). | last_successful_sync_time |
| sync_last_modified_times | The date and time the resource data sync was changed. | sync_last_modified_time |
| last_statuses | The status reported by the last sync. | last_status |
| sync_created_times | The date and time the configuration was created (UTC). | sync_created_time |
| last_sync_status_messages | The status message details reported by the last sync. | last_sync_status_message |

## Examples

### Ensure a sync name is available.

    describe aws_ssm_resource_data_syncs do
      its('sync_names') { should include 'RESOURCE_DATA_SYNC_NAME' }
    end

### Ensure a sync type is available.

    describe aws_ssm_resource_data_syncs do
      its('sync_types') { should include 'RESOURCE_DATA_SYNC_TYPE' }
    end

### Ensure a status is `Successful`.

    describe aws_ssm_resource_data_syncs do
      its('last_statuses') { should include 'Successful' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_resource_data_syncs do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_resource_data_syncs do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:ListResourceDataSyncResult` action with `Effect` set to `Allow`.
