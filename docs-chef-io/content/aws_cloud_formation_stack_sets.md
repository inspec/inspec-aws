+++
title = "aws_cloud_formation_stack_sets resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_cloud_formation_stack_sets"
identifier = "inspec/resources/aws/aws_cloud_formation_stack_sets resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloud_formation_stack_sets` InSpec audit resource to test properties of multiple AWS Cloud Formation stack sets.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS CloudFormation Stack Set.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudformation-stackset.html).

## Syntax

Ensure that the stack set exists.

```ruby
describe aws_cloud_formation_stack_sets do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`stack_set_names`
: The name of the stack set.

: **Field**: `stack_set_name`

`stack_set_ids`
: The ID of the stack set.

: **Field**: `stack_set_ids`

`descriptions`
: A description of the stack set that you specify when the stack set is created or updated.

: **Field**: `description`

`status`
: The status of the stack set.

: **Field**: `status`

`auto_deployments`
: Describes whether StackSets automatically deploys to Organizations accounts that are added to a target organizational unit (OU).

: **Field**: `auto_deployment`

`permission_models`
: Describes how the IAM roles required for stack set operations are created.

: **Field**: `permission_model`

`drift_statuses`
: Status of the stack set's actual configuration compared to its expected template and parameter configuration.

: **Field**: `drift_status`

`last_drift_check_timestamps`
: Most recent time when CloudFormation performed a drift detection operation on the stack set.

: **Field**: `last_drift_check_timestamp`

## Examples

Verify that a stack set ID is available:

```ruby
describe aws_cloud_formation_stack_sets do
  its('stack_set_ids') { should include 'STACK_SET_ID' }
end
```

Verify the descriptions of the stack set:

```ruby
describe aws_cloud_formation_stack_sets do
    its('descriptions') { should include 'DESCRIPTION_STRING'}
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_cloud_formation_stack_sets do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_cloud_formation_stack_sets do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFormation:Client:ListStackSetsOutput" %}}
