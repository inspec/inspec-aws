+++
title = "aws_athena_work_group resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_athena_work_group"
identifier = "inspec/resources/aws/aws_athena_work_group resource"
parent = "inspec/resources/aws"
+++

Use the `aws_athena_work_group` InSpec audit resource to test properties of a single specific Amazon Athena workgroup.

For additional information, including details on parameters and properties, see the [AWS Athena workgroup documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html).

## Syntax

```ruby
describe aws_athena_work_group(work_group: 'WORK_GROUP') do
  it { should exist }
end
```

## Parameters

`work_group` _(required)_

## Properties

`name`
: The workgroup name.

`state`
: The state of the workgroup. Valid values are: `ENABLED` or `DISABLED`.

`description`
: The workgroup description.

`creation_time`
: The workgroup creation time. Format: YYYY-MM-DD HH:MM:SS ZZZZ.

`tags`
: An array of key-value pairs to apply to this resource.

`configuration (result_configuration)`
: The location and encryption of query results of the workgroup.

`configuration (enforce_work_group_configuration)`
: Whether workgroup settings override client-side settings.

`configuration (publish_cloud_watch_metrics_enabled)`
: Whether Amazon CloudWatch metrics are enabled in the workgroup.

`configuration (bytes_scanned_cutoff_per_query)`
: The limit in bytes that a query is allowed to scan in the workgroup.

`configuration (requester_pays_enabled)`
: Whether the workgroup can reference Requester Pays buckets.

`configuration (engine_version (selected_engine_version))`
: The user-selected engine version.

`configuration (engine_version (effective_engine_version))`
: The engine version on which a query runs.

## Examples

Ensure a workgroup name is available:

```ruby
describe aws_athena_work_group(work_group: 'WORK_GROUP') do
  its('name') { should eq 'WORK_GROUP_NAME' }
end
```

Ensure that the state is `ENABLED` or `DISABLED`:

```ruby
describe aws_athena_work_group(work_group: 'WORK_GROUP') do
    its('state') { should eq 'ENABLED' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_athena_work_group(work_group: 'WORK_GROUP') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_athena_work_group(work_group: 'WORK_GROUP') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_athena_work_group(work_group: 'WORK_GROUP') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Athena:Client:GetWorkGroupOutput" %}}
