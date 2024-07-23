+++
title = "aws_ssm_patch_baselines Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_ssm_patch_baseline"
identifier = "inspec/resources/aws/aws_ssm_patch_baselines Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_patch_baseline` InSpec audit resource to test properties of multiple AWS Systems Manager (SSM) patch baselines.

The `AWS::SSM::PatchBaseline` resource defines the basic information for an AWS Systems Manager patch baseline. A patch baseline defines which patches are approved for installation on your instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM patch baseline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-patchbaseline.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a baseline exists:

```ruby
describe aws_ssm_patch_baselines do
  it { should exist }
end
```

## Parameters

This resource does not expect any required parameters.

## Properties

`baseline_ids`
: The ID of the patch baseline.

: **Field**: `baseline_id`

`names`
: The name of the patch baseline.

: **Field**: `name`

`operating_systems`
: Returns the operating system specified for the patch baseline.

: **Field**: `operating_system`

`baseline_descriptions`
: A description of the patch baseline.

: **Field**: `baseline_description`

`default_baselines`
: Whether this is the default baseline.

: **Field**: `default_baseline`

## Examples

**Ensure a baseline ID is available.**

```ruby
describe aws_ssm_patch_baselines do
  its('baseline_ids') { should include 'BASELINE_ID' }
end
```

**Ensure a baseline name is present.**

```ruby
describe aws_ssm_patch_baselines do
    its('baseline_names') { should include 'BASELINE_NAME' }
end
```

**Ensure a patch baseline has the `WINDOWS` operating system.**

```ruby
describe aws_ssm_patch_baselines do
  its('operating_systems') { should include 'WINDOWS' }
end
```

**Ensure a baseline description is present.**

```ruby
describe aws_ssm_patch_baselines do
    its('baseline_descriptions') { should include 'BASELINE_DESCRIPTION' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ssm_patch_baselines do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ssm_patch_baselines do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ssm_patch_baselines do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:DescribePatchBaselinesResult" %}}
