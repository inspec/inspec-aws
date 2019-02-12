---
title: About the aws_iam_access_key Resource
platform: aws
---

# aws\_iam\_access\_key

Use the `aws_iam_access_key` InSpec audit resource to test properties of a single AWS IAM Access Key.

<br>

## Availability

### Installation

    ...
    
## Syntax

An `aws_iam_access_key` resource allows the testing of a single AWS IAM Access Key. The Access key can be retrieved by ID, or by Username.

    describe aws_iam_access_key(access_key_id: 'AKIA1111111111111111') do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that an IAM Access Key has been used

    describe aws_iam_access_key(access_key_id: 'AKIA1111111111111111') do
      it { should exist }
      it('last_used_date')  { should_not be_nil }
    end

### Test that an IAM Access Key for a specific user exists

      describe aws_iam_access_key(username: 'psmith', id: 'AKIA1111111111111111') do
        it { should exist }
      end

<br>

## Properties

* access_key_id 
* create_date
* status
* username
* last_used_date

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the described IAM Access Key exists.

    it { should exist }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow: 
`iam:ListAccessKeys` 
`iam:GetAccessKeyLastUsed` 

