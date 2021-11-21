require 'helper'
require 'aws_rds_db_proxy_target_group'
require 'aws-sdk-core'

class AWSRDSProxyTargetGroupConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSProxyTargetGroup.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSProxyTargetGroup.new(db_proxy_name: '', target_group_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSProxyTargetGroup.new(unexpected: 9) }
  end
end

class AWSRDSProxyTargetGroupSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_proxy_target_groups
    mock_data = {}
    mock_data[:db_proxy_name] = 'test1'
    mock_data[:target_group_name] = 'test1'
    mock_data[:target_group_arn] = 'test1'
    mock_data[:is_default] = true
    mock_data[:status] = 'test1'
    mock_data[:connection_pool_config] = {
      max_connections_percent: 1,
      max_idle_connections_percent: 1,
      connection_borrow_timeout: 1,
      session_pinning_filters: ['test1'],
      init_query: 'test1'
    }
    mock_data[:created_date] = Time.now
    mock_data[:updated_date] = Time.now
    data[:data] = { target_groups: [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSProxyTargetGroup.new(db_proxy_name: 'test1', target_group_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_target_groups_exist
    assert @resp.exists?
  end

  def db_proxy_name
    assert_equal(@resp.db_proxy_name, 'test1')
  end

  def target_group_name
    assert_equal(@resp.target_group_name, 'test1')
  end

  def target_group_arn
    assert_equal(@resp.target_group_arn, 'test1')
  end

  def is_default
    assert_equal(@resp.is_default, true)
  end

  def status
    assert_equal(@resp.status, 'test1')
  end

  def connection_pool_config_max_connections_percent
    assert_equal(@resp.connection_pool_config.max_connections_percent, 1)
  end

  def connection_pool_config_max_idle_connections_percent
    assert_equal(@resp.connection_pool_config.max_idle_connections_percent, 1)
  end

  def connection_pool_config_connection_borrow_timeout
    assert_equal(@resp.connection_pool_config.connection_borrow_timeout, 1)
  end

  def connection_pool_config_session_pinning_filters
    assert_equal(@resp.connection_pool_config.session_pinning_filters, ['test1'])
  end

  def connection_pool_config_init_query
    assert_equal(@resp.connection_pool_config.init_query, 'test1')
  end
end
