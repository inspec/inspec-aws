---
title: About the aws_iam_policies Resource
platform: aws
---

# aws\_iam\_policies

Use the `aws_iam_policies` InSpec audit resource to test properties of some or all AWS IAM Policies.

A policy is an entity in AWS that, when attached to an identity or resource, defines their permissions. AWS evaluates these policies when a principal, such as a user, makes a request. Permissions in the policies determine if the request is allowed or denied.

Each IAM Policy is uniquely identified by either its `policy_name` or `arn`.

<br>

## Syntax

`aws_iam_policies` Resource returns a collection of IAM Policies and allows testing of that collection.

    # Verify the policy specified by the policy name is included in IAM Policies in the AWS account.
    describe aws_iam_policies do
      its('policy_names') { should include('test-policy-1') }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

...

<br>

## Properties

* `arns`
* `entries`
* `policy_names`

<br>

## Property Examples

### policy\_names

Provides a list of policy names for all IAM Policies in the AWS account.

    describe aws_iam_policies do
      its('policy_names') { should include('test-policy-1') }
    end

### arns

Provides a list of policy arns for all IAM Policies in the AWS account.

    describe aws_iam_policies do
      its('arns') { should include('arn:aws:iam::aws:policy/test-policy-1') }
    end

### entries

Provides access to the raw results of the query. This can be useful for checking counts and other advanced operations.

    # Allow at most 100 IAM Policies on the account
    describe aws_iam_policies do
      its('entries.count') { should be <= 100}
    end

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The control will pass if the filter returns at least one result. Use `should_not` if you expect zero matches.

    # Verify that at least one IAM Policies exists.
    describe aws_iam_policies
      it { should exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam:ListPolicies` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
