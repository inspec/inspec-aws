---
title: About the aws_ec2_eip_associations Resource
platform: aws
---

# aws_ec2_eip_associations

Use the `aws_ec2_eip_associations` InSpec audit resource to test properties of some or all AWS Elastic IP association.

## Syntax

Verify that the association exists.

    describe aws_ec2_eip_associations do
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

See the [AWS documentation on AWS Elastic IP association](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip-association.html) for additional information.

## Properties

| Property | Description | Field |
| --- | --- | --- |
| association_ids | The association ID for the address. | association_id |

## Examples

##### Check association ID is available

    describe aws_ec2_eip_associations do
       its('association_ids') { should include "ASSOCIATION_ID" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the describe returns at least one result.

Use `should` to test that the entity exists.

    describe aws_ec2_eip_associations do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_eip_associations do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeAddressesResult` action with `Effect` set to `Allow`.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html).
