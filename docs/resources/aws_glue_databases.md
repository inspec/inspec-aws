---
title: About the aws_glue_databases Resource
platform: aws
---

# aws\_glue\_databases

Use the `aws_glue_databases` InSpec audit resource to test properties of multiple Glue databases.

The AWS::Glue::Database resource specifies a logical grouping of tables in AWS Glue.

## Syntax

Ensure that a database name exists.

    describe aws_glue_databases
      it { should exist }
    end

## Parameters

This resource does not expect any parameters.

For additional information, see the [AWS documentation on Glue Database](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-database.html).

## Properties

| Property | Description|
| --- | --- |
| names | The name of a database. For Hive compatibility, this is folded to lowercase when it is stored. |
| descriptions | A description of a database. |
| location_uris | The location of a database (for example, an HDFS path). |
| parameters | These key-value pairs define parameters and properties of a database. |
| create_times | The time at which the metadata database was created in the catalog. |
| create_table_default_permissions | Creates a set of default permissions on the table for principals.. |
| target_databases | A DatabaseIdentifier structure that describes a target database for resource linking. |
| catalog_ids | The ID of the Data Catalog in which a database resides. |

## Examples

### Ensure a database name is available.

    describe aws_glue_databases
      its('names') { should include 'GLUE_DATABASE_NAME' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `get` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_glue_databases
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_glue_databases
      it { should_not exist }
    end

### be_available

Use `should` to check if a database name is available.

    describe aws_glue_databases
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `EC2:Client:GetDatabasesResponse` action with `Effect` set to `Allow`.
