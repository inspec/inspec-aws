---
title: About the aws_dms_endpoint Resource
platform: aws
---

# aws\_dms\_endpoint

Use the `aws_dms_endpoint` InSpec audit resource to test properties of a single specific Athena Work Group.

The AWS::DMS::Endpoint resource creates an AWS DMS endpoint.

## Syntax

Ensure that an arn exists.

    describe aws_dms_endpoint(endpoint_arn: 'test-arn') do
      it { should exist }
    end

## Parameters

`endpoint_arn` _(required)_

For additional information, see the [AWS documentation on DMS Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html).

## Properties

| Property | Description|
| --- | --- |
| endpoint_identifier | The endpoint_identifier of the endpoint. |
| endpoint_type | The endpoint_type of the endpoint. |
| engine_name | The engine name of the endpoint. |
| engine_display_name | The engine display name of the endpoint. |
| username | The username of the endpoint. |
| server_name | The server names of the endpoint. |
| port | The port of the endpoint. |
| database_name | The database name of the endpoint. |
| extra_connection_attributes | The extra connection attributes of the endpoint. |
| status | The status of the endpoint. |
| kms_key_id | The kms key id of the endpoint. |
| endpoint_arn | The endpoint arn of the endpoint. |
| certificate_arn | The certificate arn of the endpoint. |
| ssl_mode | The ssl mode of the endpoint. |
| service_access_role_arns | The service access role arns of the endpoint. |
| external_table_definition | The external table definition of the endpoint. |
| external_id | The external id of the endpoint. |
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
    describe aws_dms_endpoint(endpoint_arn: 'test-arn') do
      its('engine_name') { should eq 'test-engine-name' }
    end

### Ensure that the port listens to the specific endpoint arn.
    describe aws_dms_endpoint(endpoint_arn: 'test-arn') do
        its('port') { should eq 3306 }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_dms_endpoint(endpoint_arn: 'test-arn') do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.

    describe aws_dms_endpoint(endpoint_arn: 'dummy') do
      it { should_not exist }
    end

### be_available

Use `should` to check if the endpoint is available.

    describe aws_dms_endpoint(endpoint_arn: 'test-arn') do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `dmsmigrationservice_client:client:describe_endpoints` action with `Effect` set to `Allow`.