+++
title = "aws_rds_snapshots resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_rds_snapshots"
identifier = "inspec/resources/aws/aws_rds_snapshots resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_snapshots` InSpec audit resource to test the properties of a collection of AWS RDS snapshots.

## Syntax

 Ensure you have three snapshots.

```ruby
describe aws_rds_snapshots do
  its('db_snapshot_identifiers.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`db_snapshot_identifiers`
: The unique IDs of the RDS snapshots returned.

`entries`
: Provides access to the raw results of the query, which can be treated as an array of hashes.

## Examples

**Ensure a specific snapshot exists.**

```ruby
describe aws_rds_snapshots do
  its('db_snapshot_identifiers') { should include 'RDS-12345678' }
end
```

**Requests the IDs of RDS snapshots and ensures the snapshots are encrypted with sensible size.**

```ruby
aws_rds_snapshots.db_snapshot_identifiers.each do |db_snapshot_identifier|
  describe aws_rds_snapshot(db_snapshot_identifier) do
    it { should be_encrypted }
  end
end
```

**Tests the snapshot using cached resource_data.**

```ruby
aws_rds_snapshots.entries.each do |AWS_RDS_SNAPSHOT|
    describe aws_rds_snapshot(resource_data: AWS_RDS_SNAPSHOT) do
        its ('engine')         { should eq 'MYSQL' }
        its ('engine_version') { should eq '5.6.37' }
    end
end
```

**Loop through all RDS snapshots and test each snapshot with singular resource.**

This method uses local in-memory caching to test each snapshot for quicker execution of large sets of test cases.

```ruby
aws_rds_snapshots.entries.each do |AWS_RDS_SNAPSHOT|
    describe aws_rds_snapshot(resource_data: AWS_RDS_SNAPSHOT) do
        it { should exist }
        it { should have_encrypted_snapshot }
    end
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_rds_snapshots do
  it { should exist }
end
```

```ruby
describe aws_rds_snapshots do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBSnapshotMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon EC2](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonec2.html), and [Actions, Resources, and Condition Keys for Identity And Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_identityandaccessmanagement.html).
