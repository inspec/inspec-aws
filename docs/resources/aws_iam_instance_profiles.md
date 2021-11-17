---
title: About the aws_iam_instance_profiles Resource
platform: aws
---

# aws\_iam\_instance\_profiles

Use the `aws_iam_instance_profiles` InSpec audit resource to test properties of multiple IAM instance profiles.

This resource lists the instance profiles that have the specified path prefix.

## Syntax

Ensure that an instance profile name exists.

    describe aws_iam_instance_profiles do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on IAM Instance Profile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html).

## Properties

| Property | Description|
| --- | --- |
| paths | The path to the instance profile. |
| instance_profile_names | The name identifying the instance profile. |
| instance_profile_ids | The stable and unique string identifying the instance profile. |
| arns | The Amazon Resource Name (ARN) specifying the instance profile. |
| create_dates | The date when the instance profile was created. |
| roles | The role associated with the instance profile. |

## Examples

### Ensure an instance profile name is available.

    describe aws_iam_instance_profiles do
      its('instance_profile_names') { should include 'INSTANCE_PROFILE_NAME' }
    end

### Ensure that an arn is available.
    describe aws_iam_instance_profiles do
        its('arns') { should include 'INSTANCE_PROFILE_ARN' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_iam_instance_profiles do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_iam_instance_profiles do
      it { should_not exist }
    end

### be_available

Use `should` to check if the work_group name is available.

    describe aws_iam_instance_profiles do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `IAM:Client:ListInstanceProfilesResponse` action with `Effect` set to `Allow`.
