+++
title = "aws_iam_root_user Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_root_user"
identifier = "inspec/resources/aws/aws_iam_root_user Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_root_user` InSpec audit resource to test properties of an AWS IAM Root User.

For additional information, including details on parameters and properties, see the [AWS documentation on Root Users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html).

## Installation

{{% inspec_aws_install %}}

## Syntax

An `aws_iam_root_user` resource block declares the tests for a single AWS IAM Root User by user name.

```ruby
describe aws_iam_root_user do
    it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`summary_account`
: A hash containing a summary of the Root User's account. Properties within this hash can be accessed and tested against. Please see the [API Documentation](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetAccountSummary.html) for details on the available properties.

`virtual_devices`
: A list of the virtual MFA devices in the AWS account.

`total_access_key_per_user_quota`
: Returns the total access keys per user quota.

`total_access_keys_present`
: Return the total access keys present.

`total_account_mfa_enabled`
: Return the total account mfa enabled.

`total_account_signing_certificates_present`
: Return the total account signing certificates present.

`total_attached_policies_per_group_quota`
: Return the total attached policies per group quota.

`total_attached_policies_per_role_quota`
: Return the total attached policies per role quota.

`total_attached_policies_per_user_quota`
: Return the total attached policies per user quota.

`total_global_endpoint_token_version`
: Return the total global endpoint token version.

`total_group_policy_size_quota`
: Return the total group policy size quota.

`total_groups`
: Return the total groups.

`total_groups_per_user_quota`
: Return the total groups per user quota.

`total_groups_quota`
: Return the total groups quota.

`total_mfa_devices`
: Return the total mfa_devices.

`total_mfa_devices_in_use`
: Return the total mfa devices in use.

`total_policies`
: Return the total policies.

`total_policies_quota`
: Return the total policies quota.

`total_policy_size_quota`
: Return the total policy size quota.

`total_policy_versions_in_use`
: Return the total policy versions in use.

`total_policy_versions_in_use_quota`
: Return the total policy versions in use quota.

`total_server_certificates`
: Return the total server certificates.

`total_server_certificates_quota`
: Return the total server certificates quota.

`total_signing_certificates_per_user_quota`
: Return the total signing certificates per user quota.

`total_user_policy_size_quota`
: Return the total user policy size quota.

`total_users`
: Return the total users.

`total_users_quota`
: Return the total user quota.

`total_versions_per_policy_quota`
: Return the total versions per policy quota.

## Examples

**Test that an IAM Root User has MFA enabled.**

```ruby
describe aws_iam_root_user do
  it { should have_mfa_enabled }
end
```

**Test that an IAM Root User does not have an access key.**

```ruby
describe aws_iam_root_user do
  it { should_not have_access_key }
end
```

**Test the IAM Root User has virtual MFA enabled.**

```ruby
describe aws_iam_root_user do
  it { should have_virtual_mfa_enabled }
end
```

## Matchers

{{% inspec_matchers_link %}}

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.

```ruby
describe aws_iam_root_user do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_root_user do
  it { should_not exist }
end
```

### have_mfa_enabled

```ruby
it { should have_mfa_enabled }    
```

### have_virtual_mfa_enabled

```ruby
it { should have_virtual_mfa_enabled }
```

### have_access_key

```ruby
it { should have_access_key }
```

### have_hardware_mfa_enabled

```ruby
it { should have_hardware_mfa_enabled }    
```

### have_account_signing_certificate

```ruby
it { should have_account_signing_certificate }    
```

### have_mfa_devices_in_use

```ruby
it { should have_mfa_devices_in_use }    
```

### have_policy_versions_in_use

```ruby
it { should have_policy_versions_in_use }    
```

### have_users

```ruby
it { should have_users }    
```


## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow: 
`IAM:Client:GetAccountSummaryResponse` 
`IAM:Client:ListVirtualMFADevicesResponse` 
