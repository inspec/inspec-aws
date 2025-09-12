+++
title = "aws_elasticache_replication_groups resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_elasticache_replication_groups"
identifier = "inspec/resources/aws/aws_elasticache_replication_groups resource"
parent = "inspec/resources/aws"
+++

Use the `aws_elasticache_replication_groups` InSpec audit resource to test the properties of all Amazon ElastiCache replication groups. To audit a single ElastiCache replication group, use `aws_elasticache_replication_group` (singular).

## Syntax

An `aws_elasticache_replication_groups` resource block collects a group of ElastiCache replication group descriptions and then tests that group.

```ruby
describe aws_elasticache_replication_groups
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`ids`
: The user-supplied identifier of the replication group. This identifier is a unique key that identifies a replication group.

`node_types`
: The name of the compute and memory capacity node type for the replication group, e.g. `cache.m5.large`.

`status`
: The current state of the replication group, e.g. `creating`, `available`.

`encrypted_at_rest`
: Indicates whether the content is encrypted at rest or not.

`encrypted_at_transit`
: Indicates whether the content is encrypted at transit or not.

## Examples

**Ensure that exactly three ElastiCache replication groups exist.**

```ruby
describe aws_elasticache_replication_groups do
  its('count') { should eq 3 }
end
```

**Request the IDs of all ElastiCache replication groups, then test in-depth using `aws_elasticache_replication_group`.**

```ruby
aws_elasticache_replication_groups.ids.each do |replication_group_id|
  describe aws_elasticache_replication_group(replication_group_id) do
    it { should be_encrypted_at_rest }
  end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the 'describe' method returns at least one result.

```ruby
describe aws_elasticache_replication_groups.where( <property>: <value>) do
  it { should exist }
end
```

Use `should_not` to test an entity that should not exist.

```ruby
describe aws_elasticache_replication_groups.where( <property>: <value>) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="ElastiCache:Client:ReplicationGroupMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon ElastiCache](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonelasticache.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
