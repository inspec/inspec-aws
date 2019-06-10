require 'helper'
require 'aws_dynamodb_table'
require 'aws-sdk-core'
require_relative 'mock/aws_dynamodb_table_mock'

class AwsDynamodbTableConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_valid_args
    AwsDynamoDbTable.new(table_name: 'valid_table_name', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(rubbish: 9) }
  end

  def test_fails_with_more_than_one_parameter
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(table_name: 'fail with more than 1 paramenter', table_arn: 'fake_arn') }
  end

  def test_table_non_existing
    not_existing = {}
    not_existing[:method] = :describe_table
    not_existing[:data] = Aws::DynamoDB::Errors::ResourceNotFoundException.new(nil, nil)
    not_existing[:client] = Aws::DynamoDB::Client
    refute AwsDynamoDbTable.new(table_name: 'table_that_doesnt_exist', client_args: { stub_responses: true }, stub_data: [not_existing]).exists?
  end

end

class AwsDynamodbTableTest < Minitest::Test

  def setup
    # Given
    @mock = AwsDynamoDbTableMock.new
    @mock_config = @mock.configuration

    # When
    @config = AwsDynamoDbTable.new(table_name: @mock_config[:table_name],
                                   client_args: { stub_responses: true },
                                   stub_data: @mock.stub_data)
  end

  def test_table_exists
    assert @config.exists?
  end

  def test_table_name
    assert_equal(@config.table_name, @mock_config[:table_name])
  end

  def test_table_status
    assert_equal(@config.table_status, @mock_config[:table_status])
  end

  def test_table_creation_date
    assert_equal(@config.creation_date, @mock_config[:creation_date_time].strftime('%m/%d/%Y'))
  end

  def test_table_number_of_decreases_today
    assert_equal(@config.number_of_decreases_today, @mock_config[:provisioned_throughput][:number_of_decreases_today])
  end

  def test_table_write_capacity_units
    assert_equal(@config.write_capacity_units, @mock_config[:provisioned_throughput][:write_capacity_units])
  end

  def test_table_read_capacity_units
    assert_equal(@config.read_capacity_units, @mock_config[:provisioned_throughput][:read_capacity_units])
  end

  def test_table_item_count
    assert_equal(@config.item_count, @mock_config[:item_count])
  end

  def test_table_table_arn
    assert_equal(@config.table_arn, @mock_config[:table_arn])
  end

  def test_table_attributes
    assert_equal(@config.attributes, @mock_config[:attribute_definitions])
  end

  def test_table_key_schema
    assert_equal(@config.key_schema, @mock_config[:key_schema])
  end
end