---
title: About the aws_s3_storage_lens Resource
platform: aws
---

# aws_rds_db_cluster_snapshot

Use the `aws_s3_storage_lens` InSpec audit resource to test the properties of the singular resource of AWS S3 StorageLens.

## Syntax

Ensure that S3 storage lens exists.

    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
      it { should exist }
    end

## Parameters

`config_id` _(required)_

The ID of the Amazon S3 Storage Lens configuration.

`account_id` _(required)_

The account ID of the requester.

For additional information, see the [AWS documentation on AWS S3 StorageLens.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-storagelens.html).

## Properties

| Property | Description |
| :----------------------------: | :----------------------------------------------------------------------------------------: |
| id | A container for the Amazon S3 Storage Lens configuration ID. |
| account_level.activity_metrics.is_enabled | A container for whether the activity metrics are enabled. |
| account_level.bucket_level.activity_metrics.is_enabled | A container for whether the activity metrics are enabled. |
| account_level.bucket_level.prefix_level.storage_metrics.is_enabled | A container for whether prefix-level storage metrics are enabled. |
| account_level.bucket_level.prefix_level.storage_metrics.selection_criteria.delimiter | A container for the delimiter of the selection criteria being used. |
| account_level.bucket_level.prefix_level.storage_metrics.selection_criteria.max_depth | The max depth of the selection criteria. |
| account_level.bucket_level.prefix_level.storage_metrics.selection_criteria.min_storage_bytes_percentage | The minimum number of storage bytes percentage whose metrics will be selected. |
| include.buckets | A container for the S3 Storage Lens bucket includes. |
| include.regions | A container for the S3 Storage Lens Region includes. |
| exclude.buckets | A container for the S3 Storage Lens bucket excludes. |
| exclude.regions | A container for the S3 Storage Lens Region excludes. |
| data_export.s3_bucket_destination.format | The format of the s3 bucket destination. |
| data_export.s3_bucket_destination.output_schema_version | The schema version of the export file. |
| data_export.s3_bucket_destination.account_id | The account ID of the owner of the S3 Storage Lens metrics export bucket. |
| data_export.s3_bucket_destination.arn | The Amazon Resource Name (ARN) of the bucket. |
| data_export.s3_bucket_destination.prefix | The prefix of the destination bucket where the metrics export will be delivered. |
| data_export.s3_bucket_destination.encryption.ssekms.key_id | A container for the ARN of the SSE-KMS encryption. |
| data_export.cloud_watch_metrics.is_enabled | A container that indicates whether CloudWatch publishing for S3 Storage Lens metrics is enabled. |
| is_enabled | A container for whether the S3 Storage Lens configuration is enabled. |
| aws_org.arn | A container for the Amazon Resource Name (ARN) of the Amazon Web Services organization. |
| storage_lens_arn | The Amazon Resource Name (ARN) of the S3 Storage Lens configuration. |

## Examples

### Ensure a config ID is `available`.

    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
      its('id') { should eq 'CONFIG_ID' }
    end

### Ensure that the container is enabled.

    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
        its('is_enabled') { should eq true }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_storage_lens(config_id: 'CONFIG_ID', account_id: 'ACCOUNT_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:GetStorageLensConfigurationResult` action with `Effect` set to `Allow`.
