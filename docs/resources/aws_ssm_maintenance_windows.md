---
title: About the aws_ssm_maintenance_windows Resource
platform: aws
---

# aws_ssm_maintenance_windows

Use the `aws_ssm_maintenance_windows` InSpec audit resource to test properties of multiple AWS Systems Manager (SSM) maintenance windows.

The `AWS::SSM::MaintenanceWindow` resource represents general information about a maintenance window for AWS Systems Manager.

## Syntax

Ensure that a maintenance window exists.

    describe aws_ssm_maintenance_windows do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on the `AWS::SSM::MaintenanceWindow` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindow.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| window_ids | The ID of the maintenance window. | window_id |
| names | The name of the maintenance window. | name |
| descriptions | A description of the maintenance window. | description |
| enabled | Indicates whether the maintenance window is enabled. | enabled |
| durations | The duration of the maintenance window in hours. | duration |
| cutoffs | The number of hours before the end of the maintenance window that Amazon Web Services Systems Manager stops scheduling new tasks for execution. | cutoff |
| schedules | The schedule of the maintenance window in the form of a cron or rate expression. | schedule |
| schedule_timezones | The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. | schedule_timezone |
| schedule_offsets | The number of days to wait to run a maintenance window after the scheduled cron expression date and time. | schedule_offset |
| end_dates | The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become inactive. | end_date |
| start_dates | The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become active. | start_date |
| next_execution_times | The next time the maintenance window will actually run, taking into account any specified times for the maintenance window to become active or inactive. | next_execution_time |

## Examples

### Ensure a maintenance window ID is available.

    describe aws_ssm_maintenance_windows do
      its('window_ids') { should include 'MAINTENANCE_WINDOW_ID' }
    end

### Ensure a maintenance window name is available.

    describe aws_ssm_maintenance_windows do
      its('names') { should include 'MAINTENANCE_WINDOW_NAME' }
    end

### Verify a maintenance window is enabled.

    describe aws_ssm_maintenance_windows do
      its('enabled') { should include true }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_maintenance_windows do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_maintenance_windows do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:DescribeMaintenanceWindowsResult` action with `Effect` set to `Allow`.
