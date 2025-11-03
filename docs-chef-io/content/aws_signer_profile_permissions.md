+++
title = "aws_signer_profile_permissions resource"

draft = false


[menu.aws]
title = "aws_signer_profile_permissions"
identifier = "inspec/resources/aws/aws_signer_profile_permissions resource"
parent = "inspec/resources/aws"
+++

Use the `aws_signer_profile_permissions` InSpec audit resource to test properties of multiple AWS Signer profile permissions.

The `AWS::Signer::ProfilePermission` resource adds cross-account permissions to a signing profile.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS Signer ProfilePermission](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-signer-profilepermission.html).

## Syntax

Ensure that the profile permission exists.

```ruby
describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
  it { should exist }
end
```

## Parameters

`profile_name` _(required)_

: Name of the signing profile containing the cross-account permissions.

## Properties

`actions`
: An AWS Signer action permitted as part of cross-account permissions.

: **Field**: `action`

`principals`
: The AWS principal that has been granted a cross-account permission.

: **Field**: `principal`

`statement_ids`
: A unique identifier for a cross-account permission statement.

: **Field**: `statement_id`

`profile_versions`
: The signing profile version that a permission applies to.

: **Field**: `profile_version`

## Examples

Ensure a principal is available:

```ruby
describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
  its('principals') { should include 'PRINCIPAL' }
end
```

Ensure a statement ID is available:

```ruby
describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
  its('statement_ids') { should include 'STATEMENT_ID' }
end
```

Ensure a profile version is available:

```ruby
describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
  its('profile_versions') { should include 'PROFILE_VERSION' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_signer_profile_permissions(profile_name: 'PROFILE_NAME') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="Signer:Client:ListProfilePermissionsResponse" %}}
