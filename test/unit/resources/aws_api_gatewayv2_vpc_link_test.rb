require 'helper'
require 'aws_api_gatewayv2_vpc_link'
require 'aws-sdk-core'

class AWSApiGatewayV2VPCLinkConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2VPCLink.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2VPCLink.new(vpc_link_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2VPCLink.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2VPCLinkSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_vpc_link
    mock_data = {}
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:name] = 'test1'
    mock_data[:security_group_ids] = []
    mock_data[:subnet_ids] = []
    mock_data[:tags] = {}
    mock_data[:vpc_link_id] = 'test1'
    mock_data[:vpc_link_status] = 'test1'
    mock_data[:vpc_link_status_message] = 'test1'
    mock_data[:vpc_link_version] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2VPCLink.new(vpc_link_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_link_exists
    assert @resp.exists?
  end

  def test_created_date
    assert_equal(@resp.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_security_group_ids
    assert_equal(@resp.security_group_ids, [])
  end

  def test_subnet_ids
    assert_equal(@resp.subnet_ids, [])
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end

  def test_vpc_link_id
    assert_equal(@resp.vpc_link_id, 'test1')
  end

  def test_vpc_link_status
    assert_equal(@resp.vpc_link_status, 'test1')
  end

  def test_vpc_link_status_message
    assert_equal(@resp.vpc_link_status_message, 'test1')
  end

  def test_vpc_link_version
    assert_equal(@resp.vpc_link_version, 'test1')
  end
end
