+++
title = "aws_ssm_maintenance_window_targets resource"

draft = false


[menu.aws]
title = "aws_ssm_maintenance_window_targets"
identifier = "inspec/resources/aws/aws_ssm_maintenance_window_targets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_maintenance_window_targets` InSpec audit resource to test properties of multiple AWS Systems Manager (SSM) maintenance window targets.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM MaintenanceWindowTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtarget.html).

## Syntax

Ensure that a maintenance window target exists.

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  it { should exist }
end
```

## Parameters

`window_id` _(required)_

: The ID of the maintenance window to register the target with.

## Properties

`window_ids`
: The ID of the maintenance window to register the target with.

: **Field**: `window_id`

`window_target_ids`
: The ID of the target.

: **Field**: `window_target_id`

`resource_types`
: The type of target that is being registered with the maintenance window.

: **Field**: `resource_type`

`targets`
: The targets, either instances or tags.

: **Field**: `targets`

`owner_informations`
: A user-provided value that will be included in any Amazon CloudWatch Events events that are raised while running tasks for these targets in this maintenance window.

: **Field**: `owner_information`

`names`
: The name for the maintenance window target.

: **Field**: `name`

`descriptions`
: A description for the target.

: **Field**: `description`

## Examples

Verify that the maintenance window target description exists:

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  its('descriptions') { should include 'MAINTENANCE_TARGET_DESCRIPTION' }
end
```

Ensure a maintenance window target ID is available:

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  its('window_target_ids') { should include 'WINDOW_TARGET_ID' }
end
```

Verify a maintenance resource type is `INSTANCE`:

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  its('resource_types') { should include 'INSTANCE' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeMaintenanceWindowTargetsResult" %}}
