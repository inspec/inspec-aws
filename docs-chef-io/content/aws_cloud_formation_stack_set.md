+++
title = "aws_cloud_formation_stack_set resource"

draft = false


[menu.aws]
title = "aws_cloud_formation_stack_set"
identifier = "inspec/resources/aws/aws_cloud_formation_stack_set resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloud_formation_stack_set` InSpec audit resource to test properties of the singular Cloud Formation stack set.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFormation stack set](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stackset.html).

## Syntax

Ensure that the stack set exists.

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`stack_set_name`
: The name that's associated with the stack set.

`stack_set_id`
: The ID of the stack set.

`description`
: A description of the stack set that you specify when the stack set is created or updated.

`status`
: The status of the stack set.

`template_body`
: The structure that contains the body of the template that was used to create or update the stack set.

`parameters`
: A list of input parameters for a stack set.

`parameter_keys`
: The key associated with the parameter.

`parameter_values`
: The input value associated with the parameter.

`use_previous_values`
: During a stack update, use the existing parameter value that the stack is using for a given parameter key. If you specify `true`, do not specify a parameter value.

`resolved_values`
: The value that corresponds to a Systems Manager parameter key.

`capabilities`
: The capabilities that are allowed in the stack set. Some stack set templates might include resources that can affect permissions in your Amazon Web Services account—for example, by creating new Identity and Access Management (IAM) users.

`tags`
: A list of tags that specify information about the stack set.

`stack_set_arn`
: The Amazon Resource Number (ARN) of the stack set.

`administration_role_arn`
: The Amazon Resource Number (ARN) of the IAM role used to create or update the stack set.

`execution_role_name`
: The name of the IAM execution role used to create or update the stack set.

`stack_set_drift_detection_details.drift_status`
: Status of the stack set's actual configuration compared to its expected template and parameter configuration.

`stack_set_drift_detection_details.drift_detection_status`
: The status of the stack set drift detection operation.

`stack_set_drift_detection_details.last_drift_check_timestamp`
: Most recent time when CloudFormation performed a drift detection operation on the stack set.

`stack_set_drift_detection_details.total_stack_instances_count`
: The total number of stack instances belonging to this stack set.

`stack_set_drift_detection_details.drifted_stack_instances_count`
: The number of stack instances that have drifted from the expected template and parameter configuration of the stack set.

`stack_set_drift_detection_details.in_sync_stack_instances_count`
: The number of stack instances which match the expected template and parameter configuration of the stack set.

`stack_set_drift_detection_details.in_progress_stack_instances_count`
: The number of stack instances that are currently being checked for drift.

`stack_set_drift_detection_details.failed_stack_instances_count`
: The number of stack instances for which the drift detection operation failed.

`auto_deployment.enabled`
: If set to `true`, StackSets automatically deploys additional stack instances to AWS Organizations accounts that are added to a target organization or organizational unit (OU) in the specified Regions.

`auto_deployment.retain_stacks_on_account_removal`
: If set to `true`, stack resources are retained when an account is removed from a target organization or OU. If set to `false`, stack resources are deleted. Specify only if `Enabled` is set to True.

`permission_model`
: Describes how the IAM roles required for stack set operations are created.

`organizational_unit_ids`
: The organization root ID or organizational unit (OU) IDs that you specified for deployment targets.

## Examples

Ensure a stack set ID is available:

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
  its('stack_set_id') { should eq 'StackSetId' }
end
```

Verify the description of the stack set:

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
    its('description') { should eq 'test-description'}
end
```

Verify the parameter keys of the stack set:

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
    its('parameter_keys') { should include 'ParameterKey'}
end
```

Verify the in-progress stack instances count of the stack set:

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
    its('stack_set_drift_detection_details.in_progress_stack_instances_count') { should eq 1}
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloud_formation_stack_set(stack_set_name: "STACK_SET_NAME") do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFormation:Client:DescribeStackSetOutput" %}}
