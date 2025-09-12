+++
title = "aws_ssm_patch_baseline resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_ssm_patch_baseline"
identifier = "inspec/resources/aws/aws_ssm_patch_baseline resource"
parent = "inspec/resources/aws"
+++

Use the `aws_ssm_patch_baseline` InSpec audit resource to test properties of a single AWS Systems Manager (SSM) patch baseline.

The `AWS::SSM::PatchBaseline` resource defines the basic information for an AWS Systems Manager patch baseline. A patch baseline defines which patches are approved for installation on your instances.

For additional information, including details on parameters and properties, see the [AWS documentation on AWS SSM patch baseline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-patchbaseline.html).

## Syntax

Ensure that the baseline exists:

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  it { should exist }
end
```

## Parameters

`baseline_id` _(required)_

: The ID of the patch baseline.

## Properties

`baseline_id`
: The ID of the patch baseline.

: **Field**: `baseline_id`

`name`
: The name of the patch baseline.

: **Field**: `name`

`operating_system`
: Returns the operating system specified for the patch baseline.

: **Field**: `operating_system`

`patch_filters`
: The set of patch filters that make up the group.

: **Field**: `patch_filters`

`patch_filter_keys`
: The key for the filter.

: **Field**: `patch_filters.key`

`patch_filter_values`
: The value for the filter key.

: **Field**: `patch_filters.values`

`approval_rules.patch_rules`
: The rules that make up the rule group.

: **Field**: `patch_rules`

`patch_filters`
: The set of patch filters that make up the group.

: **Field**: `patch_filter_group.patch_filters`

`patch_filter_group_keys`
: The key for the filter.

: **Field**: `patch_filter_group.patch_filters.key`

`patch_filter_group_values`
: The value for the filter key.

: **Field**: `patch_filter_group.patch_filters.values`

`compliance_levels`
: A compliance severity level for all approved patches in a patch baseline.

: **Field**: `compliance_level`

`approve_after_days`
: The number of days after the release date of each patch matched by the rule that the patch is marked as approved in the patch baseline.

: **Field**: `approve_after_days`

`approve_until_date`
: The cutoff date for auto approval of released patches.

: **Field**: `approve_until_date`

`enable_non_security`
: For instances identified by the approval rule filters, enables a patch baseline to apply non-security updates available in the specified repository.

: **Field**: `enable_non_security`

`approved_patches`
: A list of explicitly approved patches for the baseline.

: **Field**: `approved_patches`

`approved_patches_compliance_level`
: Returns the specified compliance severity level for approved patches in the patch baseline.

: **Field**: `approved_patches_compliance_level`

`approved_patches_enable_non_securities`
: Indicates whether the list of approved patches includes non-security updates that should be applied to the instances.

: **Field**: `approved_patches_enable_non_security`

`rejected_patches`
: A list of explicitly rejected patches for the baseline.

: **Field**: `rejected_patches`

`rejected_patches_action`
: The action specified to take on patches included in the RejectedPatches list.

: **Field**: `rejected_patches_action`

`patch_groups`
: Patch groups included in the patch baseline.

: **Field**: `patch_groups`

`created_date`
: The date the patch baseline was created.

: **Field**: `created_date`

`modified_date`
: The date the patch baseline was last modified.

: **Field**: `modified_date`

`descriptions`
: A description of the patch baseline.

: **Field**: `description`

`sources`
: Information about the patches to use to update the instances, including target operating systems and source repositories.

: **Field**: `sources`

`source_names`
: The name specified to identify the patch source.

: **Field**: `sources.name`

`source_products`
: The specific operating system versions a patch repository applies to, such as "Ubuntu16.04", "AmazonLinux2016.09", "RedhatEnterpriseLinux7.2" or "Suse12.7".

: **Field**: `sources.products`

`source_configurations`
: The value of the yum repo configuration.

: **Field**: `sources.configuration`

## Examples

**Ensure a baseline ID is available.**

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  its('baseline_id') { should eq 'BASELINE_ID' }
end
```

**Ensure an operating system is `WINDOWS`.**

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  its('operating_system') { should eq 'WINDOWS' }
end
```

**Ensure a source name is empty.**

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  its('source_names') { should be_empty }
end
```

**Ensure an approved patches compliance level is `UNSPECIFIED`.**

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  its('approved_patches_compliance_level') { should eq 'UNSPECIFIED' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the entity is available.

```ruby
describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="SSM:Client:GetPatchBaselineResult" %}}
