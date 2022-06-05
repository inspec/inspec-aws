require 'helper'
require 'aws_ec2_vpn_gateway_route_propagation'
require 'aws-sdk-core'

class AWSEc2VPNGatewayRoutePropagationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2VPNGatewayRoutePropagation.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEc2VPNGatewayRoutePropagation.new(route_table_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2VPNGatewayRoutePropagation.new(unexpected: 9) }
  end
end

class AWSEc2VPNGatewayRoutePropagationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_route_tables
    mock_data = {}
    mock_data[:route_table_id] = 'rtb-1234567890'
    mock_data[:propagating_vgws] = []
    data[:data] = { route_tables: [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEc2VPNGatewayRoutePropagation.new(route_table_id: 'rtb-1234567890', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_route_tables_exists
    assert @resp.exists?
  end

  def test_route_table_id
    assert_equal(@resp.route_table_id, 'rtb-1234567890')
  end

  def test_propagating_vgws
    assert_equal(@resp.propagating_vgws, [])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, @resp.route_table_id)
  end
end
