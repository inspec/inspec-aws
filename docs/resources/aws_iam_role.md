---
title: About the aws_iam_role Resource
platform: aws
---

# aws\_iam\_role

Use the `aws_iam_role` InSpec audit resource to test properties of an AWS IAM Role.

<br>

## Availability

### Installation

    ...
    
## Syntax

An `aws_iam_role` resource block declares the tests for a single AWS IAM Role by Role Name.

    describe aws_iam_role(role_name: 'my-role') do
        it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

    # Test that an IAM Role exists
      
    describe aws_iam_role(role_name: aws_iam_role_name) do
        it               { should exist }
        its('role_name') { should eq aws_iam_role_name }
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

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the described IAM Role exists.

    it { should exist }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow: 
`iam:GetRole` 
