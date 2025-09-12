+++
title = "aws_dms_endpoints resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.aws]
title = "aws_dms_endpoints"
identifier = "inspec/resources/aws/aws_dms_endpoints resource"
parent = "inspec/resources/aws"
+++

Use the `aws_dms_endpoints` InSpec audit resource to test properties of a single specific AWS Database Migration Service (DMS) endpoint.

For additional information, including details on parameters and properties, see the [AWS documentation on DMS Endpoint](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dms-endpoint.html).

## Syntax

Ensure that an endpoint exists.

```ruby
describe aws_dms_endpoints do
  it { should exist }
end
```

## Parameters

There are no required parameters.

## Properties

`endpoint_identifiers`
: The database endpoint identifiers.

`endpoint_types`
: The endpoint types.

`engine_names`
: The type of engine for an endpoint. Valid values: `mysql`, `oracle`, `postgres`, `mariadb`, `aurora`, `aurora-postgresql`, `redshift`, `s3`, `db2`, `azuredb`, `sybase`, `dynamodb`, `mongodb`, `kinesis`, `kafka`, `elasticsearch`, `docdb`, `sqlserver`, and `neptune`.

`engine_display_names`
: An expanded name for an engine name.

`usernames`
: The user names used to connect to an endpoint.

`server_names`
: The name of the server at an endpoint.

`ports`
: The port value used to access an endpoint.

`database_names`
: The name of the database at an endpoint.

`extra_connection_attributes`
: Additional connection attributes used to connect to an endpoint.

`statuses`
: The status of an endpoint.

`kms_key_ids`
: An AWS KMS key identifier that is used to encrypt the connection parameters for an endpoint.

`endpoint_arns`
: The ARN of an endpoint.

`certificate_arns`
: The ARN used for SSL connection to an endpoint.

`ssl_modes`
: The SSL mode used to connect to an endpoint.

`service_access_role_arns`
: The ARN used by the service access IAM role.

`external_table_definitions`
: The external table definition.

`external_ids`
: Value returned by a call to CreateEndpoint that can be used for cross-account validation.

`dynamo_db_settings`
: Settings in JSON format for an Amazon DynamoDB endpoint.

`s3_settings`
: Settings in JSON format for an Amazon S3 endpoint.

`dms_transfer_settings`
: The settings in JSON format for a DMS transfer type of source endpoint.

`mongo_db_settings`
: The settings for a MongoDB source endpoint.

`kinesis_settings`
: The settings for a Amazon Kinesis target endpoint.

`kafka_settings`
: The settings for an Apache Kafka endpoint.

`elasticsearch_settings`
: The settings for an Elasticsearch endpoint.

`neptune_settings`
: The settings for an Amazon Neptune target endpoint.

`redshift_settings`
: The settings for an Amazon Redshift endpoint.

`postgre_sql_settings`
: The settings for a PostgreSQL source and target endpoint.

`my_sql_settings`
: The settings for a MySQL source and target endpoint.

`oracle_settings`
: The settings for an Oracle source and target endpoint.

`sybase_settings`
: The settings for a SAP ASE source and target endpoint.

`microsoft_sql_server_settings`
: The settings for a Microsoft SQL Server source and target endpoint.

`ibm_db_2_settings`
: The settings for an IBM Db2 LUW source endpoint.

`doc_db_settings`
: The settings for a DocumentDB endpoint.

## Examples

**Ensure an engine name is available.**

```ruby
describe aws_dms_endpoints do
  its('engine_names') { should include 'ENGINE_NAME' }
end
```

**Ensure that an endpoint listens to a specific port.**

```ruby
describe aws_dms_endpoints do
    its('ports') { should include 3306 }
end
```

## Matchers

{{< readfile file="content/reusable/md/inspec_matchers_link.md" >}}

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

```ruby
describe aws_dms_endpoints do
  it { should exist }
end
```

Use `should_not` to test the entity does not exist.

```ruby
describe aws_dms_endpoints do
  it { should_not exist }
end
```

### be_available

Use `should` to check if an endpoint is available.

```ruby
describe aws_dms_endpoints do
  it { should be_available }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="DatabaseMigrationService:Client:DescribeEndpointsResponse" %}}
