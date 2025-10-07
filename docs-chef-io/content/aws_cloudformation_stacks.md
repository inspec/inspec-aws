+++
title = "aws_cloudformation_stacks resource"

draft = false


[menu.aws]
title = "aws_cloudformation_stacks"
identifier = "inspec/resources/aws/aws_cloudformation_stacks resource"
parent = "inspec/resources/aws"
+++

Use the `aws_cloudformation_stacks` InSpec audit resource to test properties of an AWS CloudFormation stack in bulk.

## Syntax

Ensure that `aws_cloudformation_stacks` exists

```ruby
describe aws_cloudformation_stacks do
  it { should exist }
end
```

See the [AWS documentation on CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/Welcome.html) for additional information.

## Parameters

This resource does not require any parameters.

## Properties

`stack_name`
: The name associated with the stack.

`stack_id`
: Unique identifier of the stack.

`creation_time`
: The time at which the stack was created.

`notification_arns`
: SNS topic ARNs to which stack related events are published.

`role_arn`
: The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that is associated with the stack.

`parent_id`
: For nested stacks--stacks created as resources for another stack--the stack ID of the direct parent of this stack.

`root_id`
: For nested stacks--stacks created as resources for another stack--the stack ID of the top-level stack to which the nested stack ultimately belongs.

## Examples

Request the names of all CloudFormation stacks, then test in-depth using the aws_cloudformation_stack resource:

```ruby
aws_cloudformation_stacks.names.each do |stack|
  describe aws_cloudformation_stack(stack_name: stack) do
    it                   { should exist }
    its ('notification_arns')   { should_not be_empty}
    its ('stack_status') { should eq 'CREATE_COMPLETE' }
  end
end
```

Request the names of all CloudFormation stacks created at a certain time, then test in-depth using the aws_cloudformation_stack resource:

```ruby
aws_cloudformation_stacks.where(creation_time: 'creation time') do |stack|
  describe aws_cloudformation_stack(stack) do
    it  { should exist }
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

```ruby
describe aws_cloudformation_stacks do
  it { should exist }
end
```

Use `should_not` to test that an entity should not exist.

```ruby
describe aws_cloudformation_stacks do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="CloudFormation:Client:DescribeStacksOutput" %}}

You can find detailed documentation at [Authentication and Access Control for CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
