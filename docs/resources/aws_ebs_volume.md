---
title: About the aws_ebs_volume Resource
platform: aws
---

# aws\_ebs\_volume

Use the `aws_ebs_volume` InSpec audit resource to test the properties of a single AWS EBS volume.

## Syntax

Ensure an EBS exists

    describe aws_ebs_volume('VOLUME-01a2349e94458a507') do
      it { should exist }
    end

You may also use hash syntax to pass the EBS volume name.

    describe aws_ebs_volume(name: 'DATA-VOLUME') do
      it { should exist }
    end

## Parameters

This resource accepts a single parameter, either the EBS volume name or ID. _mandatory_

### volume\_id _(required if `name` not provided)_

The EBS volume ID which uniquely identifies the volume. This can be passed as either a string or an `volume_id: 'value'` key-value entry in a hash.

### name _(required if `volume_id` not provided)_

The EBS volume name which uniquely identifies the volume. This must be passed as a `name: 'value'` key-value entry in a hash.

See also the [AWS documentation on EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html).

## Properties

|Property            | Description|
| ---                | --- |
|availability\_zone  | The availability zone for the volume. |
|encrypted           | Indicates whether the volume is encrypted. |
|iops                | The number of I/O operations per second (IOPS) that the volume supports. |
|kms\_key\_id        | The full ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) is used to protect the encryption key for the volume.  |
|size                | The size of the volume in GiBs. |
|snapshot\_id        | The snapshot from which the volume is created, if applicable. |
|status              | The volume state. |
|volume\_type        | The volume type. |

## Examples

### Test that an EBS Volume does not exist

    describe aws_ebs_volume(name: 'DATA-VOLUME') do
      it { should_not exist }
    end

### Test that an EBS Volume is encrypted

    describe aws_ebs_volume(name: 'SECURE_DATA-VOLUME') do
      it { should be_encrypted }
    end

### Test that an EBS Volume has the correct size

    describe aws_ebs_volume(name: 'DATA-VOLUME') do
      its('size') { should cmp 32 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_ebs_volume(name: 'DATA-VOLUME') do
      it { should exist }
    end

    describe aws_ebs_volume(name: 'DATA-VOLUME') do
      it { should_not exist }
    end

#### be\_encrypted

The `be_encrypted` matcher tests if the described EBS volume is encrypted.

    it { should be_encrypted }

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeVolumesResult` actions set to `allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
