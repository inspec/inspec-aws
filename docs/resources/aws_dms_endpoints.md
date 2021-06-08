---
title: About the aws_dms_endpoints Resource
platform: aws
---

# aws\_dms\_endpoints

Use the `aws_dms_endpoints` InSpec audit resource to test properties of a single specific Athena Work Group.

The AWS::DMS::Endpoint resource creates an AWS DMS endpoint.

## Syntax

Ensure that an endpoint exists.

    describe aws_dms_endpoints do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on DMS Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html).

## Properties

| Property | Description|
| --- | --- |
| endpoint_identifiers | The endpoint_identifiers of the endpoint. |
| endpoint_types | The endpoint_types of the endpoint. |
| engine_names | The engine name of the endpoint. |
| engine_display_names | The engine display names of the endpoint. |
| usernames | The usernames of the endpoint. |
| server_names | The server names of the endpoint. |
| ports | The ports of the endpoint. |
| database_names | The database names of the endpoint. |
| extra_connection_attributes | The extra connection attributes of the endpoint. |
| statuses | The statuses of the endpoint. |
| kms_key_ids | The kms key ids of the endpoint. |
| endpoint_arns | The endpoint arns of the endpoint. |
| certificate_arns | The certificate arns of the endpoint. |
| ssl_modes | The ssl modes of the endpoint. |
| service_access_role_arns | The service access role arns of the endpoint. |
| external_table_definitions | The external table definitions of the endpoint. |
| external_ids | The external ids of the endpoint. |
| dynamo_db_settings | The dynamo_db_settings of the endpoint. |
| s3_settings | The s3_settings of the endpoint. |
| dms_transfer_settings | The dms_transfer_settings of the endpoint. |
| mongo_db_settings | The mongo_db_settings of the endpoint. |
| kinesis_settings | The kinesis_settings of the endpoint. |
| kafka_settings | The kafka_settings of the endpoint. |
| elasticsearch_settings | The elasticsearch_settings of the endpoint. |
| neptune_settings | The neptune_settings of the endpoint. |
| redshift_settings | The redshift_settings of the endpoint. |
| postgre_sql_settings | The postgre_sql_settings of the endpoint. |
| my_sql_settings | The my_sql_settings of the endpoint. |
| oracle_settings | The oracle_settings of the endpoint. |
| sybase_settings | The sybase_settings of the endpoint. |
| microsoft_sql_server_settings | The microsoft_sql_server_settings of the endpoint. |
| ibm_db_2_settings | The ibm_db_2_settings of the endpoint. |
| doc_db_settings | The doc_db_settings of the endpoint. |

## Examples

### Ensure a engine name is available.
    describe aws_dms_endpoints do
      its('engine_names') { should include 'engine-name' }
    end

### Ensure that the port listens to the specific endpoint arn.
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

Use `should` to check if the endpoint is available.

    describe aws_dms_endpoints do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `dmsmigrationservice_client:client:describe_endpoints` action with `Effect` set to `Allow`.