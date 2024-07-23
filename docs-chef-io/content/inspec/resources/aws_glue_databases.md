+++
title = "aws_glue_databases Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_glue_databases"
identifier = "inspec/resources/aws/aws_glue_databases Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_glue_databases` InSpec audit resource to test properties of multiple Glue databases.

The AWS::Glue::Database resource specifies a logical grouping of tables in AWS Glue.

For additional information, including details on parameters and properties, see the [AWS documentation on Glue Database](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-database.html).

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

Ensure that a database name exists.

```ruby
describe aws_glue_databases
  it { should exist }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`names`
: The name of a database. For Hive compatibility, this is folded to lowercase when it is stored.

`descriptions`
: A description of a database.

`location_uris`
: The location of a database (for example, an HDFS path).

`parameters`
: These key-value pairs define parameters and properties of a database.

`create_times`
: The time at which the metadata database was created in the catalog.

`create_table_default_permissions`
: Creates a set of default permissions on the table for principals..

`target_databases`
: A DatabaseIdentifier structure that describes a target database for resource linking.

`catalog_ids`
: The ID of the Data Catalog in which a database resides.

## Examples

**Ensure a database name is available.**

```ruby
describe aws_glue_databases
  its('names') { should include 'GLUE_DATABASE_NAME' }
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

This resource has the following special matchers.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_glue_databases
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_glue_databases
  it { should_not exist }
end
```

### be_available

Use `should` to check if a database name is available.

```ruby
describe aws_glue_databases
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="EC2:Client:GetDatabasesResponse" %}}
