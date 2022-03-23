+++
title = "aws_dynamodb_table Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_dynamodb_table"
identifier = "inspec/resources/aws/aws_dynamodb_table Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_dynamodb_table` InSpec audit resource to test properties of a single DynamoDb Table.

## Installation

{{% inspec_aws_install %}}

## Syntax

### Ensure an DynamoDb Table exists.

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
  it { should exist }
end
```

## Parameters

`table_name` _(required)_

: The table name used by this DynamoDb Table. This must be passed as a `table_name: 'value'` key-value entry in a hash.

## Properties

`table_name`
: The name of the DynamoDb Table.

`table_status`
: The status of the DynamoDb Table.

`table_arn`
: The Amazon Resource Names of the DynamoDb Table.

`creation_date`
: The date the DynamoDb Table was created. eg. `01/01/2019`.

`number_of_decreases_today`
: The number of provisioned throughput decreases for this table during this UTC calendar day.

`write_capacity_units`
: The maximum number of writes consumed per second before DynamoDb returns a ThrottlingException.

`read_capacity_units`
: The maximum number of strongly consistent reads consumed per second before DynamoDb returns a ThrottlingException.

`item_count`
: The number of entries in the  DynamoDb Table.

`attributes`
: An array of attributes that describe the key schema for the table and indexes. This is returned as a hash. Each entry is composed of: `attribute_name` - The name of this key attribute. `attribute_type` - The datatype of the attribute : `B` - Boolean, `N` - Number, `S` - string.

`key_schema`
: Specifies the attributes that make up the primary key for a table or an index. This is returned as a hash. The attributes in KeySchema must also be defined in the Attributes array. Each element in the KeySchemaElement array is composed of: `attribute_name` - The name of this key attribute. `key_type` - The role that the key attribute will assume: `HASH` - partition key, `RANGE` - sort key.

`global_secondary_indexes`
: A list of global secondary indexes if there is any referenced on the selected table.

## Examples

**Ensure DynamoDb Table status is active.**

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
  its('table_status') { should eq 'ACTIVE' }
end
```

**Ensure DynamoDb Table has an attribute.**

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
  its('attributes') { should_not be_empty }
  its('attributes') { should include({:attribute_name =>'table_field', :attribute_type =>'N'}) }
end
```

**Ensure DynamoDb Table has a key_schema.**

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
  its('key_schema') { should_not be_empty }
  its('key_schema') { should include({:attribute_name =>'table_field', :key_type =>'HASH'}) }
end
```

**Ensure DynamoDb Table has the correct global secondary indexes set.**

```ruby
aws_dynamodb_table(table_name: 'table-name').global_secondary_indexes.each do |global_sec_idx|
  describe global_sec_idx do
    its('index_name') { should eq 'TitleIndex' }
    its('index_status') { should eq 'ACTIVE' }
    its('key_schema') { should include({:attribute_name =>'Title', :key_type =>'HASH'}) }
    its('provisioned_throughput.write_capacity_units') { should cmp 10 }
    its('provisioned_throughput.read_capacity_units') { should cmp 10 }
    its('projection.projection_type') { should eq 'INCLUDE' }
  end
end
```

**Ensure DynamoDb Table is encrypted.**

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
   it { should be_encrypted}
end
```

## Matchers

{{% inspec_matchers_link %}}

#### be_encrypted

The `be_encrypted` matcher tests if the DynamoDB Table is encrypted.

```ruby
it { should be_encrypted }
```

### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
  it { should exist }
end
```

```ruby
describe aws_dynamodb_table(table_name: 'table-name') do
  it { should_not exist }
end
```

## AWS Permissions

{{% aws_permissions_principal action="DynamoDB:Client:DescribeTableOutput" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Dynamodb](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazondynamodb.html).
