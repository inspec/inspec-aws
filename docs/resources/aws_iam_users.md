---
title: About the aws_iam_users Resource
platform: aws
---

# aws\_iam\_users

Use the `aws_iam_users` InSpec audit resource to test properties of some or all AWS IAM Users.


<br>

## Syntax

An `aws_iam_users` resource block returns all IAM Users and allows the testing of that group of Users.

    describe aws_iam_users do
      its('usernames') { should include 'payroll-admin' }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.


### has\_mfa\_enabled

      # Ensure there are no Users who do not have MFA enabled.
      
      describe aws_iam_users.where( has_mfa_enabled: false) do
        it { should_not exist }
      end
      
### has\_inline\_policies

    # Ensure there are no Users with inline policies
    
      describe aws_iam_users.where(has_inline_policies: true) do
        its('usernames') { should be_empty }
      end
      
### has\_attached\_policies

    # Ensure there are no Users with attached policies
    
      describe aws_iam_users.where(has_attached_policies: true) do
        its('usernames') { should be_empty }
      end
<br>

## Properties

* user_name 
* user_id
* user_arn 
* has_mfa_enabled
* access_keys
* has_console_password
* has_inline_policies
* inline_policy_names
* has_attached_policies 
* attached_policy_names
* attached_policy_arns

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the filtered IAM User(s) exists.

      describe aws_iam_users.where( <property>: <param>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions set to Allow: 
`iam:GetLoginProfile` 
`iam:ListUsers` 
`iam:ListMFADevices` 
`iam:ListAccessKeys` 
`iam:ListUserPolicies` 
`iam:ListAttachedUserPolicies` 
