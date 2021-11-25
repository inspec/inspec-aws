---
title: About the aws_s3_storage_lenses Resource
platform: aws
---

# aws_rds_db_cluster_snapshot

Use the `aws_s3_storage_lenses` InSpec audit resource to test the properties of the plural resource of AWS S3 StorageLens.

## Syntax

Ensure that S3 storage lens exists.

    describe aws_s3_storage_lenses(config_id: 'CONFIG_ID') do
      it { should exist }
    end

## Parameters

`config_id` _(required)_

The ID of the Amazon S3 Storage Lens configuration.

For additional information, see the [AWS documentation on AWS S3 StorageLens.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-storagelens.html).

## Properties

| Property | Description | Fields |
| :----------------------------: | :----------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------: |
| ids | A container for the S3 Storage Lens configuration ID. | id |
| storage_lens_arns | The ARN of the S3 Storage Lens configuration. This property is read-only. | storage_lens_arn |
| home_regions | A container for the S3 Storage Lens home Region. Your metrics data is stored and retained in your designated S3 Storage Lens home Region. | home_region |
| is_enabled | A container for whether the S3 Storage Lens configuration is enabled. | is_enabled |

## Examples

### Ensure a config ID is `available`.

    describe aws_s3_storage_lenses(config_id: 'CONFIG_ID') do
      its('ids') { should include 'CONFIG_ID' }
    end

### Ensure that the container is enabled.

    describe aws_s3_storage_lenses(config_id: 'CONFIG_ID') do
        its('is_enabled') { should include true }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The control passes if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_s3_storage_lenses(config_id: 'CONFIG_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_s3_storage_lenses(config_id: 'CONFIG_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_s3_storage_lenses(config_id: 'CONFIG_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `S3:Client:GetStorageLensConfigurationResult` action with `Effect` set to `Allow`.
