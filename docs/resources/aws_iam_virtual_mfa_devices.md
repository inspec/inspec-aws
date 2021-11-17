---
title: About the aws_iam_virtual_mfa_devices Resource
platform: aws
---

# aws\_iam\_virtual\_mfa\_devices

Use the `aws_iam_virtual_mfa_devices` InSpec audit resource to test properties of multiple virtual multi-factor authentication (MFA) devices.


## Syntax

Ensure that a virtual MFA device exists.

    describe aws_iam_virtual_mfa_devices do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

See the [AWS documentation on IAM virtual MFA Devices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-virtualmfadevice.html) for additional information.

## Properties

| Property | Description| Field |
| --- | --- | --- |
| serial_numbers | A list of the virtual MFA device's serial number identifiers. | serial_number |
| paths | A list of the user paths. | path |
| user_names | A list of the friendly names identifying the users. | user_name |
| user_ids | A list of the stable and unique user IDs. | user_id |
| arns | A list of the Amazon Resource Names (ARNs) that identify the users. | arn |
| create_dates | A list of timestamps, in ISO 8601 date-time format, when the user was created. | create_date |
| enable_dates | A list of timestamps on which the virtual MFA devices were enabled.  | enable_date |
| tags | A list of the tags for the resources. | tags |

## Examples

### Ensure a username is available.

    describe aws_iam_virtual_mfa_devices do
      its('user_names') { should include 'USER_NAME' }
    end

### Ensure that an ARN is available.

    describe aws_iam_virtual_mfa_devices do
        its('arns') { should include 'USER_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a complete list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_virtual_mfa_devices do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_virtual_mfa_devices do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_iam_virtual_mfa_devices do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:ListVirtualMFADevicesResponse` action with `Effect` set to `Allow`.
