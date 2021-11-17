---
title: About the aws_signer_signing_profiles Resource
platform: aws
---

# aws_signer_signing_profiles

Use the `aws_signer_signing_profiles` InSpec audit resource to test properties of multiple AWS Signer signing profiles.

A signing profile is a code signing template that can be used to carry out a pre-defined signing job.

## Syntax

Ensure that the signing profile exists.

    describe aws_signer_signing_profiles do
      it { should exist }
    end

## Parameters

This resource does not require any parameters.

For additional information, see the [AWS documentation on AWS Signer SigningProfile.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html).

## Properties

| Property | Description | Field |
| --- | --- | --- |
| profile_names | The name of the target signing profile. | profile_name |
| profile_versions | The current version of the signing profile. | profile_version |
| profile_version_arns | The signing profile ARN, including the profile version. | profile_version_arn |
| signing_materials | The ACM certificate that is available for use by a signing profile. | signing_material |
| signature_validity_periods | The validity period for a signing job created using this signing profile. | signature_validity_period |
| platform_ids | The ID of the platform that is used by the target signing profile. | platform_id |
| platform_display_names | A human-readable name for the signing platform associated with the signing profile. | platform_display_name |
| signing_parameters | A map of key-value pairs for signing operations that is attached to the target signing profile. | signing_parameters |
| statuses | The status of the target signing profile. | status |
| status_reasons | Reason for the status of the target signing profile. | status_reason |
| arns | The Amazon Resource Name (ARN) for the signing profile. | arn |
| tags | A list of tags associated with the signing profile. | tags |

## Examples

### Ensure a profile name is available.

    describe aws_signer_signing_profiles do
      its('profile_names') { should include 'PROFILE_NAME' }
    end

### Ensure a profile version is available.

    describe aws_signer_signing_profiles do
        its('profile_versions') { should include 'PROFILE_VERSION' }
    end

### Ensure a status is `Active`.

    describe aws_signer_signing_profiles do
        its('statuses') { should include 'Active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_signer_signing_profiles do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_signer_signing_profiles do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Signer:Client:ListSigningProfilesResponse` action with `Effect` set to `Allow`.
