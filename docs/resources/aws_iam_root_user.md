---
title: About the aws_iam_root_user Resource
platform: aws
---

# aws\_iam\_user

Use the `aws_iam_root_user` InSpec audit resource to test properties of an AWS IAM Root User.

<br>

## Availability

### Installation

    ...
    
## Syntax

An `aws_iam_root_user` resource block declares the tests for a single AWS IAM User by user name.

    describe aws_iam_root_user do
        it { should     have_mfa_enabled }
        it { should     have_virtual_mfa_enabled }
        it { should_not have_access_key }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

    # Test that an IAM Root User has MFA enabled

    describe aws_iam_root_user do
      it { should have_mfa_enabled }
    end


    # Test that an IAM Root User does not have an access key

    describe aws_iam_root_user do
        it { should_not have_access_key }
    end

<br>

## Properties

* summary_account - A hash containing a summary of the Root User's account. Keys, and more details, can be found on the [API Documentation page](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountSummary.html).
* virtual_devices - A list of the virtual MFA devices in the AWS account.

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exists

The `exists` matcher tests if the described IAM Root User exists.

    it { should exist }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow: 
`iam:GetAccountSummary` 
`iam:ListVirtualMFADevices` 
