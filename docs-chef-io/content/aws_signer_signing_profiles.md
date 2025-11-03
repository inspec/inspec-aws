+++
title = "aws_signer_signing_profiles resource"

draft = false


[menu.aws]
title = "aws_signer_signing_profiles"
identifier = "inspec/resources/aws/aws_signer_signing_profiles resource"
parent = "inspec/resources/aws"
+++

Use the `aws_signer_signing_profiles` InSpec audit resource to test properties of multiple AWS Signer signing profiles.

A signing profile is a code signing template that can be used to carry out a pre-defined signing job.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Signer SigningProfile.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-signingprofile.html).

## Syntax

Ensure that the signing profile exists.

```ruby
describe aws_signer_signing_profiles do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`profile_names`
: The name of the target signing profile.

: **Field**: `profile_name`

`profile_versions`
: The current version of the signing profile.

: **Field**: `profile_version`

`profile_version_arns`
: The signing profile ARN, including the profile version.

: **Field**: `profile_version_arn`

`signing_materials`
: The ACM certificate that is available for use by a signing profile.

: **Field**: `signing_material`

`signature_validity_periods`
: The validity period for a signing job created using this signing profile.

: **Field**: `signature_validity_period`

`platform_ids`
: The ID of the platform that is used by the target signing profile.

: **Field**: `platform_id`

`platform_display_names`
: A human-readable name for the signing platform associated with the signing profile.

: **Field**: `platform_display_name`

`signing_parameters`
: A map of key-value pairs for signing operations that is attached to the target signing profile.

: **Field**: `signing_parameters`

`statuses`
: The status of the target signing profile.

: **Field**: `status`

`status_reasons`
: Reason for the status of the target signing profile.

: **Field**: `status_reason`

`arns`
: The Amazon Resource Name (ARN) for the signing profile.

: **Field**: `arn`

`tags`
: A list of tags associated with the signing profile.

: **Field**: `tags`

## Examples

Ensure a profile name is available:

```ruby
describe aws_signer_signing_profiles do
  its('profile_names') { should include 'PROFILE_NAME' }
end
```

Ensure a profile version is available:

```ruby
describe aws_signer_signing_profiles do
    its('profile_versions') { should include 'PROFILE_VERSION' }
end
```

Ensure a status is `Active`:

```ruby
describe aws_signer_signing_profiles do
    its('statuses') { should include 'Active' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_signer_signing_profiles do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_signer_signing_profiles do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Signer:Client:ListSigningProfilesResponse" %}}
