+++
title = "aws_signer_signing_profile Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_signer_signing_profile"
identifier = "inspec/resources/aws/aws_signer_signing_profile Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_signer_signing_profile` InSpec audit resource to test properties of a single specific AWS Signer signing profile.

A signing profile is a code signing template that can be used to carry out a pre-defined signing job.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Signer SigningProfile.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that the signing profile exists.

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
  it { should exist }
end
```

## Parameters

`profile_name` _(required)_

: The name of the target signing profile.

## Properties

`profile_name`
: The name of the target signing profile.

`profile_version`
: The current version of the signing profile.

`profile_version_arn`
: The signing profile ARN, including the profile version.

`revocation_record.revocation_effective_from`
: The time when revocation becomes effective.

`revocation_record.revoked_at`
: The time when the signing profile was revoked.

`revocation_record.revoked_by`
: The identity of the revoker.

`signing_material.certificate_arn`
: The Amazon Resource Name (ARN) of the certificates that is used to sign your code.

`platform_id`
: The ID of the platform that is used by the target signing profile.

`platform_display_name`
: A human-readable name for the signing platform associated with the signing profile.

`signature_validity_period.value`
: The numerical value of the time unit for signature validity.

`signature_validity_period.type`
: The time unit for signature validity.

`overrides.signing_configuration.encryption_algorithm`
: A specified override of the default encryption algorithm that is used in a code signing job.

`overrides.signing_configuration.hash_algorithm`
: A specified override of the default hash algorithm that is used in a code signing job.

`overrides.signing_image_format`
: profile_name.

`signing_parameters`
: A map of key-value pairs for signing operations that is attached to the target signing profile.

`status`
: The status of the target signing profile.

`status_reason`
: Reason for the status of the target signing profile.

`arn`
: The Amazon Resource Name (ARN) for the signing profile.

`tags`
: A list of tags associated with the signing profile.

## Examples

**Ensure a profile name is available.**

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
  its('profile_name') { should eq 'PROFILE_NAME' }
end
```

**Ensure a profile version is available.**

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
    its('profile_version') { should eq 'PROFILE_VERSION' }
end
```

**Ensure a status is `Active`.**

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
    its('status') { should eq 'Active' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_signer_signing_profile(profile_name: 'PROFILE_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Signer:Client:GetSigningProfileResponse" %}}
