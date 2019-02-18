---
title: About the aws_iam_group Resource
platform: aws
---

# aws\_iam\_group

Use the `aws_iam_group` InSpec audit resource to test properties of a single IAM group.

To test properties of multiple or all groups, use the `aws_iam_groups` resource.

<br>

## Syntax

An `aws_iam_group` resource block identifies a group by group name.

    # Find a group by group name
    describe aws_iam_group('mygroup') do
      it { should exist }
    end

    # Hash syntax for group name
    describe aws_iam_group(group_name: 'mygroup') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

As this is the initial release of `aws_iam_group`, its limited functionality precludes examples.

<br>

## Properties

### users

Check a specific User is included in a group

    describe aws_iam_group('mygroup')
      its('users') { should include 'iam_user_name' }
    end

<br>

## Matchers

### exists

The control will pass if a group with the given group name exists.

    describe aws_iam_group('mygroup')
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:GetGroup` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
