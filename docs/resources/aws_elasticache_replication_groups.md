---
title: About the aws_elasticache_replication_groups Resource
---

# aws\_elasticache\_replication\_groups

Use the `aws_elasticache_replication_groups` InSpec audit resource to test the properties of all Amazon ElastiCache replication groups. To audit a single ElastiCache replication group, use `aws_elasticache_replication_group` (singular).

## Syntax

An `aws_elasticache_replication_groups` resource block collects a group of ElastiCache replication group descriptions and then tests that group.

    describe aws_elasticache_replication_groups
      it { should exist }
    end

### Parameters

This resource does not expect any parameters.

## Properties

|Property                  | Description|
| ---                      | --- |
|ids                       | The user-supplied identifier of the replication group. This identifier is a unique key that identifies a replication group. |
|node\_types               | The name of the compute and memory capacity node type for the replication group, e.g. `cache.m5.large`. |
|status                    | The current state of the replication group, e.g. `creating`, `available`. |
|encrypted\_at\_rest       | Indicates whether the content is encrypted at rest or not. |
|encrypted\_at\_transit    | Indicates whether the content is encrypted at transit or not. |

## Examples

### Ensure that exactly three ElastiCache replication groups exist
    describe aws_elasticache_replication_groups do
      its('count') { should eq 3 }
    end

### Request the IDs of all ElastiCache replication groups, then test in-depth using `aws_elasticache_replication_group`.
    aws_elasticache_replication_groups.ids.each do |replication_group_id|
      describe aws_elasticache_replication_group(replication_group_id) do
        it { should be_encrypted_at_rest }
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

The control will pass if the 'describe' method returns at least one result.

    describe aws_elasticache_replication_groups.where( <property>: <value>) do
      it { should exist }
    end

Use `should_not` to test an entity that should not exist.

    describe aws_elasticache_replication_groups.where( <property>: <value>) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElastiCache:Client:ReplicationGroupMessage` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonelasticache.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).