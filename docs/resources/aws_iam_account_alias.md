---
title: About the aws_iam_account_alias Resource
platform: aws
---

# aws\_iam\_account\_alias

Use the `aws_iam_account_alias` InSpec audit resource to test properties of the AWS IAM account alias.

<br>

## Syntax

An `aws_iam_account_alias` resource block may be used to perform tests on details of the AWS account alias.
   
    describe aws_iam_account_alias do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

    # Check that the account alias has not be set
    
      describe aws_iam_account_alias do
        it { should_not exist }
      end

    # Test if the account alias starts with expected prefix
    
      describe aws_iam_account_alias do
        it { should exist }
        its('alias') { should match /^fancy-/ }
      end

<br>

## Properties

* alias - The `alias` property identifies the AWS account alias.

## Matchers

### exist

The control will pass if an account alias has been created.

    describe aws_iam_account_alias do
      it { should exist }
    end