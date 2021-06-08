---
title: About the aws_dms_replication_subnet_group Resource
platform: aws
---

# aws_dms_replication_subnet_group

Use the `aws_dms_replication_subnet_group` InSpec audit resource to test properties of a single specific DMS Replication Instance Subnet Group.

The AWS::DMS::ReplicationSubnetGroup resource creates an AWS DMS replication subnet group. Subnet groups must contain at least two subnets in two different Availability Zones in the same region.

## Syntax

Ensure that a subnet group identifier exists.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test1') do
      it { should exist }
    end

## Parameters

`replication_subnet_group_identifier` _(required)_

For additional information, see the [AWS documentation on DMS Replication Subnet Group](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-replicationsubnetgroup.html).

## Properties

| Property | Description|
| --- | --- |
| replication_subnet_group_identifier | The identifier of the replication subnet group. |
| replication_subnet_group_description | The description of the replication subnet group. |
| vpc_id | The vpc id of the replication subnet group. |
| subnet_group_status | The status of the replication subnet group. |
| subnets | The subnets of the replication subnet group. |

## Examples

### Ensure a identifier is available.
    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test') do
      its('replication_subnet_group_identifier') { should eq 'test' }
    end

### Ensure that the vpc is available.
    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test') do
        its('vpc_id') { should eq 'vpc-0123456789' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the identifier is available.

    describe aws_dms_replication_subnet_group(replication_subnet_group_identifier: 'test') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `dmsmigrationservice:client:describe_replication_subnet_groups` action with `Effect` set to `Allow`.