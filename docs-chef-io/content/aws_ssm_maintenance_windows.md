+++
title = "aws_ssm_maintenance_windows resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_maintenance_windows"
identifier = "inspec/resources/aws/aws_ssm_maintenance_windows resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_maintenance_windows` InSpec audit resource to test properties of multiple AWS Systems Manager (SSM) maintenance windows.

The `AWS::SSM::MaintenanceWindow` resource represents general information about a maintenance window for AWS Systems Manager.

For additional information, including details on parameters and properties, see the [AWS documentation on the `AWS::SSM::MaintenanceWindow` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindow.html).

## Syntax

Ensure that a maintenance window exists.

```ruby
describe aws_ssm_maintenance_windows do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`window_ids`
: The ID of the maintenance window.

: **Field**: `window_id`

`names`
: The name of the maintenance window.

: **Field**: `name`

`descriptions`
: A description of the maintenance window.

: **Field**: `description`

`enabled`
: Indicates whether the maintenance window is enabled.

: **Field**: `enabled`

`durations`
: The duration of the maintenance window in hours.

: **Field**: `duration`

`cutoffs`
: The number of hours before the end of the maintenance window that Amazon Web Services Systems Manager stops scheduling new tasks for execution.

: **Field**: `cutoff`

`schedules`
: The schedule of the maintenance window in the form of a cron or rate expression.

: **Field**: `schedule`

`schedule_timezones`
: The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format.

: **Field**: `schedule_timezone`

`schedule_offsets`
: The number of days to wait to run a maintenance window after the scheduled cron expression date and time.

: **Field**: `schedule_offset`

`end_dates`
: The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become inactive.

: **Field**: `end_date`

`start_dates`
: The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become active.

: **Field**: `start_date`

`next_execution_times`
: The next time the maintenance window will actually run, taking into account any specified times for the maintenance window to become active or inactive.

: **Field**: `next_execution_time`

## Examples

Ensure a maintenance window ID is available:

```ruby
describe aws_ssm_maintenance_windows do
  its('window_ids') { should include 'MAINTENANCE_WINDOW_ID' }
end
```

Ensure a maintenance window name is available:

```ruby
describe aws_ssm_maintenance_windows do
  its('names') { should include 'MAINTENANCE_WINDOW_NAME' }
end
```

Verify a maintenance window is enabled:

```ruby
describe aws_ssm_maintenance_windows do
  its('enabled') { should include true }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ssm_maintenance_windows do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ssm_maintenance_windows do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeMaintenanceWindowsResult" %}}
