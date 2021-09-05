require 'helper'
require 'aws_ec2_vpc_peering_connections'
require 'aws-sdk-core'

class AWSEC2VPCPeeringConnectionsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSEC2VPCPeeringConnections.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSEC2VPCPeeringConnections.new('rubbish') }
  end

  def test_vpc_peer_connections_non_existing_for_empty_response
    refute AWSEC2VPCPeeringConnections.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSEC2VPCPeeringConnectionsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_vpc_peering_connections
    mock_data = {}
    mock_data[:vpc_peering_connection_id] = "test1"
    mock_data[:status] = {
      code: "test1",
      message: "test1"
    }
    data[:data] = { :vpc_peering_connections => [mock_data] }
    data[:client] = Aws::EC2::Client
    @resp = AWSEC2VPCPeeringConnections.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_vpc_peering_connections_exists
    assert @resp.exist?
  end

  def test_vpc_peering_connection_ids
    assert_equal(@resp.vpc_peering_connection_ids, ["test1"])
  end
end