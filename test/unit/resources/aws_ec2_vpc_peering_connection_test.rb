require 'helper'
require 'aws_ec2_vpc_peering_connection'
require 'aws-sdk-core'

class AWSEc2VPCPeeringConnectionConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSEc2VPCPeeringConnection.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSEc2VPCPeeringConnection.new(vpc_peering_connection_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSEc2VPCPeeringConnection.new(unexpected: 9) }
  end
end

class AWSEc2VPCPeeringConnectionSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpc_peering_connections
    mock_data = {}
    mock_data[:accepter_vpc_info] = {}
    mock_data[:requester_vpc_info] = {}
    mock_data[:status] = {}
    mock_data[:tags] = []
    mock_data[:vpc_peering_connection_id] = "test1"
    data[:data] = { vpc_peering_connections: [mock_data] }
    data[:client] = Aws::EC2::Client
    @vpc_peering_connections = AWSEc2VPCPeeringConnection.new(vpc_peering_connection_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_peering_connections_exists
    assert @vpc_peering_connections.exists?
  end

  def test_accepter_vpc_info
    assert_equal(@vpc_peering_connections.accepter_vpc_info, {})
  end

  def test_requester_vpc_info
    assert_equal(@vpc_peering_connections.requester_vpc_info, {})
  end

  def test_status
    assert_equal(@vpc_peering_connections.status, {})
  end

  def test_tags
    assert_equal(@vpc_peering_connections.tags, {})
  end

  def test_vpc_peering_connection_id
    assert_equal(@vpc_peering_connections.vpc_peering_connection_id, "test1")
  end
end