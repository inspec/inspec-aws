---
title: About the aws_glue_database Resource
platform: aws
---

# aws\_glue\_database

Use the `aws_glue_database` InSpec audit resource to test properties of a single Glue database.

The AWS::Glue::Database resource specifies a logical grouping of tables in AWS Glue.

## Syntax

Ensure that a database name exists.

    describe aws_glue_database(name: 'GLUE_DATABASE_NAME')
      it { should exist }
    end

## Parameters

`name` _(required)_

The name of the Glue database.

For additional information, see the [AWS documentation on Glue Database](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-database.html).

## Properties

| Property | Description|
| --- | --- |
| name | The name of the database. For Hive compatibility, this is folded to lowercase when it is stored. |
| description | A description of the database. |
| location_uri | The location of the database (for example, an HDFS path). |
| parameters | These key-value pairs define parameters and properties of the database. |
| create_time | The time at which the metadata database was created in the catalog. |
| create_table_default_permissions (principal (data_lake_principal_identifier)) | An identifier for the AWS Lake Formation principal. |
| create_table_default_permissions (permissions) | The permissions that are granted to the principal. |
| target_database (catalog_id) | The ID of the Data Catalog in which the database resides. |
| target_database (database_name) | The name of the catalog database. |
| catalog_id | The ID of the Data Catalog in which the database resides. |

## Examples

### Ensure a database name is available.

    describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
      its('name') { should eq 'GLUE_DATABASE_NAME' }
    end

### Ensure a target database name is available.

    describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
        its('target_database.database_name') { should eq 'CATALOG_DATABASE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the database name is available.

    describe aws_glue_database(name: 'GLUE_DATABASE_NAME') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:GetDatabaseResponse` action with `Effect` set to `Allow`.