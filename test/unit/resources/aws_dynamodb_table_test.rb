require 'helper'
require 'aws_dynamodb_table'
require 'aws-sdk-core'

class AwsDynamodbTableConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsDynamodbTable.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_valid_args
    AwsDynamodbTable.new(table_name: 'valid_table_name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsDynamodbTable.new(rubbish: 9) }
  end

  def test_fails_with_more_than_one_parameter
    assert_raises(ArgumentError) { AwsDynamodbTable.new(table_name: 'fail with more than 1 paramenter', table_arn: 'aws_arn') }
  end

  def test_table_non_existing
    not_existing = {}
    not_existing[:method] = :describe_table
    not_existing[:data] = Aws::DynamoDB::Errors::ResourceNotFoundException.new(nil, nil)
    not_existing[:client] = Aws::DynamoDB::Client
    refute AwsDynamodbTable.new(table_name: 'table_that_doesnt_exist', client_args: { stub_responses: true }, stub_data: [not_existing]).exists?
  end

end

class AwsDynamodbTableTest < Minitest::Test
  def setup
    mock_table = {}
    mock_table[:table_name] = 'table_123'
    mock_table[:table_status] = 'ACTIVE'
    mock_table[:creation_date_time] = Time.parse('2019-06-07 16:28:13 +0100')
    mock_table[:provisioned_throughput] = {}
    mock_table[:provisioned_throughput][:number_of_decreases_today] = 0
    mock_table[:provisioned_throughput][:write_capacity_units] = 20
    mock_table[:provisioned_throughput][:read_capacity_units] = 20
    mock_table[:item_count] = 100
    mock_table[:table_arn] = 'arn:aws:dynamodb:region:510367013858:table/table_123'
    mock_table[:attribute_definitions] = [{:attribute_name =>'Id', :attribute_type =>'N'},{:attribute_name =>'Name', :attribute_type =>'S'},{:attribute_name =>'Registered', :attribute_type =>'B'}]
    mock_table[:key_schema] = [{:attribute_name =>'Id', :key_type =>'HASH'},{:attribute_name =>'Title', :key_type =>'RANGE'}]

    stub_data = {}
    stub_data[:method] = :describe_table
    stub_data[:data] = {table: mock_table}
    stub_data[:client] = Aws::DynamoDB::Client

    @dynamodb_table = AwsDynamodbTable.new(table_name: mock_table[:table_name], client_args: { stub_responses: true }, stub_data: [stub_data])
  end

  def test_table_exists
    assert @dynamodb_table.exists?
  end

  def test_table_name
    assert_equal(@dynamodb_table.table_name, 'table_123')
  end

  def test_table_status
    assert_equal(@dynamodb_table.table_status, 'ACTIVE')
  end

  def test_table_creation_date
    assert_equal(@dynamodb_table.creation_date, '06/07/2019')
  end

  def test_table_number_of_decreases_today
    assert_equal(@dynamodb_table.number_of_decreases_today, 0)
  end

  def test_table_write_capacity_units
    assert_equal(@dynamodb_table.write_capacity_units, 20)
  end

  def test_table_read_capacity_units
    assert_equal(@dynamodb_table.read_capacity_units, 20)
  end

  def test_table_item_count
    assert_equal(@dynamodb_table.item_count, 100)
  end

  def test_table_table_arn
    assert_equal(@dynamodb_table.table_arn, 'arn:aws:dynamodb:region:510367013858:table/table_123')
  end

  def test_table_attributes
    assert_equal(@dynamodb_table.attributes, [{:attribute_name =>'Id', :attribute_type =>'N'},{:attribute_name =>'Name', :attribute_type =>'S'},{:attribute_name =>'Registered', :attribute_type =>'B'}])
  end

  def test_table_key_schema
    assert_equal(@dynamodb_table.key_schema, [{:attribute_name =>'Id', :key_type =>'HASH'},{:attribute_name =>'Title', :key_type =>'RANGE'}])
  end
end