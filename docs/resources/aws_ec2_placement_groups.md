---
title: About the aws_ec2_placement_groups Resource
platform: aws
---

# aws_ec2_placement_groups

Use the `aws_ec2_placement_groups` InSpec audit resource to test properties of multiple EC2 Placement Groups.

## Syntax

### Ensure that a Placement Group ID exists

    describe aws_ec2_placement_groups do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on EC2 Placement Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| group_names | The name of the placement group. | group_name |
| states | The state of the placement group. | state |
| strategies | The placement strategy. | strategy |
| partition_counts | The Partition count of the placement group. | partition_count |
| group_ids | The id of the placement group. | group_id |
| tags | The tags of the placement group. | tags |


## Examples

### Ensure a Placement Group ID is available

    describe aws_ec2_placement_groups do
      its('group_id') { should eq 'GroupID' }
    end

### Ensure that the state is `available` or `deleted`

    describe aws_ec2_placement_groups do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_placement_groups do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_placement_groups do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribePlacementGroupsResult` action with `Effect` set to `Allow`.

See the [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html) documentation for additional information.
