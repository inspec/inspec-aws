---
title: About the aws_ebs_volumes Resource
platform: aws
---

# aws_ebs_volumes

Use the `aws_ebs_volumes` InSpec audit resource to test the properties of a collection of AWS EBS volumes.

EBS volumes are persistent block storage volumes for Amazon EC2 instances in the AWS Cloud.

## Syntax

Ensure a volume exists.

    describe aws_ebs_volumes do
      it { should exist }
    end

## Parameters

This resource does not require any required parameters.

See also the [AWS documentation on EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| attachments | The EBS volume attachments returned. | attachments |
| availability_zones | The list of availability zones in use by the EBS volumes. | availability_zone |
| create_times | The creation times of the EBS volumes. | create_time |
| encrypted | The list of true/false values indicating whether the EBS volumes are encrypted. | encrypted |
| fast_restored | The list of true/false values indicating whether the EBS volume is created with a snapshot enabled for fast snapshot restore. | fast_restored |
| iops | The list of I/O per second for each EBS volume. | iops |
| kms_key_ids | The list of ARNs for EBS volume KMS keys. | kms_key_id |
| multi_attach_enabled | The list of boolean values indicating whether the EBS volume is multi-attach enabled. | multi_attach_enabled |
| outpost_arns | The list of ARNs of outposts. | outpost_arn |
| sizes | The list of EBS volume sizes. | size |
| snapshot_ids | The list of snapshots from which EBS volumes are created. | snapshot_id |
| states | The list of volume states returned. | state |
| tags | The list of volume tags returned. | iops |
| volume_ids | The unique IDs of the EBS volumes returned. | attachments |
| volume_types | The list of volume types returned. | volume_type |

## Examples

### Ensure a specific volume exists

    describe aws_ebs_volumes do
      its('volume_ids') { should include 'VOLUME_ID' }
    end

### Request the EBS volumes IDs

Test in-depth using `aws_ebs_volume` to ensure all volumes are encrypted and have a sensible size.

    aws_ebs_volumes.volume_ids.each do |volume_id|
      describe aws_ebs_volume(volume_id) do
        it          { should be_encrypted }
        its('size') { should be > 10 }
        its('iops') { should cmp 100 }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

#### Use `should` to test that the entity exists.

    describe aws_ebs_volumes do
      it { should exist }
    end

#### Use `should_not` to test the entity does not exist.

    describe aws_ebs_volumes do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVolumesResult` actions set to allow.
You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
