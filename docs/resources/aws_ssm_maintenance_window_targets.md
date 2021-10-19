---
title: About the aws_ssm_maintenance_window_targets Resource
platform: aws
---

# aws_ssm_maintenance_window_targets

Use the `aws_ssm_maintenance_window_targets` InSpec audit resource to test properties of the plural resource of AWS SSM MaintenanceWindowTarget.

## Syntax

Ensure that the maintenance window target exists.

    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      it { should exist }
    end

## Parameters

`window_id` _(required)_

The ID of the maintenance window to register the target with.

For additional information, see the [AWS documentation on AWS SSM MaintenanceWindowTarget](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtarget.html).

## Properties

| Property | Description | 
| --- | --- | 
| window_ids | The ID of the maintenance window to register the target with. | window_id |
| window_target_ids | The ID of the target. | window_target_id |
| resource_types | The type of target that is being registered with the maintenance window. | resource_type |
| targets | The targets, either instances or tags. | targets |
| owner_informations | A user-provided value that will be included in any Amazon CloudWatch Events events that are raised while running tasks for these targets in this maintenance window. | owner_information |
| names | The name for the maintenance window target. | name |
| descriptions | A description for the target. | description |

## Examples

### Ensure a maintenance window target id is available.
    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      its('descriptions') { should include 'MAINTENANCE_TARGET_DESCRIPTION' }
    end

### Ensure a maintenance window target id is available.
    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      its('window_target_ids') { should include 'WINDOW_TARGET_ID' }
    end

### Verify a maintenance resource type is `INSTANCE`.
    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      its('resource_types') { should include 'INSTANCE' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ssm_maintenance_window_targets(window_id: 'WINDOW_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:DescribeMaintenanceWindowTargetsResult` action with `Effect` set to `Allow`.