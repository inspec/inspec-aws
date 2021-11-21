---
title: About the aws_iam_groups Resource
platform: aws
---

# aws\_iam\_groups

Use the `aws_iam_groups` InSpec audit resource to test properties of a collection of IAM groups.

## Syntax

An `aws_iam_groups` resource block identifies a group by group name.

    describe aws_iam_groups('mygroup') do
      it { should exist }
    end

    # Hash syntax for group name
    describe aws_iam_groups(group_name: 'mygroup') do
      it { should exist }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on IAM Groups](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_groups.html).

## Properties

|Property              | Description|
| ---                  | --- |
|group\_names          | The group name. |
|group\_ids            | The group ID. |
|arns                  | The Amazon Resource Name of the group. |
|users                 | Array of users associated with the group.  |
|entries               | Provides access to the raw results of the query, which can be treated as an array of hashes. |
|has\_inline\_policies | Boolean indicating whether or not the group has policies applied to it. |
|inline\_policy\_names | The names of the policies (if any) which are applied to the group. |


## Examples

##### Ensure group contains a certain user
    describe aws_iam_groups do
      it                 { should exist }
      its('group_names') { should include 'prod-access-group' }
    end

##### Ensure there are no groups with inline policies.

    describe aws_iam_groups.where(has_inline_policies: true) do
      its('group_names') { should be_empty }
    end

## Matchers

### exist

The control will pass if a group with the given group name exists.

    describe aws_iam_groups do
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:ListGroupsResponse` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
