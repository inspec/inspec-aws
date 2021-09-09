---
title: About the aws_iam_managed_policies Resource
platform: aws
---

# aws\_iam\_managed\_policies

Use the `aws_iam_managed_policies` InSpec audit resource to test properties of a collection of AWS IAM policies.

## Syntax

The `aws_iam_managed_policies` resource returns a collection of IAM managed policies and allows testing of that collection.

    describe aws_iam_managed_policies do
      its('policy_names') { should include('POLICY_NAME') }
    end

This resource allows filtering by scope.
To list only AWS managed policies, set `Scope` to `AWS`. To list only the customer managed policies in your AWS account, set `Scope` to `Local`. If scope is not supplied `ALL` policies are returned.

See the [AWS documentation on IAM Policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html) for additional information.

## Parameters

This resource does not require any parameters.

## Properties

|Property              | Description| Field
| ---                  | --- | --- |
|arns                  | A list of the ARN identifiers of the policies. | arn |
|policy\_ids           | A list of the stable and unique strings identifying the policies. | policy_id |
|policy\_names         | A list of the friendly names (not ARN) identifying the policies.| policy_name |
|attachment\_counts    | A list of the counts of attached entities for each policy. | attachment_count |
|attached_groups      | A list of the list of group names of the groups attached to each policy. | attached_group |
|default\_version\_ids | A list of the identifier for the default version of the policy. | default\_version\_id |

## Examples

### Ensure a specific policy exists

    describe aws_iam_managed_policies do
      its('policy_names') { should include('POLICY_NAME') }
    end

### Allow at most 100 IAM Policies on the account

    describe aws_iam_managed_policies do
      its('polict_ids.count') { should be <= 100}
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.

    describe aws_iam_managed_policies.where( PROPERTY: PROPERTY_VALUE) do
      it { should exist }
    end

Use `should_not` to test the entity should not exist.

    describe aws_iam_managed_policies.where( PROPERTY: PROPERTY_VALUE) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:ListPolicies` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
