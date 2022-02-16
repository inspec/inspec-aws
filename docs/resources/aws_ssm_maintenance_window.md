---
title: About the aws_ssm_maintenance_window Resource
platform: aws
---

# aws_ssm_maintenance_window

Use the `aws_ssm_maintenance_window` InSpec audit resource to test properties of a single AWS Systems Manager (SSM) maintenance window.

The `AWS::SSM::MaintenanceWindow` resource represents general information about a maintenance window for AWS Systems Manager.

## Syntax

Ensure that the maintenance window exists.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      it { should exist }
    end

## Parameters

`window_id` _(required)_

The ID of the maintenance window for which you want to retrieve information.

For additional information, see the [AWS documentation on the `AWS::SSM::MaintenanceWindow` resource type](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindow.html).

## Properties

| Property | Description |
| :---: | :--- |
| window_id | The ID of the maintenance window for which you want to retrieve information. |
| name | The name of the maintenance window. |
| description | The description of the maintenance window. |
| start_date | The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become active. |
| end_date | The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become inactive. |
| schedule | The schedule of the maintenance window in the form of a cron or rate expression. |
| schedule_timezone | The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. |
| schedule_offset | The number of days to wait to run a maintenance window after the scheduled cron expression date and time. |
| next_execution_time | The next time the maintenance window will actually run, taking into account any specified times for the maintenance window to become active or inactive. |
| duration | The duration of the maintenance window in hours. |
| cutoff | The number of hours before the end of the maintenance window that Amazon Web Services Systems Manager stops scheduling new tasks for execution. |
| allow_unassociated_targets | Whether targets must be registered with the maintenance window before tasks can be defined for those targets. |
| enabled | Indicates whether the maintenance window is enabled. |
| created_date | The date the maintenance window was created. |
| modified_date | The date the maintenance window was last modified. |

## Examples

### Ensure a window ID is available.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      its('window_id') { should eq 'WINDOW_ID' }
    end

### Ensure a name is available.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      its('name') { should eq 'WINDOW_NAME' }
    end

### Ensure a duration is `1`.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      its('duration') { should eq 1 }
    end

### Ensure a maintenance window is enabled.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      its('enabled') { should eq true }
    end

## Matchers

This Chef InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ssm_maintenance_window(window_id: 'WINDOW_ID')
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:GetMaintenanceWindowResult` action with `Effect` set to `Allow`.
