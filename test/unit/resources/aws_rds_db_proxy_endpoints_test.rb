require 'helper'
require 'aws_rds_db_proxy_endpoints'
require 'aws-sdk-core'

class AWSRDSProxyEndpointsConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSProxyEndpoints.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSProxyEndpoints.new(db_proxy_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSProxyEndpoints.new(unexpected: 9) }
  end
end

class AWSRDSProxyEndpointsSuccessPathTest < Minitest::Test

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
    @resp = AWSRDSProxyEndpoints.new(db_proxy_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_proxy_endpoints_exist
    assert @resp.exists?
  end

  def test_db_proxy_endpoint_names
    assert_equal(@resp.db_proxy_endpoint_names, ['test1'])
  end

  def test_db_proxy_endpoint_arns
    assert_equal(@resp.db_proxy_endpoint_arns, ['test1'])
  end

  def test_db_proxy_names
    assert_equal(@resp.db_proxy_names, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end

  def test_vpc_ids
    assert_equal(@resp.vpc_ids, ['test1'])
  end

  def test_vpc_security_group_ids
    assert_equal(@resp.vpc_security_group_ids, [['test1']])
  end

  def test_vpc_subnet_ids
    assert_equal(@resp.vpc_subnet_ids, [['test1']])
  end

  def test_endpoints
    assert_equal(@resp.endpoints, ['test1'])
  end

  def test_target_roles
    assert_equal(@resp.target_roles, ['test1'])
  end

  def test_is_default
    assert_equal(@resp.is_default, [true])
  end
end
