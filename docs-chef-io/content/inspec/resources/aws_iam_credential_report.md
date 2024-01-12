+++
title = "aws_iam_credential_report Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_credential_report"
identifier = "inspec/resources/aws/aws_iam_credential_report Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_credential_report` InSpec audit resource to list all users in the AWS account and the status of their credentials.

For additional information, including details on parameters and properties, see the [AWS documentation on Credential Reports](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_getting-report.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

Use the AWS Credential Report to query data about users' access credential configurations and the timestamps at which credentials were last used.

```ruby
describe aws_iam_credential_report.where(user: username) do
    its('mfa_active') { should eq true }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`user`
: List of the usernames (not full ARNs) associated with the account.

`arn`
: List of the full ARNs of users associated with the account.

`user_creation_time`
: List of the timestamps when the user was created, in ISO 8601 date-time format.

`password_enabled`
: List of booleans for whether each user has a password enabled for the AWS console. The value for the AWS account root user is always "not_supported".

`password_last_used`
: List of the timestamps when the user last logged in using the password, in ISO 8601 date-time format (value will be 'N/A' for a user with no password or a user who has never logged in with their password).

`password_last_changed`
: List of the timestamps when the user last changed their password, in ISO 8601 date-time format (value will be 'N/A' for a user with no password or a user who has never logged in with their password). The value for the AWS account root user is always "not_supported".

`password_next_rotation`
: List of the dates and times (in ISO 8601 date-time format) at which each user will be forced to change the password, if the user is required to rotate passwords (value will be 'N/A' for a user with no password or a user who has never logged in with their password). The value for the AWS account root user is always "not_supported".

`mfa_active`
: List of booleans for whether each user has a multi-factor authentication (MFA) device enabled.

`access_key_1_active`
: List of booleans for whether each user has an active access key in their first key slot.

`access_key_1_last_rotated`
: List of dates and times (in ISO 8601 date-time format) for when each user's first access key was last rotated (value will be 'N/A' for users without an access key in the first slot, if the key has never been used).

`access_key_1_last_used_date`
: List of dates and times (in ISO 8601 date-time format) for when each user's first access key was last used to sign an AWS API request (value will be 'N/A' for users without an access key in the first slot, or if the key has never been used).

`access_key_1_last_used_region`
: List of AWS regions in which each user's first access key was last used to sign an AWS API request (value will be 'N/A' for users without an access key in the first slot, if the key has never been used, or if the last service this key was used for is not region-specific).

`access_key_1_last_used_service`
: List of AWS services for which each user's first access key was last used to sign an AWS API request (value will be 'N/A' for users without an access key in the first slot, or if the key has never been used).

`access_key_2_active`
: List of booleans for whether each user has an active access key in their second key slot.

`access_key_2_last_rotated`
: List of dates and times (in ISO 8601 date-time format) for when each user's second access key was last rotated (value will be 'N/A' for users without an access key in the second slot, if the key has never been used).

`access_key_2_last_used_date`
: List of dates and times (in ISO 8601 date-time format) for when each user's second access key was last used to sign an AWS API request (value will be 'N/A' for users without an access key in the second slot, or if the key has never been used).

`access_key_2_last_used_region`
: List of AWS regions in which each user's second access key was last used to sign an AWS API request (value will be 'N/A' for users without an access key in the second slot, if the key has never been used, or if the last service this key was used for is not region-specific).

`access_key_2_last_used_service`
: List of AWS services for which each user's second access key was last used to sign an AWS API request (value will be 'N/A' for users without an access key in the second slot, or if the key has never been used).

`cert_1_active`
: List of booleans for whether each user has an X.509 signing certificate and the certificate is active.

`cert_1_last_rotated`
: List of dates and times (in ISO 8601 date-time format) for when each user's signing certificate was created or last changed (value will be 'N/A' for users with no active certificate).

`cert_2_active`
: List of booleans for whether each user has a second X.509 signing certificate and the certificate is active.

`cert_2_last_rotated`
: List of dates and times (in ISO 8601 date-time format) for when each user's second signing certificate was created or last changed (value will be 'N/A' for users with no active certificate or only one active certificate).

## Examples

Determine if the root user has MFA enabled:

```ruby
describe aws_iam_credential_report.where(user: '<root_account>').entries.first do
    its('mfa_active') { should eq true }
end
```

Ensuring that all users with passwords have used them within the last month:
```ruby 
aws_iam_credential_report.where(password_enabled: true).entries.each do |user|
    describe "The user (#{user.user})" do
        subject { ((Time.current - user.password_last_used) / (24 * 60 * 60)).to_i }
        it 'must have used their password within the last 30 days.' do
            expect(subject).to be < 30
        end
    end
end
```

Check if access keys for all users have been rotated within the last month:
```ruby
aws_iam_credential_report.where(access_key_1_active: true).entries.each do |user|
    describe "The user (#{user.user})" do
        subject { ((Time.current - user.access_key_1_last_used_date) / (24 * 60 * 60)).to_i }
        it 'must have used access key 1 within the last 90 days.' do
          expect(subject).to be < 90
        end
    end
end
```
## Matchers

{{% inspec_matchers_link %}}

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `{{ .Get "iam:GenerateCredentialReport" }}` action and the `{{ .Get "iam:GetCredentialReport" }}` with `Effect` set to `Allow`.

You can find detailed documentation on these actions in the AWS API documentation: [GenerateCredentialReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GenerateCredentialReport.html), [GetCredentialReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetCredentialReport.html).

