---
title: About the aws_signer_signing_profile Resource
platform: aws
---

# aws_signer_signing_profile

Use the `aws_signer_signing_profile` InSpec audit resource to test properties of a single specific AWS Signer signing profile.

A signing profile is a code signing template that can be used to carry out a pre-defined signing job.

## Syntax

Ensure that the signing profile exists.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
      it { should exist }
    end

## Parameters

`profile_name` _(required)_

The name of the target signing profile.

For additional information, see the [AWS documentation on AWS Signer SigningProfile.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html).

## Properties

| Property | Description |
| --- | --- |
| profile_name | The name of the target signing profile. |
| profile_version | The current version of the signing profile. |
| profile_version_arn | The signing profile ARN, including the profile version. |
| revocation_record.revocation_effective_from | The time when revocation becomes effective. |
| revocation_record.revoked_at | The time when the signing profile was revoked. |
| revocation_record.revoked_by | The identity of the revoker. |
| signing_material.certificate_arn | The Amazon Resource Name (ARN) of the certificates that is used to sign your code. |
| platform_id | The ID of the platform that is used by the target signing profile. |
| platform_display_name | A human-readable name for the signing platform associated with the signing profile. |
| signature_validity_period.value | The numerical value of the time unit for signature validity. |
| signature_validity_period.type | The time unit for signature validity. |
| overrides.signing_configuration.encryption_algorithm | A specified override of the default encryption algorithm that is used in a code signing job. |
| overrides.signing_configuration.hash_algorithm | A specified override of the default hash algorithm that is used in a code signing job. |
| overrides.signing_image_format | profile_name |
| signing_parameters | A map of key-value pairs for signing operations that is attached to the target signing profile. |
| status | The status of the target signing profile. |
| status_reason | Reason for the status of the target signing profile. |
| arn | The Amazon Resource Name (ARN) for the signing profile. |
| tags | A list of tags associated with the signing profile. |

## Examples

### Ensure a profile name is available.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
      its('profile_name') { should eq 'PROFILE_NAME' }
    end

### Ensure a profile version is available.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
        its('profile_version') { should eq 'PROFILE_VERSION' }
    end

### Ensure a status is `Active`.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
        its('status') { should eq 'Active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Signer:Client:GetSigningProfileResponse` action with `Effect` set to `Allow`.