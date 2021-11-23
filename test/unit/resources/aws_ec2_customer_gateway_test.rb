require 'helper'
require 'aws_ec2_customer_gateway'
require 'aws-sdk-core'

class AWSEC2CustomerGatewayConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2CustomerGateway.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2CustomerGateway.new(customer_gateway_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2CustomerGateway.new(unexpected: 9) }
  end
end

class AWSEC2CustomerGatewaySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_customer_gateways
    mock_data = {}
    mock_data[:bgp_asn] = 'test1'
    mock_data[:customer_gateway_id] = 'test1'
    mock_data[:ip_address] = 'test1'
    mock_data[:certificate_arn] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:device_name] = 'test1'
    mock_data[:tags] = []
    data[:data] = { customer_gateways: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2CustomerGateway.new(customer_gateway_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_customer_gateways_exists
    assert @resp.exists?
  end

  def test_bgp_asn
    assert_equal(@resp.bgp_asn, 'test1')
  end

  def test_customer_gateway_id
    assert_equal(@resp.customer_gateway_id, 'test1')
  end

  def test_ip_address
    assert_equal(@resp.ip_address, 'test1')
  end

  def test_certificate_arn
    assert_equal(@resp.certificate_arn, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_type
    assert_equal(@resp.type, 'test1')
  end

  def test_device_name
    assert_equal(@resp.device_name, 'test1')
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end
