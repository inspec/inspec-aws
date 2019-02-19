---
title: About the aws_iam_roles Resource
platform: aws
---

# aws\_iam\_roles

Use the `aws_iam_roles` InSpec audit resource to test properties of some or all AWS IAM Roles.


<br>

## Syntax

An `aws_iam_roles` resource block returns all IAM Roles and allows the testing of that group of Roles.

    describe aws_iam_roles do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.


    # Ensure the Role 'RDS-RW' exists.
      
      describe aws_iam_roles do
        its('role_names') { should include 'RDS-RW' }
      end
      
      
    # Ensure no Roles have `max_session_duration` greater or equal to 2hrs.
      
      describe aws_iam_roles.where{ max_session_duration >= (60*120) } do
        it { should_not exist }
      end
      
<br>

## Properties

* role_name 
* role_id 
* description 
* arn 
* path 
* create_date
* assume_role_policy_document 
* max_session_duration
* permissions_boundary_type 
* permissions_boundary_arn

<br>

## Matchers

For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the filtered IAM User(s) exists.

      describe aws_iam_roles.where( <property>: <param>) do
        it { should exist }
      end
You may also use `it { should_not exist }`.
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions set to Allow: 
`iam:ListRoles` 
