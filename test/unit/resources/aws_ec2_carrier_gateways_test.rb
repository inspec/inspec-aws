require 'helper'
require 'aws_ec2_carrier_gateways'
require 'aws-sdk-core'

class AWSEC2CarrierGatewaysConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2CarrierGateways.new(client_args: { stub_responses: true })
  end

  def test_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEC2CarrierGateways.new(unexpected: 9, client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEC2CarrierGateways.new(unexpected: 9) }
  end
end

class AWSEC2CarrierGatewaysSuccessPathTest < Minitest::Test

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
    @resp = AWSEC2CarrierGateways.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_customer_gateways_exists
    assert @resp.exists?
  end

  def test_vpc_ids
    assert_equal(@resp.vpc_ids, ['test1'])
  end

  def test_carrier_gateway_ids
    assert_equal(@resp.carrier_gateway_ids, ['test1'])
  end

  def test_states
    assert_equal(@resp.states, ['test1'])
  end

  def test_owner_ids
    assert_equal(@resp.owner_ids, ['test1'])
  end

  def test_tags
    assert_equal(@resp.tags,  [[]])
  end
end