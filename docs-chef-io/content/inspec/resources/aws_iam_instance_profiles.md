+++
title = "aws_iam_instance_profiles Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_iam_instance_profiles"
identifier = "inspec/resources/aws/aws_iam_instance_profiles Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_iam_instance_profiles` InSpec audit resource to test properties of multiple IAM instance profiles.

This resource lists the instance profiles that have the specified path prefix.

For additional information, including details on parameters and properties, see the [AWS documentation on IAM Instance Profile](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that an instance profile name exists.

```ruby
describe aws_iam_instance_profiles do
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`paths`
: The path to the instance profile.

`instance_profile_names`
: The name identifying the instance profile.

`instance_profile_ids`
: The stable and unique string identifying the instance profile.

`arns`
: The Amazon Resource Name (ARN) specifying the instance profile.

`create_dates`
: The date when the instance profile was created.

`roles`
: The role associated with the instance profile.

## Examples

**Ensure an instance profile name is available.**

```ruby
describe aws_iam_instance_profiles do
  its('instance_profile_names') { should include 'INSTANCE_PROFILE_NAME' }
end
```

**Ensure that an arn is available.**

```ruby
describe aws_iam_instance_profiles do
    its('arns') { should include 'INSTANCE_PROFILE_ARN' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `list` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_iam_instance_profiles do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_iam_instance_profiles do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the work_group name is available.

```ruby
describe aws_iam_instance_profiles do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="IAM:Client:ListInstanceProfilesResponse" %}}
