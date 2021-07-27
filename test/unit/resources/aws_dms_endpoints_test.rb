require 'helper'
require 'aws_dms_endpoints'
require 'aws-sdk-core'

class AWSDMSEndpointsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSDMSEndpoints.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSDMSEndpoints.new('rubbish') }
  end

  def test_endpoint_non_existing_for_empty_response
    refute AWSDMSEndpoints.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSDMSEndpointsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_endpoints
    mock_parameter = {}
    mock_parameter[:endpoint_identifier] = 'test1'
    mock_parameter[:endpoint_type] = 'test1'
    mock_parameter[:engine_name] = 'test1'
    mock_parameter[:engine_display_name] = 'test1'
    mock_parameter[:username] = 'test1'
    mock_parameter[:server_name] = 'test1'
    mock_parameter[:port] = 1
    mock_parameter[:database_name] = 'test1'
    mock_parameter[:status] = 'test1'
    mock_parameter[:kms_key_id] = 'test1'
    mock_parameter[:endpoint_arn] = 'test1'
    mock_parameter[:certificate_arn] = 'test1'
    mock_parameter[:ssl_mode] = 'test1'
    mock_parameter[:service_access_role_arn] = 'test1'
    mock_parameter[:external_table_definition] = 'test1'
    mock_parameter[:external_id] = 'test1'
    data[:data] = { :endpoints => [mock_parameter] }
    data[:client] = Aws::DatabaseMigrationService::Client
    @endpoints = AWSDMSEndpoints.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_endpoint_identifiers
    assert_equal(@endpoints.endpoint_identifiers, ['test1'])
  end

  def test_endpoint_types
    assert_equal(@endpoints.endpoint_types, ['test1'])
  end

  def test_engine_names
    assert_equal(@endpoints.engine_names, ['test1'])
  end

  def test_engine_display_names
    assert_equal(@endpoints.engine_display_names, ['test1'])
  end

  def test_usernames
    assert_equal(@endpoints.usernames, ['test1'])
  end

  def test_server_names
    assert_equal(@endpoints.server_names, ['test1'])
  end

  def test_kms_key_ids
    assert_equal(@endpoints.kms_key_ids, ['test1'])
  end

  def test_certificate_arns
    assert_equal(@endpoints.certificate_arns, ['test1'])
  end

  def test_ssl_modes
    assert_equal(@endpoints.ssl_modes, ['test1'])
  end

  def test_service_access_role_arns
    assert_equal(@endpoints.service_access_role_arns, ['test1'])
  end

  def test_external_table_definitions
    assert_equal(@endpoints.external_table_definitions, ['test1'])
  end

  def external_ids
    assert_equal(@endpoints.external_ids, ['test1'])
  end

  def test_ports
    assert_equal(@endpoints.ports, [1])
  end

  def test_database_names
    assert_equal(@endpoints.database_names, ['test1'])
  end

  def test_statuses
    assert_equal(@endpoints.statuses, ['test1'])
  end
end