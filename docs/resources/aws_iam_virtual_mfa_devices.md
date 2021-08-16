---
title: About the aws_iam_virtual_mfa_devices Resource
platform: aws
---

# aws\_iam\_virtual\_mfa\_devices

Use the `aws_iam_virtual_mfa_devices` InSpec audit resource to test properties of multiple virtual MFA devices.


## Syntax

Ensure that an virtual mfa device exist.

    describe aws_iam_virtual_mfa_devices do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on IAM virtual MFA Devices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-virtualmfadevice.html).

## Properties

| Property | Description|
| --- | --- |
| serial_number |The VirtualMfaDevice's serial_number identifier. |
| path | The path to the user. For more information about paths, see IAM Identifiers in the Using IAM guide. |
| user_name | The friendly name identifying the user. |
| user_id | The stable and unique string identifying the user. For more information about IDs, see IAM Identifiers in the Using IAM guide. |
| arn | The Amazon Resource Name (ARN) that identifies the user. |
| create_date | The date and time, in ISO 8601 date-time format , when the user was created. |
| tags | The tags for the resource. |
| enable_date | The date when the virtual mfa was Enabled.  |

## Examples

### Ensure an user_name is available.

    describe aws_iam_virtual_mfa_devices do
      its('user_name') { should include 'user_name' }
    end

### Ensure that an arn is available.
    describe aws_iam_virtual_mfa_devices do
        its('arns') { should include 'TEST_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

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

Use `should` to check if the work_group name is available.

    describe aws_iam_virtual_mfa_devices do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `iam_client.list_instance_profiles` action with `Effect` set to `Allow`.
