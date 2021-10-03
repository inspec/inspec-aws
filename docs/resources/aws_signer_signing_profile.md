---
title: About the aws_signer_signing_profile Resource
platform: aws
---

# aws_signer_signing_profile

Use the `aws_signer_signing_profile` InSpec audit resource to test properties of a single specific AWS Signer SigningProfile.

A signing profile is a code signing template that can be used to carry out a pre-defined signing job.

## Syntax

Ensure that the signing profile exists.

    describe aws_signer_signing_profile(profile_name: 'ProfileName') do
      it { should exist }
    end

## Parameters

`profile_name` _(required)_

| Property | Description |
| --- | --- |
| profile_name | The name of the target signing profile. |

For additional information, see the [AWS documentation on AWS Signer SigningProfile.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| profile_name | The name of the target signing profile. | profile_name |
| profile_version | The current version of the signing profile. | profile_version |
| profile_version_arn | The signing profile ARN, including the profile version. | profile_version_arn |
| revocation_record.revocation_effective_from | The time when revocation becomes effective. | revocation_effective_from |
| revocation_record.revoked_at | The time when the signing profile was revoked. | revoked_at |
| revocation_record.revoked_by | The identity of the revoker. | revoked_by |
| signing_material.certificate_arn | The Amazon Resource Name (ARN) of the certificates that is used to sign your code. | certificate_arn |
| platform_id | The ID of the platform that is used by the target signing profile. | platform_id |
| platform_display_name | A human-readable name for the signing platform associated with the signing profile. | platform_display_name |
| signature_validity_period.value | The numerical value of the time unit for signature validity. | value |
| signature_validity_period.type | The time unit for signature validity. | type |
| overrides.signing_configuration.encryption_algorithm | A specified override of the default encryption algorithm that is used in a code signing job. | encryption_algorithm |
| overrides.signing_configuration.hash_algorithm | A specified override of the default hash algorithm that is used in a code signing job. | hash_algorithm |
| overrides.signing_image_format | profile_name | signing_image_format |
| signing_parameters | A map of key-value pairs for signing operations that is attached to the target signing profile. | signing_parameters |
| status | The status of the target signing profile. | status |
| status_reason | Reason for the status of the target signing profile. | status_reason |
| arn | The Amazon Resource Name (ARN) for the signing profile. | arn |
| tags | A list of tags associated with the signing profile. | tags |

## Examples

### Ensure a profile name is available.
    describe aws_signer_signing_profile(profile_name: 'ProfileName') do
      its('profile_name') { should eq 'ProfileName' }
    end

### Ensure a profile version is available.
    describe aws_signer_signing_profile(profile_name: 'ProfileName') do
        its('profile_version') { should eq 'ProfileVersion' }
    end

### Ensure a status is `Active`.
    describe aws_signer_signing_profile(profile_name: 'ProfileName') do
        its('status') { should eq 'Active' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_signer_signing_profile(profile_name: 'ProfileName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_signer_signing_profile(profile_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_signer_signing_profile(profile_name: 'ProfileName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `Signer:Client:GetSigningProfileResponse` action with `Effect` set to `Allow`.