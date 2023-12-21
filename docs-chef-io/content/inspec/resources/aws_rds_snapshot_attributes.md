+++
title = "aws_rds_snapshot_attributes Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_snapshot_attributes"
identifier = "inspec/resources/aws/aws_rds_snapshot_attributes Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_snapshotattributes` InSpec audit resource to test the detailed properties of an individual RDS snapshot attrbutes.

For additional information, including details on parameters and properties, see the [AWS documentation on RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_rds_snapshot_attributes` resource block uses resource parameters to search for an RDS snapshot and test the respective RDS snapshot attributes.  

No error is raised if no RDS snapshots match. However, the `exists` matcher will return `false`, and all properties will be `nil`.  

An error is raised if more than one RDS snapshot matches (due to vague search parameters).

```ruby
describe aws_rds_snapshot_attributes('TEST-SNAPSHOT-ID') do
  it { should exist }
end
```

    # Can also use hash syntax
```ruby
describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'TEST-SNAPSHOT-ID') do
  it { should exist }
end
```

## Parameters

`db_snapshot_identifier`

: This resource accepts a single parameter either as a string or a `db_snapshot_identifier: 'value'` key-value entry in a hash. This parameter is user-supplied DB snapshot identifier. This parameter isn't case-sensitive and is a required parameter.

## Properties

`db_snapshot_identifier`
: The unique ID of the RDS snapshot returned.

`attribute_name`
: The name of the attribute returned for a RDS snapshot.

`attribute_values`
: The attribute values associated with the attribute_name.

## Examples

**Tests the attribute name of RDS snapshot.**

```ruby
describe aws_rds_snapshot-attributes(db_snapshot_identifier: 'AWSRDS123') do
  its ('attribute_name') { should eq 'restore' }
end
```

**Tests the attribute value of attribute name for a RDS snapshot.**

```ruby
describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'AWSRDS123').where('attribute_name' == 'restore') do
  its('attribute_values') { should_not include 'all' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'AnExistingRDS') do
  it { should exist }
end
```

```ruby
describe aws_rds_snapshot_attributes(db_snapshot_identifier: 'ANonExistentRDS') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DescribeDBSnapshotAttributesResult" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
