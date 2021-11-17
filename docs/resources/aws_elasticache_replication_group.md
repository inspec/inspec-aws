---
title: About the aws_elasticache_replication_group Resource
---

# aws_elasticache_replication_group

Use the `aws_elasticache_replication_group` InSpec audit resource to test the properties of a single Amazon ElastiCache replication group.

## Syntax

An `aws_elasticache_replication_group` resource block declares the tests for a single Amazon ElastiCache replication group by `replication_group_id`.

    describe aws_elasticache_replication_group(replication_group_id: 'my-replication-group-123') do
      it { should exist }
    end

The value of the `replication_group_id` can be provided as a string.  

    describe aws_elasticache_replication_group('my-replication-group-123') do
      it { should exist }
    end

### Parameters

The ElastiCache replication group ID is required.

#### replication\_group\_id _(required)_

The ID of the ElastiCache replication group:

 - must contain between 1 and 50 alphanumeric characters or hyphens 
 - should start with a letter 
 - cannot end with a hyphen or contain two consecutive hyphens
 
It can be passed either as a string or as a `replication_group_id: 'value'` key-value entry in a hash.

## Properties

|Property               | Description |
| ---                   | --- |
|replication\_group\_id | The user-supplied identifier of the replication group. This identifier is a unique key that identifies a replication group.|
|status                 | The current state of the replication group, e.g. `creating`, `available`. |
|encrypted\_at\_rest    | Indicates whether the content is encrypted at rest or not. |
|encrypted\_at\_transit | Indicates whether the content is encrypted at transit or not. |


There are also additional properties available. For a comprehensive list, see [the API reference documentation](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/ElastiCache/Types/ReplicationGroup.html).

## Examples

### Test that an ElastiCache replication group is available

    describe aws_elasticache_replication_group('my-replication-group-123') do
        its("status") { should eq 'available' }
    end
    
## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

### exist

    describe aws_elasticache_replication_group('my-replication-group-123') do
        it { should exist }
    end
    
### be_encrypted_at_rest

    describe aws_elasticache_replication_group('my-replication-group-123') do
        it { should be_encrypted_at_rest }
    end
    
## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `ElastiCache:Client:ReplicationGroupMessage` action set to allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonelasticache.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).