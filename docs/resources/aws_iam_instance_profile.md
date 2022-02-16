---
title: About the aws_iam_instance_profile Resource
platform: aws
---

# aws\_iam\_instance\_profile

Use the `aws_iam_instance_profile` InSpec audit resource to test properties of a single IAM instance profile.

This resource retrieves information about the specified instance profile, including the instance profile's path, GUID, ARN, and role.

## Syntax

Ensure that a instance profile name exists.

    describe aws_iam_instance_profile(instance_profile_name: 'INSTANCE_PROFILE_NAME') do
      it { should exist }
    end

## Parameters

`instance_profile_name` _(required)_

For additional information, see the [AWS documentation on IAM Instance Profile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html).

## Properties

| Property | Description |
| :---: | :--- |
| path | The path to the instance profile. |
| instance_profile_name | The name identifying the instance profile. |
| instance_profile_id | The stable and unique string identifying the instance profile. |
| arn | The Amazon Resource Name (ARN) specifying the instance profile. |
| create_date | The date when the instance profile was created. |
| roles (path) | The path to the role. |
| roles (role_name) | The friendly name that identifies the role. |
| roles (role_id) | The stable and unique string identifying the role. |
| roles (arn) | The Amazon Resource Name (ARN) specifying the role. |
| roles (create_date) | The date and time, in [ISO 8601 date-time format](https://www.iso.org/iso-8601-date-and-time-format.html), when the role was created. |
| roles (assume_role_policy_document) | The policy that grants an entity permission to assume the role. |
| roles (description) | A description of the role that you provide. |
| roles (max_session_duration) | The maximum session duration (in seconds) for the specified role. Anyone who uses the AWS CLI, or API to assume the role can specify the duration using the optional DurationSeconds API parameter or duration-seconds CLI parameter. |
| roles (permissions_boundary (permissions_boundary_type)) | The permissions boundary usage type that indicates what type of IAM resource is used as the permissions boundary for an entity. This data type can only have a value of Policy . |
| roles (permissions_boundary (permissions_boundary_arn)) | The ARN of the policy used to set the permissions boundary for the user or role. |
| roles (tags (key)) | The key name that can be used to look up or retrieve the associated value. For example, Department or Cost Center are common choices. |
| roles (tags (value)) | The value associated with this tag. For example, tags with a key name of Department could have values such as Human Resources , Accounting , and Support . Tags with a key name of Cost Center might have values that consist of the number associated with the different cost centers in your company. Typically, many resources have tags with the same key name but with different values. |
| roles (role_last_used (last_used_date)) | The date and time, in ISO 8601 date-time format that the role was last used. |
| roles (role_last_used (region)) | The name of the AWS Region in which the role was last used. |

## Examples

### Ensure a instance profile name is available.

    describe aws_iam_instance_profile(instance_profile_name: 'INSTANCE_PROFILE_NAME') do
      its('instance_profile_name') { should eq 'INSTANCE_PROFILE_NAME' }
    end

### Ensure that an arn is available.
    describe aws_iam_instance_profile(instance_profile_name: 'INSTANCE_PROFILE_NAME') do
        its('arn') { should eq 'INSTANCE_PROFILE_NAME_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_instance_profile(instance_profile_name: 'INSTANCE_PROFILE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_instance_profile(instance_profile_name: 'INSTANCE_PROFILE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the instance profile name is available.

    describe aws_iam_instance_profile(instance_profile_name: 'INSTANCE_PROFILE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:GetInstanceProfileResponse` action with `Effect` set to `Allow`.