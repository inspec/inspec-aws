---
title: About the aws_ec2_placement_groups Resource
platform: aws
---

# aws_ec2_placement_groups

Use the `aws_ec2_placement_groups` InSpec audit resource to test properties of multiple AWS EC2 placement groups.

The `AWS::EC2::PlacementGroup` resource type specifies a placement group in which to launch instances.

## Syntax

Ensure that the placement group exists.

    describe aws_ec2_placement_groups do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS EC2 placement group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html).

## Properties

| Property | Description | Fields |
| --- | --- | --- |
| group_names | The name of the placement group. | group_name |
| states | The state of the placement group. | state |
| strategies | The placement strategy. | strategy |
| partition_counts | The number of partitions. | partition_count |
| group_ids | The ID of the placement group. | group_id |
| tags | Any tags applied to the placement group. | tags |

## Examples

### Ensure a placement group name is available.

    describe aws_ec2_placement_groups do
      its('group_names') { should include 'PLACEMENT_GROUP_NAME' }
    end

### Ensure that the state is `available`.

    describe aws_ec2_placement_groups do
        its('states') { should include 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_placement_groups do
      it { should exist }
    end

Use `should_not` to test that an entity does not exist.

    describe aws_ec2_placement_groups do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_placement_groups do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribePlacementGroupsResult` action with `Effect` set to `Allow`.
