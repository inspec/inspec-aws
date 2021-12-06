---
title: About the aws_cloudformation_stacks Resource
platform: aws
---

# aws\_cloudformation\_stacks

Use the `aws_cloudformation_stacks` InSpec audit resource to test properties of an AWS CloudFormation stack in bulk.

## Syntax

Ensure that `aws_cloudformation_stacks` exists

    describe aws_cloudformation_stacks do
      it { should exist }
    end

See the [AWS documentation on CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/Welcome.html) for additional information.

## Parameters

This resource does not expect any parameters.

## Properties

|Property                        | Description|
| ---                            | --- |
|stack\_name                     | The name associated with the stack. |
|stack\_id                       | Unique identifier of the stack. |
|creation\_time                  | The time at which the stack was created. |
|notification\_arns              | SNS topic ARNs to which stack related events are published. |
|role\_arn                       | The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that is associated with the stack.  |
| parent\_id                      | For nested stacks--stacks created as resources for another stack--the stack ID of the direct parent of this stack. |
|root\_id                        | For nested stacks--stacks created as resources for another stack--the stack ID of the top-level stack to which the nested stack ultimately belongs. |

## Examples

### Request the names of all CloudFormation stacks, then test in-depth using the aws_cloudformation_stack resource

    aws_cloudformation_stacks.names.each do |stack|
      describe aws_cloudformation_stack(stack_name: stack) do
        it                   { should exist }
        its ('notification_arns')   { should_not be_empty}
        its ('stack_status') { should eq 'CREATE_COMPLETE' }
      end
    end

### Request the names of all CloudFormation stacks created at a certain time, then test in-depth using the aws_cloudformation_stack resource

    aws_cloudformation_stacks.where(creation_time: 'creation time') do |stack|
      describe aws_cloudformation_stack(stack) do
        it  { should exist }
      end
    end

## Matchers

This InSpec audit resource has no special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

    describe aws_cloudformation_stacks do
      it { should exist }
    end

Use `should_not` to test that an entity should not exist.

    describe aws_cloudformation_stacks do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `CloudFormation:Client:DescribeStacksOutput` action set to Allow.

You can find detailed documentation at [Authentication and Access Control for CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
