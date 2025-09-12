+++
title = "aws_dms_endpoint resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_dms_endpoint"
identifier = "inspec/resources/aws/aws_dms_endpoint resource"
parent = "inspec/resources/aws"
+++

Use the `aws_dms_endpoint` InSpec audit resource to test properties of a single specific AWS Database Migration Service (DMS) endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on DMS endpoints](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html).

## Syntax

Ensure that an arn exists.

```ruby
describe aws_dms_endpoint(endpoint_arn: 'test-arn') do
  it { should exist }
end
```

## Parameters

`endpoint_arn` _(required)_

: The ARN of the DMS endpoint.

## Properties

`endpoint_identifier`
: The database endpoint identifier.

`endpoint_type`
: The endpoint type.

`engine_name`
: The type of engine for the endpoint. Valid values: `mysql`, `oracle`, `postgres`, `mariadb`, `aurora`, `aurora-postgresql`, `redshift`, `s3`, `db2`, `azuredb`, `sybase`, `dynamodb`, `mongodb`, `kinesis`, `kafka`, `elasticsearch`, `docdb`, `sqlserver`, and `neptune`.

`engine_display_name`
: The expanded name for the engine name.

`username`
: The user name used to connect to the endpoint.

`server_name`
: The name of the server at the endpoint.

`port`
: The port value used to access the endpoint.

`database_name`
: The name of the database at the endpoint.

`extra_connection_attributes`
: Additional connection attributes used to connect to the endpoint.

`status`
: The status of the endpoint.

`kms_key_id`
: An AWS KMS key identifier that is used to encrypt the connection parameters for the endpoint.

`endpoint_arn`
: The ARN of the endpoint.

`certificate_arn`
: The ARN used for SSL connection to the endpoint.

`ssl_mode`
: The SSL mode used to connect to the endpoint.

`service_access_role_arns`
: The ARN used by the service access IAM role.

`external_table_definition`
: The external table definition.

`external_id`
: Value returned by a call to CreateEndpoint that can be used for cross-account validation.

`dynamo_db_settings`
: Settings in JSON format for the target Amazon DynamoDB endpoint.

`s3_settings`
: Settings in JSON format for the target Amazon S3 endpoint.

`dms_transfer_settings`
: The settings in JSON format for the DMS transfer type of source endpoint.

`mongo_db_settings`
: The settings for the MongoDB source endpoint.

`kinesis_settings`
: The settings for the Amazon Kinesis target endpoint.

`kafka_settings`
: The settings for the Apache Kafka endpoint.

`elasticsearch_settings`
: The settings for the Elasticsearch endpoint.

`neptune_settings`
: The settings for the Amazon Neptune target endpoint.

`redshift_settings`
: The settings for the Amazon Redshift endpoint.

`postgre_sql_settings`
: The settings for the PostgreSQL source and target endpoint.

`my_sql_settings`
: The settings for the MySQL source and target endpoint.

`oracle_settings`
: The settings for the Oracle source and target endpoint.

`sybase_settings`
: The settings for the SAP ASE source and target endpoint.

`microsoft_sql_server_settings`
: The settings for the Microsoft SQL Server source and target endpoint.

`ibm_db_2_settings`
: The settings for the IBM Db2 LUW source endpoint.

`doc_db_settings`
: The settings for the DocumentDB endpoint.

## Examples

**Ensure an engine name is available.**

```ruby
describe aws_dms_endpoint(endpoint_arn: 'ENDPOINT_ARN') do
  its('engine_name') { should eq 'ENDPOINT_ENGINE_NAME' }
end
```

**Ensure that the endpoint listens to a specific port.**

```ruby
describe aws_dms_endpoint(endpoint_arn: 'ENDPOINT_ARN') do
    its('port') { should eq 3306 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_dms_endpoint(endpoint_arn: 'ENDPOINT_ARN') do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_dms_endpoint(endpoint_arn: 'ENDPOINT_ARN') do
  it { should_not exist }
end
```

### be_available

Use `should` to check if the endpoint is available.

```ruby
describe aws_dms_endpoint(endpoint_arn: 'ENDPOINT_ARN') do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="DatabaseMigrationService:Client:DescribeEndpointsResponse" %}}
