require 'helper'
require 'aws_dynamodb_table'
require 'aws-sdk-core'

class AwsDynamodbTableConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_valid_args
    AwsDynamoDbTable.new(table_name: 'valid_table_name', client_args: { stub_responses: true })
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(table_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(rubbish: 9) }
  end

  def test_fails_with_more_than_one_parameter
    assert_raises(ArgumentError) { AwsDynamoDbTable.new(table_name: 'fail with more than 1 paramenter', table_arn: 'fake_arn') }
  end

  def test_table_non_existing
    refute AwsDynamoDbTable.new(table_name: 'table-1234abcd', client_args: { stub_responses: true }).exists?
  end

end

class AwsDynamodbTableTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_table
    mock_table = {}
    mock_table[:attribute_definitions] = [{ attribute_name: 'Artist',
                                            attribute_type: 'S' }]
    mock_table[:table_name] = 'default'
    mock_table[:key_schema] = [{ attribute_name: 'Artist',
                                 key_type: 'HASH' }]
    mock_table[:table_status] = 'Complete'
    mock_table[:creation_date_time] = Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_table[:provisioned_throughput] = { number_of_decreases_today: 1,
                                            read_capacity_units: 2,
                                            write_capacity_units: 3 }
    mock_table[:table_size_bytes] = 10
    mock_table[:item_count] = 1
    mock_table[:table_arn] = '1234'
    mock_table[:table_id] = '1442323'
    mock_table[:sse_description] = { status: 'ENABLED',
                                     sse_type: 'KMS',
                                     kms_master_key_arn: "arn:kms:us-west-2:243254392u3-32r324" }
    data[:data] = { table: mock_table }
    data[:client] = Aws::DynamoDB::Client
    @table = AwsDynamoDbTable.new(table_name: 'default', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_table_exists
    assert @table.exists?
  end

  def test_table_name
    assert_equal(@table.table_name, 'default')
  end

  def test_table_status
    assert_equal(@table.table_status, 'Complete')
  end

  def test_table_creation_date
    assert_equal(@table.creation_date_time, Time.parse("2013-06-12T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_table_number_of_decreases_today
    assert_equal(@table.provisioned_throughput.number_of_decreases_today, 1)
  end

  def test_table_write_capacity_units
    assert_equal(@table.provisioned_throughput.write_capacity_units, 3)
  end

  def test_table_read_capacity_units
    assert_equal(@table.provisioned_throughput.read_capacity_units, 2)
  end

  def test_table_item_count
    assert_equal(@table.item_count, 1)
  end

  def test_table_table_arn
    assert_equal(@table.table_arn, '1234')
  end
end