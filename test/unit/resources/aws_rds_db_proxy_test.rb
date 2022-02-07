require 'helper'
require 'aws_rds_db_proxy'
require 'aws-sdk-core'

class AWSRDSProxyConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSRDSProxy.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSRDSProxy.new(db_proxy_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSRDSProxy.new(unexpected: 9) }
  end
end

class AWSRDSProxySuccessPathTest < Minitest::Test

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
    @resp = AWSRDSProxy.new(db_proxy_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_db_proxies_exist
    assert @resp.exists?
  end

  def test_db_proxy_name
    assert_equal(@resp.db_proxy_name, 'test1')
  end

  def test_db_proxy_arn
    assert_equal(@resp.db_proxy_arn, 'test1')
  end

  def test_status
    assert_equal(@resp.status, 'test1')
  end

  def test_engine_family
    assert_equal(@resp.engine_family, 'test1')
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

  def test_auth_description
    assert_equal(@resp.auth[0].description, 'test1')
  end

  def test_auth_user_name
    assert_equal(@resp.auth[0].user_name, 'test1')
  end

  def test_auth_auth_scheme
    assert_equal(@resp.auth[0].auth_scheme, 'test1')
  end

  def test_auth_secret_arn
    assert_equal(@resp.auth[0].secret_arn, 'test1')
  end

  def test_auth_iam_auth
    assert_equal(@resp.auth[0].iam_auth, 'test1')
  end

  def test_role_arn
    assert_equal(@resp.role_arn, 'test1')
  end

  def test_endpoint
    assert_equal(@resp.endpoint, 'test1')
  end

  def test_require_tls
    assert_equal(@resp.require_tls, true)
  end

  def test_idle_client_timeout
    assert_equal(@resp.idle_client_timeout, 1)
  end

  def test_debug_logging
    assert_equal(@resp.debug_logging, true)
  end
end
