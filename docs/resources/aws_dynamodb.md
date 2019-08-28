---
title: About the aws_dynamodb_table Resource
platform: aws
---

# aws\_dynamodb\_table

Use the `aws_dynamodb_table` InSpec audit resource to test properties of a single DynamoDb Table.

## Syntax

##### Ensure an DynamoDb Table exists.
    describe aws_dynamodb_table(table_name: 'table-name') do
      it { should exist }
    end
      
#### Parameters
##### table_name _(required)_

The table name used by this DynamoDb Table. This must be passed as a `table_name: 'value'` key-value entry in a hash.

## Properties

|Property                  | Description|
| ---                      | --- |
|table_name                | The name of the DynamoDb Table.  |
|table_status              | The status of the DynamoDb Table. |
|table_arn                 | The Amazon Resource Names of the DynamoDb Table. |
|creation_date             | The date the DynamoDb Table was created. eg. `01/01/2019`|
|number\_of\_decreases\_today | The number of provisioned throughput decreases for this table during this UTC calendar day. |
|write\_capacity\_units      | The maximum number of writes consumed per second before DynamoDb returns a ThrottlingException. |
|read\_capacity\_units       | The maximum number of strongly consistent reads consumed per second before DynamoDb returns a ThrottlingException. |
|item_count                | The number of entries in the  DynamoDb Table. |
|attributes                | An array of attributes that describe the key schema for the table and indexes. This is returned as a hash. Each entry is composed of: `attribute_name` - The name of this key attribute. `attribute_type` - The datatype of the attribute : `B` - Boolean, `N` - Number, `S` - string|
|key_schema                | Specifies the attributes that make up the primary key for a table or an index. This is returned as a hash. The attributes in KeySchema must also be defined in the Attributes array. Each element in the KeySchemaElement array is composed of: `attribute_name` - The name of this key attribute. `key_type` - The role that the key attribute will assume: `HASH` - partition key, `RANGE` - sort key|
|secondary\_global\_table    | This will only be populated if a global secondary table has been referenced on the selected table. This will return a hash of values with a prefix of `global_sec_indexes` for each key. eg. `global_sec_indexes_table_name`  |

## Examples

##### Ensure DynamoDb Table status is active
    describe aws_dynamodb_table(table_name: 'table-name') do
      its('table_status') { should eq 'ACTIVE' }
    end

##### Ensure DynamoDb Table has an attribute
    describe aws_dynamodb_table(table_name: 'table-name') do
      its('attributes') { should_not be_empty }
      its('attributes') { should include({:attribute_name =>'table_field', :attribute_type =>'N'}) }
    end

##### Ensure DynamoDb Table has a key_schema
    describe aws_dynamodb_table(table_name: 'table-name') do
      its('key_schema') { should_not be_empty }
      its('key_schema') { should include({:attribute_name =>'table_field', :key_type =>'HASH'}) }
    end


## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_dynamodb_table(table_name: 'table-name') do
      it { should exist }
    end

    describe aws_dynamodb_table(table_name: 'table-name') do
      it { should_not exist }
    end
    
## AWS Permissions
Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `DynamoDB::DescribeTable` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Dynamodb](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazondynamodb.html).
