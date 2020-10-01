---
title: About the aws_dynamodb_tables Resource
platform: aws
---

# aws\_dynamodb\_tables

Use the `aws_dynamodb_table` InSpec audit resource to test properties of a collection of AWS DynamoDB Table.

## Syntax

 Ensure exactly 3 DynamoDB Tables exist.

    describe aws_dynamodb_tables do
      its('names.count') { should cmp 3 }
    end
    
#### Parameters

This resource does not expect any parameters.

See also the [AWS documentation on DynamoDB](https://docs.aws.amazon.com/dynamodb/?id=docs_gateway).

## Properties

|Property                     | Description|
| ---                         | --- |
|table\_names                 | The names of the tables associated with the current account at the current endpoint. |


For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ListTables.html)

## Examples

##### Ensure DynamoDB Tables are encrypted

    aws_dynamodb_tables.table_names.each do |table|
      describe aws_dynamodb_table(table_name: table) do
        it { should exist }
        it { should be_encrypted}
      end
    end

## Matchers

For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

#### exist

The control will pass if the describe returns at least one result.

Use `should_not` to test the entity should not exist.

    describe aws_dynamodb_tables.where( <property>: <value> ) do
      it { should exist }
    end

    describe aws_dynamodb_tables.where( <property>: <value> ) do
      it { should_not exist }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `dynamodb:ListTables` action with Effect set to Allow.

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Dynamodb](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazondynamodb.html).
