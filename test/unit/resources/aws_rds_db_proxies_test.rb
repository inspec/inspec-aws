require 'helper'
require 'aws_rds_db_proxies'
require 'aws-sdk-core'

class AWSRDSProxiesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSProxies.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSProxies.new(db_proxy_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSProxies.new(unexpected: 9) }
  end
end

class AWSRDSProxiesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_db_proxies
    mock_data = {}
    mock_data[:db_proxy_name] = 'test1'
    mock_data[:db_proxy_arn] = 'test1'
    mock_data[:status] = 'test1'
    mock_data[:engine_family] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:vpc_security_group_ids] = ['test1']
    mock_data[:vpc_subnet_ids] = ['test1']
    mock_data[:auth] = [
      description: 'test1',
      user_name: 'test1',
      auth_scheme: 'test1',
      secret_arn: 'test1',
      iam_auth: 'test1',
    ]
    mock_data[:role_arn] = 'test1'
    mock_data[:endpoint] = 'test1'
    mock_data[:require_tls] = true
    mock_data[:idle_client_timeout] = 1
    mock_data[:debug_logging] = true
    mock_data[:created_date] = Time.now
    mock_data[:updated_date] = Time.now
    data[:data] = { db_proxies: [mock_data] }
    data[:client] = Aws::RDS::Client
    @resp = AWSRDSProxies.new(db_proxy_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_proxies_exist
    assert @resp.exists?
  end

  def test_db_proxy_names
    assert_equal(@resp.db_proxy_names, ['test1'])
  end

  def test_db_proxy_arns
    assert_equal(@resp.db_proxy_arns, ['test1'])
  end

  def test_statuses
    assert_equal(@resp.statuses, ['test1'])
  end

  def test_engine_families
    assert_equal(@resp.engine_families, ['test1'])
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

  def test_role_arns
    assert_equal(@resp.role_arns, ['test1'])
  end

  def test_endpoints
    assert_equal(@resp.endpoints, ['test1'])
  end

  def test_require_tls
    assert_equal(@resp.require_tls, [true])
  end

  def test_idle_client_timeouts
    assert_equal(@resp.idle_client_timeouts, [1])
  end

  def test_debug_loggings
    assert_equal(@resp.debug_loggings, [true])
  end
end
