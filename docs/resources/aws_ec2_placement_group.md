---
title: About the aws_ec2_placement_group Resource
platform: aws
---

# aws_ec2_placement_group

Use the `aws_ec2_placement_group` InSpec audit resource to test properties of a single specific AWS EC2 Placement Group.

The AWS::EC2::PlacementGroup resource specifies a placement group in which to launch instances.

## Syntax

Ensure that the placement group exists.

    describe aws_ec2_placement_group(placement_group_name: 'PlacementGroupName') do
      it { should exist }
    end

## Parameters

`placement_group_name` _(required)_

| Property | Description |
| --- | --- |
| placement_group_name |The name of the placement group. |

For additional information, see the [AWS documentation on AWS EC2 Placement Group.](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-placementgroup.html).

## Properties

| Property | Description | Field | 
| --- | --- | --- |
| group_name | The name of the placement group. | group_name |
| state | The state of the placement group. | state |
| strategy | The placement strategy. | strategy |
| partition_count | The number of partitions. | partition_count |
| group_id | The ID of the placement group. | group_id |
| tags | Any tags applied to the placement group. | tags |

## Examples

### Ensure a placement group name is available.
    describe aws_ec2_placement_group(placement_group_name: 'PlacementGroupName') do
      its('group_name') { should eq 'PlacementGroupName' }
    end

### Ensure that the state is `available`.
    describe aws_ec2_placement_group(placement_group_name: 'PlacementGroupName') do
        its('state') { should eq 'available' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_ec2_placement_group(placement_group_name: 'PlacementGroupName') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_ec2_placement_group(placement_group_name: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the entity is available.

    describe aws_ec2_placement_group(placement_group_name: 'PlacementGroupName') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:DescribePlacementGroupsResult` action with `Effect` set to `Allow`.