+++
title = "aws_ssm_resource_data_syncs resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_resource_data_syncs"
identifier = "inspec/resources/aws/aws_ssm_resource_data_syncs resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_resource_data_syncs` InSpec audit resource to test properties of the plural resource of an AWS Systems Manager (SSM) resource data sync.

The `AWS::SSM::ResourceDataSync` resource creates, updates, or deletes a resource data sync for AWS Systems Manager. A resource data sync helps you view data from multiple sources in a single location. Systems Manager offers two types of resource data sync: `SyncToDestination` and `SyncFromSource`.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM ResourceDataSync](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-resourcedatasync.html).

## Syntax

Ensure that the resource data syncs exists:

```ruby
describe aws_ssm_resource_data_syncs do
  it { should exist }
end
```

## Parameters

This resource does not expect any required parameters.

## Properties

`sync_names`
: The name of the resource data sync.

: **Field**: `sync_name`

`sync_types`
: The type of resource data sync.

: **Field**: `sync_type`

`sync_sources`
: Information about the source where the data was synchronized.

: **Field**: `sync_source`

`s3_destinations`
: Configuration information for the target S3 bucket.

: **Field**: `s3_destination`

`last_sync_times`
: The last time the configuration attempted to sync (UTC).

: **Field**: `last_sync_time`

`last_successful_sync_times`
: The last time the sync operations returned a status of SUCCESSFUL (UTC).

: **Field**: `last_successful_sync_time`

`sync_last_modified_times`
: The date and time the resource data sync was changed.

: **Field**: `sync_last_modified_time`

`last_statuses`
: The status reported by the last sync.

: **Field**: `last_status`

`sync_created_times`
: The date and time the configuration was created (UTC).

: **Field**: `sync_created_time`

`last_sync_status_messages`
: The status message details reported by the last sync.

: **Field**: `last_sync_status_message`

## Examples

Ensure a sync name is available:

```ruby
describe aws_ssm_resource_data_syncs do
  its('sync_names') { should include 'RESOURCE_DATA_SYNC_NAME' }
end
```

Ensure a sync type is available:

```ruby
describe aws_ssm_resource_data_syncs do
  its('sync_types') { should include 'RESOURCE_DATA_SYNC_TYPE' }
end
```

Ensure a status is `Successful`:

```ruby
describe aws_ssm_resource_data_syncs do
  its('last_statuses') { should include 'Successful' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ssm_resource_data_syncs do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ssm_resource_data_syncs do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:ListResourceDataSyncResult" %}}
