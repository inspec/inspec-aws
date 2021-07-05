require 'helper'
require 'aws_dms_endpoint'
require 'aws-sdk-core'

class AWSDMSEndpointConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSDMSEndpoint.new(client_args: { stub_responses: true }) }
  end

  def test_accepts_volume_id_as_hash_eight_sign
    AWSDMSEndpoint.new(endpoint_arn: 'test1', client_args: { stub_responses: true })
  end

  def test_accepts_volume_id_as_hash
    AWSDMSEndpoint.new(endpoint_arn: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSDMSEndpoint.new(rubbish: 9) }
  end

  def test_endpoints_non_existing
    refute AWSDMSEndpoint.new(endpoint_arn: 'test1', client_args: { stub_responses: true }).exists?
  end

  def test_endpoints_non_existing_name
    refute AWSDMSEndpoint.new(endpoint_arn: 'not-there', client_args: { stub_responses: true }).exists?
  end
end

class AWSDMSEndpointConstructorNameIdTest < Minitest::Test
  def setup
    data = {}
    data[:method] = :describe_endpoints
    mock_data = {}
    mock_data[:endpoint_arn] = 'test1'
    data[:data] = { :endpoints => [mock_data] }
    data[:client] = Aws::DatabaseMigrationService::Client
    @endpoints = AWSDMSEndpoint.new(endpoint_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_endpoint_arn
    assert_equal(@endpoints.endpoint_arn, 'test1')
  end

  def test_vol_exists
    assert @endpoints.exists?
  end
end

class AWSDMSEndpointHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_endpoints
    mock_data = {}
    mock_data[:endpoint_identifier] = 'test1'
    mock_data[:endpoint_type] = 'test1'
    mock_data[:engine_name] = 'test1'
    data[:data] = { :endpoints => [mock_data] }
    data[:client] = Aws::DatabaseMigrationService::Client
    @endpoints = AWSDMSEndpoint.new(endpoint_arn: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_endpoints_exists
    assert @endpoints.exists?
  end

  def test_endpoint_identifier
    assert_equal(@endpoints.endpoint_identifier, 'test1')
  end

  def test_endpoint_type
    assert_equal(@endpoints.endpoint_type, 'test1')
  end

  def test_engine_name
    assert_equal(@endpoints.engine_name, 'test1')
  end
end