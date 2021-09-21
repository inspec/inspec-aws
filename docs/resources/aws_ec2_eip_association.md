---
title: About the aws_ec2_eip_association Resource
platform: aws
---

# aws_ec2_eip_association

Use the `aws_ec2_eip_association` InSpec audit resource to test properties of a single specific Elastic IP (EIP).

An Elastic IP (EIP) is uniquely identified by the public IPv4 address, for example `AssociationID`.

## Syntax

Ensure that a Public IP exists.

    describe aws_ec2_eip_association(association_id: 'AssociationID') do
      it { should exist }
    end

## Parameters

`association_id` _(required)_

| Property | Description|
| --- | --- |
| association_id | The association ID for the address. |

For additional information, see the [AWS documentation on Elastic IP (EIP)](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-eip.html).

## Properties

| Property | Description|
| --- | --- |
| association_id | The association ID for the address. |

## Examples

##### Check Association ID whether it is correct or not
    describe aws_ec2_eip_association(association_id: 'AssociationID') do
       its('association_id') { should eq "AssociationID" }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_eip_association(association_id: 'AssociationID') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_eip_association(association_id: 'AssociationID') do
      it { should_not exist }
    end

### be_available

Check if the IP address is available.

    describe aws_ec2_eip_association(association_id: 'AssociationID') do
      it { should be_available }
    end

Use `should_not` to test an IP address that should not exist.

    describe aws_ec2_eip_association(association_id: 'AssociationID') do
      it { should_not be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribeAddressesResult` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.