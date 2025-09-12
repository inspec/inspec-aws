+++
title = "aws_ssm_maintenance_window_tasks resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_maintenance_window_tasks"
identifier = "inspec/resources/aws/aws_ssm_maintenance_window_tasks resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_maintenance_window_tasks` InSpec audit resource to test properties of multiple AWS Systems Manager (SSM) maintenance window tasks.

The `AWS::SSM::MaintenanceWindowTask` resource defines information about a task for an AWS Systems Manager maintenance window.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM MaintenanceWindowTask](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-maintenancewindowtask.html).

## Syntax

Ensure that the maintenance window task exists.

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  it { should exist }
end
```

## Parameters

`window_id` _(required)_

: The ID of the maintenance window where the task is registered.

## Properties

`window_ids`
: The ID of the maintenance window where the task is registered.

: **Field**: `window_id`

`window_task_ids`
: The task ID.

: **Field**: `window_task_id`

`task_arns`
: The resource that the task uses during execution.

: **Field**: `task_arn`

`types`
: The type of task.

: **Field**: `type`

`targets`
: The targets (either instances or tags).

: **Field**: `targets`

`task_parameters`
: The parameters that should be passed to the task when it is run.

: **Field**: `task_parameters`

`priorities`
: The priority of the task in the maintenance window.

: **Field**: `priority`

`logging_infos`
: The logging information.

: **Field**: `logging_info`

`service_role_arns`
: The Amazon Resource Name (ARN) of the Identity and Access Management (IAM) service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks.

: **Field**: `service_role_arn`

`max_concurrencies`
: The maximum number of targets this task can be run for, in parallel.

: **Field**: `max_concurrency`

`max_errors`
: The maximum number of errors allowed before this task stops being scheduled.

: **Field**: `max_errors`

`names`
: The task name.

: **Field**: `name`

`descriptions`
: A description of the task.

: **Field**: `description`

`cutoff_behaviors`
: The specification for whether tasks should continue to run after the cutoff time specified in the maintenance windows is reached.

: **Field**: `cutoff_behavior`

## Examples

Ensure a window task ID is available:

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  its('window_task_ids') { should include 'WINDOW_TASK_ID' }
end
```

Verify the priority of the maintenance window:

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  its('priorities') { should include 1 }
end
```

Verify the type of the maintenance window:

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  its('types') { should include 'AUTOMATION' }
end
```

Verify the name of the maintenance window:

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  its('names') { should include 'WINDOW_TASK_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
aws_ssm_maintenance_window_tasks(window_id: 'WINDOW_ID')
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribeMaintenanceWindowTasksResult" %}}
