---
title: About the aws_iam_managed_policy Resource
platform: aws
---

# aws\_iam\_policies

Use the `aws_iam_managed_policy` InSpec audit resource to test properties of an AWS IAM managed policy.

## Syntax

The `aws_iam_managed_policy` resource returns an IAM managed policy and allows testing of that policy.

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN') do
      its('policy_name') { should eq 'POLICY_NAME' }
    end

This resource allows filtering by scope.
To list only AWS-managed policies, set `Scope` to `AWS`. To list only the customer-managed policies in your AWS account, set `Scope` to `Local`. If you do not specify the scope, `ALL` policies are returned.

See the [AWS documentation on IAM Policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html) for additional information.

## Parameters

`policy_arn`

The ARN of the AWS IAM managed policy.

## Properties

|Property               | Description|
| ---                   | --- |
|arn                    | The ARN identifier of the specified policy. |
|policy\_id             | The stable and unique string identifying the policy. |
|policy\_name           | The friendly name (not ARN) identifying the policy.|
|attachment\_count      | The count of attached entities for each policy. |
|attached\_group        | The list of group names of the groups attached to each policy. |
|default\_version\_id   | The identifier for the default version of the policy. |

## Examples

### Test that a specific policy name exists

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN') do
      its('policy_name') { should eq 'POLICY_NAME' }
    end

### Test that a specific policy ID exists

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN') do
      its('polict_id') { should eq 'POLICY_ID'}
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe method returns at least one result.

Use `should` to test an entity that should exist.

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN').where( PROPERTY: PROPERTY_VALUE ) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_iam_managed_policy(policy_arn: 'POLICY_ARN').where( PROPERTY: PROPERTY_VALUE ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:ListPolicies` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
