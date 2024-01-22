+++
title = "aws_iam_virtual_mfa_devices Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_virtual_mfa_devices"
identifier = "inspec/resources/aws/aws_iam_virtual_mfa_devices Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_virtual_mfa_devices` InSpec audit resource to test properties of multiple virtual multi-factor authentication (MFA) devices.

This resource does not require any parameters.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM virtual MFA Devices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-virtualmfadevice.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a virtual MFA device exists.

```ruby
describe aws_iam_virtual_mfa_devices do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`serial_numbers`
: A list of the virtual MFA device's serial number identifiers.

: **Field**: `serial_number`

`paths`
: A list of the user paths.

: **Field**: `path`

`user_names`
: A list of the friendly names identifying the users.

: **Field**: `user_name`

`user_ids`
: A list of the stable and unique user IDs.

: **Field**: `user_id`

`arns`
: A list of the Amazon Resource Names (ARNs) that identify the users.

: **Field**: `arn`

`create_dates`
: A list of timestamps, in ISO 8601 date-time format, when the user was created.

: **Field**: `create_date`

`enable_dates`
: A list of timestamps on which the virtual MFA devices were enabled.

: **Field**: `enable_date`

`tags`
: A list of the tags for the resources.

: **Field**: `tags`

## Examples

**Ensure a username is available.**

```ruby
describe aws_iam_virtual_mfa_devices do
  its('user_names') { should include 'USER_NAME' }
end
```

**Ensure that an ARN is available.**

```ruby
describe aws_iam_virtual_mfa_devices do
    its('arns') { should include 'USER_ARN' }
end
```

## Matchers

This InSpec audit resource has the following special matchers. For a complete list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_virtual_mfa_devices do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_virtual_mfa_devices do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_iam_virtual_mfa_devices do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListVirtualMFADevicesResponse" %}}
