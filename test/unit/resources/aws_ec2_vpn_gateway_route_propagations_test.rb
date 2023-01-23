require 'helper'
require 'aws_ec2_vpn_gateway_route_propagations'
require 'aws-sdk-core'

class AWSEc2VPNGatewayRoutePropagationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEc2VPNGatewayRoutePropagations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEc2VPNGatewayRoutePropagations.new('rubbish') }
  end

  def test_route_tables_non_existing_for_empty_response
    refute AWSEc2VPNGatewayRoutePropagations.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEc2VPNGatewayRoutePropagationsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_route_tables
    mock_data = {}
    mock_data[:route_table_id] = 'test1'
    mock_data[:propagating_vgws] = []
    data[:data] = { :route_tables => [mock_data] }
    data[:client] = Aws::EC2::Client
    @route_tables = AWSEc2VPNGatewayRoutePropagations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_route_tables_exists
    assert @route_tables.exists?
  end
end