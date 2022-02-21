---
title: About the aws_ssm_maintenance_window_tasks Resource
platform: aws
---

# aws_ssm_maintenance_window_tasks

Use the `aws_ssm_maintenance_window_tasks` InSpec audit resource to test properties of the plural resource of AWS SSM MaintenanceWindowTask.

The AWS::SSM::MaintenanceWindowTask resource defines information about a task for an AWS Systems Manager maintenance window.

## Syntax

Ensure that the maintenance window task exists.

    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      it { should exist }
    end

## Parameters

`window_id` _(required)_

The ID of the maintenance window where the task is registered.

For additional information, see the [AWS documentation on AWS SSM MaintenanceWindowTask](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtask.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| window_ids | The ID of the maintenance window where the task is registered. | window_id |
| window_task_ids | The task ID. | window_task_id |
| task_arns | The resource that the task uses during execution. | task_arn |
| types | The type of task. | type |
| targets | The targets (either instances or tags). | targets |
| task_parameters | The parameters that should be passed to the task when it is run. |task_parameters |
| priorities | The priority of the task in the maintenance window. |priority |
| logging_infos | The logging information. | logging_info |
| service_role_arns | The Amazon Resource Name (ARN) of the Identity and Access Management (IAM) service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks. | service_role_arn |
| max_concurrencies | The maximum number of targets this task can be run for, in parallel. | max_concurrency |
| max_errors | The maximum number of errors allowed before this task stops being scheduled. |max_errors |
| names | The task name. |name |
| descriptions | A description of the task. |description |
| cutoff_behaviors | The specification for whether tasks should continue to run after the cutoff time specified in the maintenance windows is reached. |cutoff_behavior |

## Examples

### Ensure a window task id is available.
    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      its('window_task_ids') { should include 'WINDOW_TASK_ID' }
    end

### Verify the priority of the maintenance window
    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      its('priorities') { should include 1 }
    end

### Verify the type of the maintenance window
    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      its('types') { should include 'AUTOMATION' }
    end

### Verify the name of the maintenance window
    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      its('names') { should include 'WINDOW_TASK_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:DescribeMaintenanceWindowTasksResult` action with `Effect` set to `Allow`.