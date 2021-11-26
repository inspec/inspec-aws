---
title: About the aws_ssm_maintenance_window_task Resource
platform: aws
---

# aws_ssm_maintenance_window_task

Use the `aws_ssm_maintenance_window_task` InSpec audit resource to test properties of the singular resource of AWS SSM MaintenanceWindowTask.

The AWS::SSM::MaintenanceWindowTask resource defines information about a task for an AWS Systems Manager maintenance window.

## Syntax

Ensure that the maintenance window task exists.

    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      it { should exist }
    end

## Parameters

`window_id` _(required)_

The ID of the maintenance window where the task is registered.

`window_task_id` _(required)_

The task ID.

For additional information, see the [AWS documentation on AWS SSM MaintenanceWindowTask](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtask.html).

## Properties

| Property | Description | 
| --- | --- |
| window_id | The ID of the maintenance window where the task is registered. |
| window_task_id | The task ID. |
| task_arn | The resource that the task uses during execution. |
| type | The type of task. |
| targets | The targets (either instances or tags). |
| target_keys | User-defined criteria for sending commands that target instances that meet the criteria. |
| target_values | User-defined criteria that maps to Key. |
| task_parameters | The parameters that should be passed to the task when it is run. |
| priority | The priority of the task in the maintenance window. |
| logging_info.s3_bucket_name | The name of an S3 bucket where execution logs are stored. |
| logging_info.s3_key_prefix | The S3 bucket subfolder. |
| logging_info.s3_region | The Amazon Web Services Region where the S3 bucket is located. |
| service_role_arn | The Amazon Resource Name (ARN) of the Identity and Access Management (IAM) service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks. |
| max_concurrency | The maximum number of targets this task can be run for, in parallel. |
| max_errors | The maximum number of errors allowed before this task stops being scheduled. |
| name | The task name. |
| description | A description of the task. |
| cutoff_behavior | The specification for whether tasks should continue to run after the cutoff time specified in the maintenance windows is reached. |

## Examples

### Ensure a window task id is available.
    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      its('window_task_id') { should eq 'WINDOW_TASK_ID' }
    end

### Verify the priority of the maintenance window
    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      its('priority') { should eq 1 }
    end

### Verify the type of the maintenance window
    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      its('type') { should eq 'AUTOMATION' }
    end

### Verify the name of the maintenance window
    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      its('name') { should eq 'WINDOW_TASK_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    aws_ssm_maintenance_window_task(window_id: 'WINDOW_ID', window_task_id: 'WINDOW_TASK_ID')
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:DescribeMaintenanceWindowTasksResult` action with `Effect` set to `Allow`.