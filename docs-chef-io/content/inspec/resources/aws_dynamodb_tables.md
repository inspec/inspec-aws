+++
title = "aws_dynamodb_tables Resource"
platform = "aws"
draft = false
gh_repo = "inspec-aws"

[menu.inspec]
title = "aws_dynamodb_tables"
identifier = "inspec/resources/aws/aws_dynamodb_tables Resource"
parent = "inspec/resources/aws"
+++

Use the `aws_dynamodb_table` InSpec audit resource to test properties of a collection of AWS DynamoDB Table.

## Install

{{< readfile file="content/inspec/resources/reusable/md/inspec_aws_install.md" >}}

## Syntax

 Ensure exactly 3 DynamoDB Tables exist.

```ruby
describe aws_dynamodb_tables do
  its('names.count') { should cmp 3 }
end
```

## Parameters

This resource does not require any parameters.

## Properties

`table_names`
: The names of the tables associated with the current account at the current endpoint.


For a comprehensive list of properties available, see [the API reference documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ListTables.html)

## Examples

**Ensure DynamoDB Tables are encrypted.**

```ruby
aws_dynamodb_tables.table_names.each do |table|
  describe aws_dynamodb_table(table_name: table) do
    it { should exist }
    it { should be_encrypted}
  end
end
```

**Ensure the DynamoDB Tables exists and encrypted.**

```ruby
aws_dynamodb_tables.where(table_names: 'table_name').table_names.each do |table|
    describe aws_dynamodb_table(table_name: table) do
        it { should exist }
        it { should be_encrypted }
    end
end
```

**Ensure the DynamoDB table exist.**

```ruby
describe aws_dynamodb_tables do
    its('table_names') { should include 'table_name'}
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}

### exist

The control will pass if the describe returns at least one result.

Use `should` to test the entity should exist.

```ruby
describe aws_dynamodb_tables.where( <property>: <value> ) do
  it { should exist }
end
```

Use `should_not` to test the entity should not exist.

```ruby
describe aws_dynamodb_tables.where( <property>: <value> ) do
  it { should_not exist }
end
```

## AWS Permissions

{{% inspec-aws/aws_permissions_principal action="DynamoDB:Client:ListTablesOutput" %}}

You can find detailed documentation at [Actions, Resources, and Condition Keys for Amazon Dynamodb](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazondynamodb.html).
