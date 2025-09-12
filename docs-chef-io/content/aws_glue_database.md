+++
title = "aws_glue_database resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_glue_database"
identifier = "inspec/resources/aws/aws_glue_database resource"
parent = "inspec/resources/aws"
+++

Use the `aws_glue_database` InSpec audit resource to test properties of a single Glue database.

The AWS::Glue::Database resource specifies a logical grouping of tables in AWS Glue.

For additional information, including details on parameters and properties, see the [AWS documentation on Glue Database](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-database.html).

## Syntax

Ensure that a database name exists.

```ruby
describe aws_glue_database(name: 'GLUE_DATABASE_NAME')
  it { should exist }
end
```

## Parameters

`name` _(required)_

: The name of the Glue database.

## Properties

`name`
: The name of the database. For Hive compatibility, this is folded to lowercase when it is stored.

`description`
: A description of the database.

`location_uri`
: The location of the database (for example, an HDFS path).

`parameters`
: These key-value pairs define parameters and properties of the database.

`create_time`
: The time at which the metadata database was created in the catalog.

`create_table_default_permissions (principal (data_lake_principal_identifier))`
: An identifier for the AWS Lake Formation principal.

`create_table_default_permissions (permissions)`
: The permissions that are granted to the principal.

`target_database (catalog_id)`
: The ID of the Data Catalog in which the database resides.

`target_database (database_name)`
: The name of the catalog database.

`catalog_id`
: The ID of the Data Catalog in which the database resides.

## Examples

**Ensure a database name is available.**

```ruby
describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
  its('name') { should eq 'GLUE_DATABASE_NAME' }
end
```

**Ensure a target database name is available.**

```ruby
describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
    its('target_database.database_name') { should eq 'CATALOG_DATABASE_NAME' }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the database name is available.

```ruby
describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetDatabaseResponse" %}}
