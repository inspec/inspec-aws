---
title: About the aws_ssm_patch_baseline Resource
platform: aws
---

# aws_ssm_patch_baseline

Use the `aws_ssm_patch_baseline` InSpec audit resource to test properties of a single AWS Systems Manager (SSM) patch baseline.

The `AWS::SSM::PatchBaseline` resource defines the basic information for an AWS Systems Manager patch baseline. A patch baseline defines which patches are approved for installation on your instances.

## Syntax

Ensure that the baseline exists:

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      it { should exist }
    end

## Parameters

`baseline_id` _(required)_

The ID of the patch baseline.

For additional information, see the [AWS documentation on AWS SSM patch baseline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-patchbaseline.html).

## Properties

| Property | Description | Field |
| :---: | :--- | :---: |
| baseline_id | The ID of the patch baseline. | baseline_id |
| name | The name of the patch baseline. | name |
| operating_system | Returns the operating system specified for the patch baseline. | operating_system |
| patch_filters | The set of patch filters that make up the group. | patch_filters |
| patch_filter_keys | The key for the filter. | patch_filters.key |
| patch_filter_values | The value for the filter key. | patch_filters.values |
| approval_rules.patch_rules | The rules that make up the rule group. | patch_rules |
| patch_filters | The set of patch filters that make up the group. | patch_filter_group.patch_filters |
| patch_filter_group_keys | The key for the filter. | patch_filter_group.patch_filters.key |
| patch_filter_group_values | The value for the filter key. | patch_filter_group.patch_filters.values |
| compliance_levels | A compliance severity level for all approved patches in a patch baseline. | compliance_level |
| approve_after_days | The number of days after the release date of each patch matched by the rule that the patch is marked as approved in the patch baseline. | approve_after_days |
| approve_until_date | The cutoff date for auto approval of released patches. | approve_until_date |
| enable_non_security | For instances identified by the approval rule filters, enables a patch baseline to apply non-security updates available in the specified repository. | enable_non_security |
| approved_patches | A list of explicitly approved patches for the baseline. | approved_patches |
| approved_patches_compliance_level | Returns the specified compliance severity level for approved patches in the patch baseline. | approved_patches_compliance_level |
| approved_patches_enable_non_securities | Indicates whether the list of approved patches includes non-security updates that should be applied to the instances. | approved_patches_enable_non_security |
| rejected_patches | A list of explicitly rejected patches for the baseline. | rejected_patches |
| rejected_patches_action | The action specified to take on patches included in the RejectedPatches list. | rejected_patches_action |
| patch_groups | Patch groups included in the patch baseline. | patch_groups |
| created_date | The date the patch baseline was created. | created_date |
| modified_date | The date the patch baseline was last modified. | modified_date |
| descriptions | A description of the patch baseline. | description |
| sources | Information about the patches to use to update the instances, including target operating systems and source repositories. | sources |
| source_names | The name specified to identify the patch source. | sources.name |
| source_products | The specific operating system versions a patch repository applies to, such as "Ubuntu16.04", "AmazonLinux2016.09", "RedhatEnterpriseLinux7.2" or "Suse12.7". | sources.products |
| source_configurations | The value of the yum repo configuration. | sources.configuration |

## Examples

### Ensure a baseline ID is available.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      its('baseline_id') { should eq 'BASELINE_ID' }
    end

### Ensure an operating system is `WINDOWS`.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      its('operating_system') { should eq 'WINDOWS' }
    end

### Ensure a source name is empty.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      its('source_names') { should be_empty }
    end

### Ensure an approved patches compliance level is `UNSPECIFIED`.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      its('approved_patches_compliance_level') { should eq 'UNSPECIFIED' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ssm_patch_baseline(baseline_id: 'BASELINE_ID') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:GetPatchBaselineResult` action with `Effect` set to `Allow`.
