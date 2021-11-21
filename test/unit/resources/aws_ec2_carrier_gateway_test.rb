require 'helper'
require 'aws_ec2_carrier_gateway'
require 'aws-sdk-core'

class AWSEC2CarrierGatewayConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEC2CarrierGateway.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2CarrierGateway.new(carrier_gateway_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2CarrierGateway.new(unexpected: 9) }
  end
end

class AWSEC2CarrierGatewaySuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_carrier_gateways
    mock_data = {}
    mock_data[:carrier_gateway_id] = 'test1'
    mock_data[:state] = 'test1'
    mock_data[:vpc_id] = 'test1'
    mock_data[:owner_id] = 'test1'
    mock_data[:tags] = []
    data[:data] = { carrier_gateways: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2CarrierGateway.new(carrier_gateway_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_customer_gateways_exists
    assert @resp.exists?
  end

  def test_vpc_id
    assert_equal(@resp.vpc_id, 'test1')
  end

  def test_carrier_gateway_id
    assert_equal(@resp.carrier_gateway_id, 'test1')
  end

  def test_state
    assert_equal(@resp.state, 'test1')
  end

  def test_owner_id
    assert_equal(@resp.owner_id, 'test1')
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end