require 'helper'
require 'aws_dynamodb_tables'
require 'aws-sdk-core'

class AwsDynamodbTablesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsDynamoDbTables.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsDynamoDbTables.new('rubbish') }
  end

  def test_tables_non_existing_for_empty_response
    refute AwsDynamoDbTables.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsDynamodbTablesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_tables
    mock_table = {}
    mock_table[:table_names] = ['table-1234', 'table-5678']
    data[:data] = mock_table
    data[:client] = Aws::DynamoDB::Client
    @tables = AwsDynamoDbTables.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_tables_exist
    assert @tables.exist?
  end

  def test_table_names
    assert_equal(@tables.table_names, ['table-1234', 'table-5678'])
  end
end