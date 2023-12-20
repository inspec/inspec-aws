+++
title = "aws_rds_snapshot Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_snapshot"
identifier = "inspec/resources/aws/aws_rds_snapshot Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_snapshot` InSpec audit resource to test the detailed properties of an individual RDS snapshot.

For additional information, including details on parameters and properties, see the [AWS documentation on RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_rds_snapshot` resource block uses resource parameters to search for an RDS snapshot and test the respective RDS snapshot.

No error is raised if no RDS snapshots match. However, the `exists` matcher will return `false`, and all properties will be `nil`.

An error is raised if more than one RDS snapshot matches (due to vague search parameters).

```ruby
describe aws_rds_snapshot('TEST-SNAPSHOT-ID') do
  it { should exist }
end
```

    # Can also use hash syntax
```ruby
describe aws_rds_snapshot(db_snapshot_identifier: 'TEST-SNAPSHOT-ID') do
  it { should exist }
end
```

    # Passing in
```ruby
describe aws_rds_snapshot(resource_data: 'RESOURCE_DATA_OBJECT') do
  it { should exist }
end
```

## Parameters

`db_snapshot_identifier` _(required if resource_data not provided)_

: The user-supplied database snapshot identifier.
  This parameter can passed as a string or a `db_snapshot_identifier: 'value'` key-value entry in a hash.

`resource_data` _(required if db_snapshot_identifier not provided)_

: A cached resource data object.
  This must be passed key-value entry in a hash. For example, `resource_data: 'RESOURCE_DATA_OBJECT'` .

## Properties

For a comprehensive list of properties available to test on an RDS snapshot see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/Types/DBSnapshot.html)

## Examples

**Tests the engine used is with an RDS snapshot.**

```ruby
describe aws_rds_snapshot(db_snapshot_identifier: 'AWSRDS123') do
  its ('engine')         { should eq 'MYSQL' }
  its ('engine_version') { should eq '5.6.37' }
end
```


**Tests the storage allocated to an RDS snapshot.**

```ruby
describe aws_rds_snapshot(db_snapshot_identifier: 'AWSRDS123') do
  its ('allocated_storage') { should eq 10 }
end
```


**Tests the snapshot type and master username.**

```ruby
describe aws_rds_snapshot(db_snapshot_identifier: 'AWSRDS123') do
  its ('master_username')   { should eq 'DB-MAINTAIN' }
end
```

**Tests the snapshot using cached resource data.**

```ruby
describe aws_rds_snapshot(resource_data: 'AWS_RDS_SNAPSHOT') do
    its ('engine')         { should eq 'MYSQL' }
    its ('engine_version') { should eq '5.6.37' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_rds_snapshot(db_snapshot_identifier: 'AnExistingRDS') do
  it { should exist }
end
```

```ruby
describe aws_rds_snapshot(db_snapshot_identifier: 'ANonExistentRDS') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBSnapshotMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
