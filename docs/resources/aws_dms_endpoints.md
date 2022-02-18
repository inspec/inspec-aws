---
title: About the aws_dms_endpoints Resource
platform: aws
---

# aws_dms_endpoints

Use the `aws_dms_endpoints` InSpec audit resource to test properties of a single specific AWS Database Migration Service (DMS) endpoint.

## Syntax

Ensure that an endpoint exists.

    describe aws_dms_endpoints do
      it { should exist }
    end

## Parameters

This resource does not require any mandatory parameters.

For additional information, see the [AWS documentation on the `AWS::Batch::JobDefinition` resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-batch-jobdefinition.html).


For additional information, see the [AWS documentation on DMS Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html).

## Properties

| Property  | Description | Field |
| :---: | :--- | :---: |
| endpoint_identifiers | The database endpoint identifiers. | endpoint_identifier |
| endpoint_types | The endpoint types. | endpoint_type |
| engine_names | The type of engine for an endpoint. Valid values: `mysql`, `oracle`, `postgres`, `mariadb`, `aurora`, `aurora-postgresql`, `redshift`, `s3`, `db2`, `azuredb`, `sybase`, `dynamodb`, `mongodb`, `kinesis`, `kafka`, `elasticsearch`, `docdb`, `sqlserver`, and `neptune`. | engine_name |
| engine_display_names | An expanded name for an engine name. | engine_display_name |
| usernames | The user names used to connect to an endpoint. | username |
| server_names | The name of the server at an endpoint. | server_name |
| ports | The port value used to access an endpoint. | port |
| database_names | The name of the database at an endpoint. | database_name |
| extra_connection_attributes | Additional connection attributes used to connect to an endpoint. | extra_connection_attributes |
| statuses | The status of an endpoint. | status |
| kms_key_ids | An AWS KMS key identifier that is used to encrypt the connection parameters for an endpoint. | kms_key_id |
| endpoint_arns | The ARN of an endpoint. | endpoint_arn |
| certificate_arns | The ARN used for SSL connection to an endpoint. | certificate_arn |
| ssl_modes | The SSL mode used to connect to an endpoint. | ssl_mode |
| service_access_role_arns | The ARN used by the service access IAM role. | service_access_role_arn |
| external_table_definitions | The external table definition. | external_table_definition |
| external_ids | Value returned by a call to CreateEndpoint that can be used for cross-account validation. | external_id |
| dynamo_db_settings | Settings in JSON format for an Amazon DynamoDB endpoint. | dynamo_db_settings |
| s3_settings | Settings in JSON format for an Amazon S3 endpoint. | s3_settings |
| dms_transfer_settings | The settings in JSON format for a DMS transfer type of source endpoint. | dms_transfer_settings |
| mongo_db_settings | The settings for a MongoDB source endpoint. | mongo_db_settings |
| kinesis_settings | The settings for a Amazon Kinesis target endpoint. | kinesis_settings |
| kafka_settings | The settings for an Apache Kafka endpoint. | kafka_settings |
| elasticsearch_settings | The settings for an Elasticsearch endpoint. | elasticsearch_settings |
| neptune_settings | The settings for an Amazon Neptune target endpoint. | neptune_settings |
| redshift_settings | The settings for an Amazon Redshift endpoint. | redshift_settings |
| postgre_sql_settings | The settings for a PostgreSQL source and target endpoint. | postgre_sql_settings |
| my_sql_settings | The settings for a MySQL source and target endpoint. | my_sql_settings |
| oracle_settings | The settings for an Oracle source and target endpoint. | oracle_settings |
| sybase_settings | The settings for a SAP ASE source and target endpoint. | sybase_settings |
| microsoft_sql_server_settings | The settings for a Microsoft SQL Server source and target endpoint. | microsoft_sql_server_settings |
| ibm_db_2_settings | The settings for an IBM Db2 LUW source endpoint. | ibm_db_2_settings |
| doc_db_settings | The settings for a DocumentDB endpoint. | doc_db_settings |

## Examples

### Ensure an engine name is available.

    describe aws_dms_endpoints do
      its('engine_names') { should include 'ENGINE_NAME' }
    end

### Ensure that an endpoint listens to a specific port.

    describe aws_dms_endpoints do
        its('ports') { should include 3306 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_dms_endpoints do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_dms_endpoints do
      it { should_not exist }
    end

### be_available

Use `should` to check if an endpoint is available.

    describe aws_dms_endpoints do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `DatabaseMigrationService:Client:DescribeEndpointsResponse` action with `Effect` set to `Allow`.
