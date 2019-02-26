---
title: About the aws_sts_caller_identity Resource
platform: aws
---

# aws\_sts\_caller\_identity

Use the `aws_sts_caller_identity` InSpec audit resource to test properties of AWS IAM identity whose credentials are used in the current InSpec scan.

<br>

## Syntax

An `aws_sts_caller_identity` resource block may be used to perform tests on details of the AWS credentials being used in the current Inspec scan. You can also test if the credentials belong to a GocCloud account or not.
   
    describe aws_sts_caller_identity do
      it { should exist }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

    # Check that the credentials used to run the scan is correct
    
        describe aws_sts_caller_identity do
          its("arn") { should match "arn:aws:iam::.*:user/service-account-inspec" }
        end

    # Test if the account belongs to GovCloud
    
        describe aws_sts_caller_identity do
          it { should be_govcloud }
        end


    # Skip a test if we are using GovCloud
    
        if aws_sts_caller_identity.govcloud?
          describe 'Skipping Root User MFA check as we are on GovCloud' do
            skip
          end
        else
          describe aws_iam_root_user do
            it { should have_mfa_enabled }  
          end
        end

<br>

## Properties

* arn - The `arn` property identifies the AWS ARN of the credentials being used in the current InSpec scan.

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_govcloud

The `be_govcloud` matcher tests if the account is a 'GovCloud' AWS Account.

    describe aws_sts_caller_identity do
        it { should_not be_govcloud }
    end