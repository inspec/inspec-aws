+++
title = "aws_iam_service_linked_role_deletion_status resource"

draft = false


[menu.aws]
title = "aws_iam_service_linked_role_deletion_status"
identifier = "inspec/resources/aws/aws_iam_service_linked_role_deletion_status resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_service_linked_role_deletion_status` InSpec audit resource to test the deletion status of a single AWS IAM service-linked role.

`deletion_task_id` _(required)_

The deletion task identifier.

For additional information, including details on parameters and properties, see the [AWS documentation on Service linked role deletion status](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-servicelinkedrole.html).

## Syntax

Ensure that a service-linked role deletion task exists.

```ruby
describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
  it { should exist }
end
```

## Parameters

`deletion_task_id` _(required)_

: The deletion task identifier.

## Properties

`status`
: The status of the deletion. Valid Values: `SUCCEEDED`, `IN_PROGRESS`, `FAILED`, `NOT_STARTED`.

## Examples

Ensure a service-linked role is deleted:

```ruby
describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
  its('status') { should eq 'SUCCEEDED' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a complete list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the Service Linked Role deletion task is available.

```ruby
describe aws_iam_service_linked_role_deletion_status(deletion_task_id: 'DELETION_TASK_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:GetServiceLinkedRoleDeletionStatusResponse" %}}
