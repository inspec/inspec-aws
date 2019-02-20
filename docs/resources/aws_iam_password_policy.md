---
title: About the aws_iam_password_policy Resource
platform: aws
---

# aws\_iam\_password_policy

Use the `aws_iam_password_policy` InSpec audit resource to test properties of an AWS IAM Password Policy.

<br>

## Syntax

An `aws_iam_password_policy` resource block declares the tests for an AWS IAM Password Policy.

    describe aws_iam_password_policy do
      it { should exist }
      it { should have_mfa_enabled }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a Password Policy meets your company's requirements.

    describe aws_iam_password_policy do
      its('minimum_password_length') { should be > 8 }
      it                             { should require_uppercase_characters }
      it                             { should require_lowercase_characters }
      it                             { should require_numbers }
    end

### Test that users can change their own passwords 

    describe aws_iam_password_policy do
      it { should allow_users_to_change_password }
    end
    
<br>

## Properties

* `minimum_password_length`
* `max_password_age_in_days`
* `number_of_passwords_to_remember`

Properties are exposed via the matchers described below.

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### prevent_password_reuse
    it { should prevent_password_reuse }
    
### expire_passwords 
    it { should expire_passwords }

### require_numbers   
    it { should require_numbers }

### require_symbols
    it { should require_symbols }

### require_lowercase_characters
    it { should require_lowercase_characters }

### require_uppercase_characters
    it { should require_uppercase_characters}

### allow_users_to_change_passwords
    it { should allow_users_to_change_password }

### exists
    it { should exist }
    
All matchers can use the inverse `should_not` predicate.

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow: `iam:GetAccountPasswordPolicy`
