---
title: About the aws_ebs_volume Resource
platform: aws
---

# aws\_ebs\_volume

Use the `aws_ebs_volume` InSpec audit resource to test properties of a single AWS EBS volume.

<br>

## Syntax

An `aws_ebs_volume` resource block declares the tests for a single AWS EBS volume by either name or id.

    describe aws_ebs_volume('vol-01a2349e94458a507') do
      it { should exist }
    end

    describe aws_ebs_volume(name: 'data-vol') do
      it { should be_encrypted }
    end

<br>

## Examples

The following examples show how to use this InSpec audit resource.

### Test that an EBS Volume does not exist

    describe aws_ebs_volume(name: 'data_vol') do
      it { should_not exist }
    end

### Test that an EBS Volume is encrypted

    describe aws_ebs_volume(name: 'secure_data_vol') do
      it { should be_encrypted }
    end

### Test that an EBS Volume the correct size

    describe aws_ebs_volume(name: 'data_vol') do
      its('size') { should cmp 32 }
    end

<br>

## Properties

* `availability_zone`, `encrypted`, `iops`, `kms_key_id`, `size`, `snapshot_id`, `state`, `volume_type`

<br>

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### be\_encrypted

The `be_encrypted` matcher tests if the described EBS Volume is encrypted.

    it { should be_encrypted }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ec2:DescribeVolumes`, and `iam:GetInstanceProfile` actions set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
