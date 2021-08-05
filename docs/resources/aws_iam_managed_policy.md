---
title: About the aws_iam_managed_policy Resource
platform: aws
---

# aws\_iam\_policies

Use the `aws_iam_managed_policy` InSpec audit resource to test properties of  AWS IAM Managed Policy.

## Syntax

`aws_iam_managed_policy` Resource gets attributes related to a managed policy and allows testing of that collection.

    describe aws_iam_managed_policy(policy_arn: 'policy-arn') do
      its('policy_name') { should eq 'test-policy-1' }
    end



This resource allows filtering by scope.
To list only AWS managed policies, set `Scope` to `AWS`. To list only the customer managed policies in your AWS account, set `Scope` to `Local`. If scope is not supplied `ALL` policies are returned.

See also the [AWS documentation on IAM Policy](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html).

## Properties

|Property              | Description|
| ---                  | --- |
|arns                  | The ARN identifier of the specified policy. |
|policy\_id            | The policy ids. |
|policy\_name          | The policy names. |
|attachment\_count     | The count of attached entities for each policy. |
|attached\_group       | The list of group names of the groups attached to each policy. |
|default\_version\_id  | The 'default\_version\_id' value of each policy. |



## Examples

##### Ensure a policy exists
    describe aws_iam_managed_policy(policy_arn: 'policy-arn') do
      its('policy_name') { should eq 'test-policy-1' }
    end

##### Allow at most 100 IAM Policies on the account
    describe aws_iam_managed_policy do
      its('polict_id') { should eq ''test-policy-1''}
    end

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_iam_managed_policy(policy_arn: 'policy-arn').where( <property>: <value>) do
      it { should exist }
    end
      
    describe aws_iam_managed_policy(policy_arn: 'policy-arn').where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:ListPolicies` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
