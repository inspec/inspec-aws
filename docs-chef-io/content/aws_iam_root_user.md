+++
title = "aws_iam_root_user resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_iam_root_user"
identifier = "inspec/resources/aws/aws_iam_root_user resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_root_user` InSpec audit resource to test properties of an AWS IAM Root User.

For additional information, including details on parameters and properties, see the [AWS documentation on Root Users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_root-user.html).

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

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_iam_root_user do
  it { should exist }
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

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the following permissions action set to allow:
`IAM:Client:GetAccountSummaryResponse`
`IAM:Client:ListVirtualMFADevicesResponse`
