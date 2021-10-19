---
title: About the aws_ssm_maintenance_window_target Resource
platform: aws
---

# aws_ssm_maintenance_window_target

Use the `aws_ssm_maintenance_window_target` InSpec audit resource to test properties of the singular resource of AWS SSM MaintenanceWindowTarget.

## Syntax

Ensure that the maintenance window target exists.

    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      it { should exist }
    end

## Parameters

`window_id` _(required)_

The ID of the maintenance window to register the target with.

`window_task_id` _(required)_

The ID of the target.

For additional information, see the [AWS documentation on AWS SSM MaintenanceWindowTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtarget.html).

## Properties

| Property | Description | 
| --- | --- | 
| window_id | The ID of the maintenance window to register the target with. | 
| window_target_id | The ID of the target. | 
| resource_type | The type of target that is being registered with the maintenance window. | 
| targets | The targets, either instances or tags. | 
| target_keys | User-defined criteria for sending commands that target instances that meet the criteria. | 
| target_values | User-defined criteria that maps to Key. | 
| owner_information | A user-provided value that will be included in any Amazon CloudWatch Events events that are raised while running tasks for these targets in this maintenance window. | 
| name | The name for the maintenance window target. | 
| description | A description for the target. | 

## Examples

### Ensure a maintenance window target id is available.
    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      its('description') { should eq 'MAINTENANCE_TARGET_DESCRIPTION' }
    end

### Ensure a maintenance window target id is available.
    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      its('window_target_id') { should eq 'WINDOW_TARGET_ID' }
    end

### Verify a maintenance resource type is `INSTANCE`.
    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      its('resource_type') { should eq 'INSTANCE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ssm_maintenance_window_target(window_id: 'WINDOW_ID', window_target_id: 'WINDOW_TARGET_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:DescribeMaintenanceWindowTargetsResult` action with `Effect` set to `Allow`.