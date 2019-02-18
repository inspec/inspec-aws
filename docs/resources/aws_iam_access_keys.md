---
title: About the aws_iam_access_keys Resource
platform: aws
---

# aws\_iam\_access\_keys

Use the `aws_iam_access_keys` InSpec audit resource to test properties of some or all AWS IAM Access Keys.


<br>

## Syntax

An `aws_iam_access_keys` resource block returns all IAM Access Keys and allows the testing of that group of Access Keys.

  # Get Active keys
      describe aws_iam_access_keys do
        it                    { should exist }
        its('access_key_ids') { should include 'AKIA1111111111111111' }
      end

<br>

## Examples

The following examples show how to use this InSpec audit resource.


    # Test all Active keys
 
    describe aws_iam_access_keys.where(active: true) do
      it { should exist }
      its('access_key_ids') { should include 'AKIA1111111111111111' }
    end
<br>

    # Ensure a User has no Access Keys
    
    describe aws_iam_access_keys.where(username: 'untrusted-account') do
      it { should_not exist }
    end
<br>

## Properties

* access_key_id
* create_date
* created_days_ago
* created_with_user
* created_hours_ago
* username
* active
* inactive
* last_used_date
* last_used_hours_ago
* last_used_days_ago
* ever_used
* never_used
* user_created_date

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the filtered IAM Access Key(s) exists.

      describe aws_iam_access_keys.where( <property>: <param>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions set to Allow: 
`iam:GetUser` 
`iam:GetAccessKeyLastUsed` 
`iam:ListUsers` 
`iam:ListAccessKeys` 
