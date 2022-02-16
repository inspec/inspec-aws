---
title: About the aws_iam_managed_policy Resource
platform: aws
---

# aws_iam_managed_policy

Use the `aws_iam_managed_policy` InSpec audit resource to test the properties of an AWS IAM managed policy.

## Syntax

The `aws_iam_managed_policy` resource returns an IAM managed policy and allows testing of that policy.

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN') do
      its('policy_name') { should eq 'POLICY_NAME' }
    end


See the [AWS documentation on IAM Managed Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-managedpolicy.html) for additional information.

## Parameters

`policy_arn` _(required)_

The ARN of the AWS IAM managed policy.

## Properties

| Property | Description |
| :---: | :--- |
|arn                    | The ARN identifier of the specified policy.                    |
|policy_id             | The stable and unique string identifying the policy.           |
|policy_name           | The friendly name (not ARN) identifying the policy.            |
|attachment_count      | The count of attached entities for each policy.                |
|attached_group        | The list of group names of the groups attached to each policy. |
|default_version_id   | The identifier for the default version of the policy.          |

## Examples

### Test that a specific policy name exists

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN') do
      its('policy_name') { should eq 'POLICY_NAME' }
    end

### Test that a specific policy ID exists

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN') do
      its('policy_id') { should eq 'POLICY_ID'}
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control passes if the describe method returns at least one result.

Use `should` to test an entity that should exist.

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN').where( PROPERTY: PROPERTY_VALUE ) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN').where( PROPERTY: PROPERTY_VALUE ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:ListPolicies` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
