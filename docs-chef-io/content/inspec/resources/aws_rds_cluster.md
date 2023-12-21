+++
title = "aws_rds_cluster Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_rds_cluster"
identifier = "inspec/resources/aws/aws_rds_cluster Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_rds_cluster` InSpec audit resource to test detailed properties of an individual RDS cluster.

RDS gives you access to the capabilities of a MySQL, MariaDB, PostgreSQL, Microsoft SQL Server, Oracle, or Amazon Aurora database server.

For additional information, including details on parameters and properties, see the [AWS documentation on RDS cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Overview.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

An `aws_rds_cluster` resource block uses resource parameters to search for an RDS cluster, and then tests that RDS cluster.  If no RDS clusters match, no error is raised, but the `exists` matcher will return `false` and all properties will be `nil`.  If more than one RDS cluster matches (due to vague search parameters), an error is raised.

```ruby
describe aws_rds_cluster('test-cluster-id') do
  it { should exist }
end
```

    # Can also use hash syntax
```ruby
describe aws_rds_cluster(db_cluster_identifier: 'test-cluster-id') do
  it { should exist }
end
```

## Parameters

`db_cluster_identifier` _(required)_

: This resource accepts a single parameter, the user-supplied cluster identifier. This parameter isn't case-sensitive.
  This can be passed either as a string or as a `db_cluster_identifier: 'value'` key-value entry in a hash.

## Properties

For a comprehensive list of properties available to test on an RDS cluster see the [AWS Response Object](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/DBCluster.html).

## Examples

**Test the engine used with an RDS cluster.**

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'awsrds123') do
  its('engine')         { should eq 'mysql' }
  its('engine_version') { should eq '5.6.37' }
end
```

**Test the storage allocated to an RDS cluster.**

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'awsrds123') do
  its('storage_encrypted') { should eq true }
  its('allocated_storage') { should eq 10 }
end
```

**Test the cluster status and master username.**

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'awsrds123') do
  its('master_username') { should eq 'db-maintain' }
  its('status') { should eq 'available' }
end
```

**Test the maximum and minimum capacity of a serverless RDS cluster.**

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'awsrds123') do
  its('scaling_configuration_info.min_capacity') { should eq 2 }
  its('scaling_configuration_info.max_capacity') { should eq 64 }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'AnExistingRDS') do
  it { should exist }
end
```

```ruby
describe aws_rds_cluster(db_cluster_identifier: 'ANonExistentRDS') do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="RDS:Client:DBClusterMessage" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon RDS](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazonrds.html).
