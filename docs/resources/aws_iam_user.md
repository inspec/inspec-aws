---
title: About the aws_iam_user Resource
platform: aws
---

# aws\_iam\_user

Use the `aws_iam_user` InSpec audit resource to test properties of a single AWS IAM User.

<br>
    
## Syntax

An `aws_iam_user` resource block declares the tests for a single AWS IAM User by user name.

    describe aws_iam_user(user_name: 'psmith') do
      it { should exist }
      it { should have_mfa_enabled }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that an IAM user does not exist

    describe aws_iam_user(user_name: 'invalid-user') do
      it { should_not exist }
    end

### Test that an IAM user has MFA enabled

    describe aws_iam_user('psmith') do
      it { should exist }
      it { should have_mfa_enabled }
    end

<br>

## Properties

* username 
* user_id
* user_arn 
* has_mfa_enabled
* access_keys
* has_console_password
* inline_policy_names
* attached_policy_names
* attached_policy_arns

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the described IAM User exists.

    it { should exist }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow: 
`iam:GetUser` 
`iam:GetLoginProfile` 
`iam:ListMFADevices` 
`iam:ListAccessKeys` 
`iam:ListUserPolicies` 
`iam:ListAttachedUserPolicies` 

