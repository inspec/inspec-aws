---
title: About the aws_signer_profile_permissions Resource
platform: aws
---

# aws_signer_profile_permissions

Use the `aws_signer_profile_permissions` InSpec audit resource to test properties of multiple AWS Signer profile permissions.

The `AWS::Signer::ProfilePermission` resource adds cross-account permissions to a signing profile.

## Syntax

Ensure that the profile permission exists.

    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      it { should exist }
    end

## Parameters

`profile_name` _(required)_

Name of the signing profile containing the cross-account permissions.

For additional information, see the [AWS documentation on AWS Signer ProfilePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-profilepermission.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| actions | An AWS Signer action permitted as part of cross-account permissions. | action |
| principals | The AWS principal that has been granted a cross-account permission. | principal |
| statement_ids | A unique identifier for a cross-account permission statement. | statement_id |
| profile_versions | The signing profile version that a permission applies to. | profile_version |

## Examples

### Ensure a principal is available.

    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      its('principals') { should include 'PRINCIPAL' }
    end

### Ensure a statement ID is available.

    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      its('statement_ids') { should include 'STATEMENT_ID' }
    end

### Ensure a profile version is available.

    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      its('profile_versions') { should include 'PROFILE_VERSION' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Signer:Client:ListProfilePermissionsResponse` action with `Effect` set to `Allow`.
