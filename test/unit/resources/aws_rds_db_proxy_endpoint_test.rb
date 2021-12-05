require 'helper'
require 'aws_rds_db_proxy_endpoint'
require 'aws-sdk-core'

class AWSRDSProxyEndpointConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSProxyEndpoint.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSProxyEndpoint.new(db_proxy_name: '', db_proxy_endpoint_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSProxyEndpoint.new(unexpected: 9) }
  end
end

class AWSRDSProxyEndpointSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_proxy_endpoints
    mock_data = {}
    mock_data[:db_proxy_endpoint_name] = 'test1'
    mock_data[:db_proxy_endpoint_arn] = 'test1'
    mock_data[:db_proxy_name] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:vpc_security_group_ids] = ['test1']
    mock_data[:vpc_subnet_ids] = ['test1']
    mock_data[:endpoint] = 'test1'
    mock_data[:created_date] = Time.now
    mock_data[:target_role] = 'test1'
    mock_data[:is_default] = true
    data[:data] = { db_proxy_endpoints: [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSProxyEndpoint.new(db_proxy_name: 'test1', db_proxy_endpoint_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_proxy_endpoints_exist
    assert @resp.exists?
  end

  def test_db_proxy_endpoint_name
    assert_equal(@resp.db_proxy_endpoint_name, 'test1')
  end

  def test_db_proxy_endpoint_arn
    assert_equal(@resp.db_proxy_endpoint_arn, 'test1')
  end

  def test_db_proxy_name
    assert_equal(@resp.db_proxy_name, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end

  def test_vpc_id
    assert_equal(@resp.vpc_id, 'test1')
  end

  def test_vpc_security_group_ids
    assert_equal(@resp.vpc_security_group_ids, ['test1'])
  end

  def test_vpc_subnet_ids
    assert_equal(@resp.vpc_subnet_ids, ['test1'])
  end

  def test_endpoint
    assert_equal(@resp.endpoint, 'test1')
  end

  def test_target_role
    assert_equal(@resp.target_role, 'test1')
  end

  def test_is_default
    assert_equal(@resp.is_default, true)
  end
end
