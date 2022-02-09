---
title: About the aws_ssm_patch_baseline Resource
platform: aws
---

# aws_ssm_patch_baseline

Use the `aws_ssm_patch_baseline` InSpec audit resource to test properties of multiple AWS Systems Manager (SSM) patch baselines.

The `AWS::SSM::PatchBaseline` resource defines the basic information for an AWS Systems Manager patch baseline. A patch baseline defines which patches are approved for installation on your instances.

## Syntax

Ensure that a baseline exists:

    describe aws_ssm_patch_baselines do
      it { should exist }
    end

## Parameters

This resource does not expect any required parameters.

For additional information, see the [AWS documentation on AWS SSM patch baseline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ssm-patchbaseline.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| baseline_ids | The ID of the patch baseline. | baseline_id |
| names | The name of the patch baseline. | name |
| operating_systems | Returns the operating system specified for the patch baseline. | operating_system |
| baseline_descriptions | A description of the patch baseline. | baseline_description |
| default_baselines | Whether this is the default baseline. | default_baseline |

## Examples

### Ensure a baseline ID is available.

    describe aws_ssm_patch_baselines do
      its('baseline_ids') { should include 'BASELINE_ID' }
    end

### Ensure a baseline name is present.

    describe aws_ssm_patch_baselines do
        its('baseline_names') { should include 'BASELINE_NAME' }
    end

### Ensure a patch baseline has the `WINDOWS` operating system.

    describe aws_ssm_patch_baselines do
      its('operating_systems') { should include 'WINDOWS' }
    end

### Ensure a baseline description is present.

    describe aws_ssm_patch_baselines do
        its('baseline_descriptions') { should include 'BASELINE_DESCRIPTION' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ssm_patch_baselines do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ssm_patch_baselines do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ssm_patch_baselines do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `SSM:Client:DescribePatchBaselinesResult` action with `Effect` set to `Allow`.
